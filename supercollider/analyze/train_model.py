#!/usr/bin/env python
"""
LSTM Model Training for Music Generation
Trains separate models for pitch and temporal interval sequences
"""

import numpy as np
import pickle
import tensorflow as tf
from tensorflow import keras
from tensorflow.keras import layers
from sklearn.model_selection import train_test_split
import json

class MusicLSTMTrainer:
    def __init__(self, features_file='music_features.pkl'):
        with open(features_file, 'rb') as f:
            self.features = pickle.load(f)

        self.pitch_model = None
        self.rhythm_model = None

    def prepare_pitch_sequences(self, sequence_length=20):
        """Prepare pitch sequences for LSTM training"""
        sequences = []
        next_notes = []

        for feature in self.features:
            notes = feature['notes']

            # Create overlapping sequences
            for i in range(len(notes) - sequence_length):
                seq = notes[i:i + sequence_length]
                next_note = notes[i + sequence_length]
                sequences.append(seq)
                next_notes.append(next_note)

        # Convert to numpy arrays
        X = np.array(sequences)
        y = np.array(next_notes)

        print(f"Pitch sequences shape: {X.shape}")
        print(f"Pitch targets shape: {y.shape}")
        print(f"Note range: {y.min()} - {y.max()}")

        # Normalize MIDI notes to [0, 1]
        X_norm = (X - 21) / (108 - 21)  # MIDI range 21-108 (A0 to C8)
        y_norm = (y - 21) / (108 - 21)

        return X_norm, y_norm, (21, 108)  # Return normalization params

    def prepare_rhythm_sequences(self, sequence_length=20):
        """Prepare rhythm (IOI) sequences for LSTM training"""
        sequences = []
        next_iois = []

        for feature in self.features:
            ioi_quantized = feature['ioi_quantized']

            if len(ioi_quantized) < sequence_length + 1:
                continue

            # Create overlapping sequences
            for i in range(len(ioi_quantized) - sequence_length):
                seq = ioi_quantized[i:i + sequence_length]
                next_ioi = ioi_quantized[i + sequence_length]
                sequences.append(seq)
                next_iois.append(next_ioi)

        # Convert to numpy arrays
        X = np.array(sequences)
        y = np.array(next_iois)

        print(f"Rhythm sequences shape: {X.shape}")
        print(f"Rhythm targets shape: {y.shape}")
        print(f"IOI range: {y.min():.4f} - {y.max():.4f}")

        # Log transform for better scaling
        X_norm = np.log1p(X)
        y_norm = np.log1p(y)

        return X_norm, y_norm

    def build_pitch_model(self, sequence_length=20, lstm_units=128):
        """Build LSTM model for pitch prediction"""
        model = keras.Sequential([
            layers.Input(shape=(sequence_length, 1)),
            layers.LSTM(lstm_units, return_sequences=True),
            layers.Dropout(0.3),
            layers.LSTM(lstm_units),
            layers.Dropout(0.3),
            layers.Dense(64, activation='relu'),
            layers.Dense(1)  # Regression output for normalized MIDI note
        ])

        model.compile(
            optimizer='adam',
            loss='mse',
            metrics=['mae']
        )

        return model

    def build_rhythm_model(self, sequence_length=20, lstm_units=64):
        """Build LSTM model for rhythm (IOI) prediction"""
        model = keras.Sequential([
            layers.Input(shape=(sequence_length, 1)),
            layers.LSTM(lstm_units, return_sequences=True),
            layers.Dropout(0.3),
            layers.LSTM(lstm_units),
            layers.Dropout(0.3),
            layers.Dense(32, activation='relu'),
            layers.Dense(1)  # Regression output for log-transformed IOI
        ])

        model.compile(
            optimizer='adam',
            loss='mse',
            metrics=['mae']
        )

        return model

    def train_pitch_model(self, epochs=50, batch_size=64, sequence_length=20):
        """Train the pitch prediction model"""
        print("\n=== Training Pitch Model ===")

        # Prepare data
        X, y, norm_params = self.prepare_pitch_sequences(sequence_length)

        # Reshape for LSTM (samples, timesteps, features)
        X = X.reshape(X.shape[0], X.shape[1], 1)

        # Split data
        X_train, X_val, y_train, y_val = train_test_split(
            X, y, test_size=0.2, random_state=42
        )

        # Build model
        self.pitch_model = self.build_pitch_model(sequence_length)
        print(self.pitch_model.summary())

        # Train
        history = self.pitch_model.fit(
            X_train, y_train,
            validation_data=(X_val, y_val),
            epochs=epochs,
            batch_size=batch_size,
            callbacks=[
                keras.callbacks.EarlyStopping(
                    patience=10, restore_best_weights=True
                ),
                keras.callbacks.ReduceLROnPlateau(
                    factor=0.5, patience=5
                )
            ]
        )

        # Save model
        self.pitch_model.save('pitch_lstm_model.keras')
        print("\nPitch model saved to pitch_lstm_model.keras")

        # Save normalization params
        with open('pitch_norm_params.json', 'w') as f:
            json.dump({'min': norm_params[0], 'max': norm_params[1]}, f)

        return history

    def train_rhythm_model(self, epochs=50, batch_size=64, sequence_length=20):
        """Train the rhythm (IOI) prediction model"""
        print("\n=== Training Rhythm Model ===")

        # Prepare data
        X, y = self.prepare_rhythm_sequences(sequence_length)

        # Reshape for LSTM
        X = X.reshape(X.shape[0], X.shape[1], 1)

        # Split data
        X_train, X_val, y_train, y_val = train_test_split(
            X, y, test_size=0.2, random_state=42
        )

        # Build model
        self.rhythm_model = self.build_rhythm_model(sequence_length)
        print(self.rhythm_model.summary())

        # Train
        history = self.rhythm_model.fit(
            X_train, y_train,
            validation_data=(X_val, y_val),
            epochs=epochs,
            batch_size=batch_size,
            callbacks=[
                keras.callbacks.EarlyStopping(
                    patience=10, restore_best_weights=True
                ),
                keras.callbacks.ReduceLROnPlateau(
                    factor=0.5, patience=5
                )
            ]
        )

        # Save model
        self.rhythm_model.save('rhythm_lstm_model.keras')
        print("\nRhythm model saved to rhythm_lstm_model.keras")

        return history

    def generate_sequence(self, seed_notes, seed_ioi, num_steps=50):
        """Generate a music sequence using both models"""
        if self.pitch_model is None or self.rhythm_model is None:
            # Load models if not already loaded
            self.pitch_model = keras.models.load_model('pitch_lstm_model.keras')
            self.rhythm_model = keras.models.load_model('rhythm_lstm_model.keras')

        # Load normalization params
        with open('pitch_norm_params.json', 'r') as f:
            norm_params = json.load(f)

        generated_notes = list(seed_notes)
        generated_ioi = list(seed_ioi)

        sequence_length = len(seed_notes)

        for _ in range(num_steps):
            # Predict next note
            pitch_input = np.array(generated_notes[-sequence_length:])
            pitch_input = (pitch_input - norm_params['min']) / (norm_params['max'] - norm_params['min'])
            pitch_input = pitch_input.reshape(1, sequence_length, 1)
            next_note_norm = self.pitch_model.predict(pitch_input, verbose=0)[0][0]
            next_note = int(np.round(next_note_norm * (norm_params['max'] - norm_params['min']) + norm_params['min']))
            next_note = np.clip(next_note, 21, 108)  # Clip to valid MIDI range
            generated_notes.append(next_note)

            # Predict next IOI
            rhythm_input = np.array(generated_ioi[-sequence_length:])
            rhythm_input = np.log1p(rhythm_input)
            rhythm_input = rhythm_input.reshape(1, sequence_length, 1)
            next_ioi_log = self.rhythm_model.predict(rhythm_input, verbose=0)[0][0]
            next_ioi = np.expm1(next_ioi_log)
            next_ioi = max(0.1, next_ioi)  # Ensure positive IOI
            generated_ioi.append(next_ioi)

        return generated_notes[sequence_length:], generated_ioi[sequence_length:]


if __name__ == '__main__':
    trainer = MusicLSTMTrainer('music_features.pkl')

    # Train both models
    print("Training models...")
    pitch_history = trainer.train_pitch_model(epochs=100, sequence_length=20)
    rhythm_history = trainer.train_rhythm_model(epochs=100, sequence_length=20)

    print("\n=== Training Complete ===")
    print("Models saved:")
    print("  - pitch_lstm_model.keras")
    print("  - rhythm_lstm_model.keras")
    print("  - pitch_norm_params.json")

    # Test generation
    print("\n=== Testing Generation ===")
    # Use first sequence from training data as seed
    first_feature = trainer.features[0]
    seed_notes = first_feature['notes'][:20]
    seed_ioi = first_feature['ioi_quantized'][:20]

    generated_notes, generated_ioi = trainer.generate_sequence(
        seed_notes, seed_ioi, num_steps=30
    )

    print(f"Generated {len(generated_notes)} notes")
    print(f"Sample notes: {generated_notes[:10]}")
    print(f"Sample IOI: {[f'{x:.3f}' for x in generated_ioi[:10]]}")
