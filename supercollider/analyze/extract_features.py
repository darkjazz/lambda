#!/usr/bin/env python
"""
Music Feature Extraction for LSTM Training
Extracts notes, onsets, and tempo from audio files for generative modeling
"""

import os
import glob
import numpy as np
import librosa
from pathlib import Path
import pickle
import json

# Audio file extensions to process
AUDIO_EXTENSIONS = ['*.wav', '*.mp3', '*.m4a', '*.WAV', '*.MP3', '*.M4A']

# Standard tempo for quantization
STANDARD_BPM = 120.0

class AudioFeatureExtractor:
    def __init__(self, audio_dir):
        self.audio_dir = Path(audio_dir).expanduser()

    def find_audio_files(self):
        """Recursively find all audio files"""
        audio_files = []
        for ext in AUDIO_EXTENSIONS:
            pattern = str(self.audio_dir / '**' / ext)
            audio_files.extend(glob.glob(pattern, recursive=True))

        print(f"Found {len(audio_files)} audio files")
        return sorted(audio_files)

    def extract_tempo(self, y, sr):
        """Extract tempo using librosa"""
        try:
            tempo, _ = librosa.beat.beat_track(y=y, sr=sr)
            return float(tempo) if tempo > 0 else STANDARD_BPM
        except Exception as e:
            print(f"  Tempo extraction failed: {e}")
            return STANDARD_BPM

    def extract_onsets(self, y, sr):
        """Extract onset times using librosa"""
        try:
            onset_frames = librosa.onset.onset_detect(y=y, sr=sr, backtrack=True)
            onset_times = librosa.frames_to_time(onset_frames, sr=sr)
            return onset_times
        except Exception as e:
            print(f"  Onset extraction failed: {e}")
            return np.array([])

    def extract_notes(self, audio_path, onsets):
        """Extract MIDI note numbers at onset positions using librosa"""
        try:
            y, sr = librosa.load(audio_path, sr=22050)

            # Use piptrack for pitch detection
            pitches, magnitudes = librosa.piptrack(y=y, sr=sr, threshold=0.1)

            notes = []
            for onset_time in onsets:
                # Convert onset time to frame
                frame = librosa.time_to_frames(onset_time, sr=sr)

                if frame < pitches.shape[1]:
                    # Get pitch at this frame
                    index = magnitudes[:, frame].argmax()
                    pitch_hz = pitches[index, frame]

                    if pitch_hz > 0:
                        # Convert Hz to MIDI note number
                        midi_note = librosa.hz_to_midi(pitch_hz)
                        notes.append(int(np.round(midi_note)))
                    else:
                        notes.append(None)  # No pitch detected
                else:
                    notes.append(None)

            return notes
        except Exception as e:
            print(f"Note extraction failed for {audio_path}: {e}")
            return [None] * len(onsets)

    def calculate_ioi(self, onsets):
        """Calculate inter-onset intervals"""
        if len(onsets) < 2:
            return np.array([])
        return np.diff(onsets)

    def quantize_ioi(self, ioi, tempo):
        """
        Quantize IOI to note values relative to 120 BPM
        Returns quantized values as fractions of a beat at 120 BPM
        """
        # Beat duration at detected tempo (in seconds)
        beat_duration_detected = 60.0 / tempo

        # Beat duration at standard tempo
        beat_duration_standard = 60.0 / STANDARD_BPM

        # Convert IOI to beats at detected tempo
        ioi_in_beats = ioi / beat_duration_detected

        # Quantize to common note divisions (whole, half, quarter, eighth, sixteenth, triplets)
        # Using 120 BPM as reference
        quantization_values = np.array([
            4.0,    # whole note
            2.0,    # half note
            1.0,    # quarter note
            0.5,    # eighth note
            0.25,   # sixteenth note
            0.666,  # quarter triplet
            0.333,  # eighth triplet
            0.166,  # sixteenth triplet
        ])

        quantized = []
        for interval in ioi_in_beats:
            # Find nearest quantization value
            idx = np.abs(quantization_values - interval).argmin()
            quantized.append(quantization_values[idx])

        return np.array(quantized)

    def process_file(self, audio_path):
        """Process a single audio file"""
        print(f"\nProcessing: {audio_path}")

        # Load audio file
        try:
            y, sr = librosa.load(audio_path, sr=22050)
        except Exception as e:
            print(f"  Failed to load audio: {e}")
            return None

        # Extract tempo
        tempo = self.extract_tempo(y, sr)
        print(f"  Tempo: {tempo:.2f} BPM")

        # Extract onsets
        onsets = self.extract_onsets(y, sr)
        print(f"  Onsets: {len(onsets)}")

        if len(onsets) < 2:
            print("  Skipping - not enough onsets")
            return None

        # Extract notes
        notes = self.extract_notes(audio_path, onsets)
        # Filter out None values
        valid_indices = [i for i, n in enumerate(notes) if n is not None]
        if len(valid_indices) < 2:
            print("  Skipping - not enough valid notes")
            return None

        notes_clean = [notes[i] for i in valid_indices]
        onsets_clean = onsets[valid_indices]

        # Calculate IOI
        ioi = self.calculate_ioi(onsets_clean)

        # Quantize IOI
        ioi_quantized = self.quantize_ioi(ioi, tempo)

        print(f"  Valid notes: {len(notes_clean)}")
        print(f"  Note range: {min(notes_clean)} - {max(notes_clean)}")

        return {
            'file': audio_path,
            'tempo': tempo,
            'notes': notes_clean,
            'onsets': onsets_clean.tolist(),
            'ioi': ioi.tolist(),
            'ioi_quantized': ioi_quantized.tolist()
        }

    def process_all(self, output_file='features.pkl'):
        """Process all audio files and save features"""
        audio_files = self.find_audio_files()

        all_features = []
        for audio_file in audio_files:
            features = self.process_file(audio_file)
            if features is not None:
                all_features.append(features)

        # Save features
        with open(output_file, 'wb') as f:
            pickle.dump(all_features, f)

        print(f"\n\nSaved {len(all_features)} file features to {output_file}")

        # Also save as JSON for inspection
        json_file = output_file.replace('.pkl', '.json')
        with open(json_file, 'w') as f:
            json.dump(all_features, f, indent=2)
        print(f"Saved JSON version to {json_file}")

        return all_features


if __name__ == '__main__':
    # Audio files location
    audio_dir = '~/snd/analyze/artists'

    extractor = AudioFeatureExtractor(audio_dir)
    features = extractor.process_all('music_features.pkl')

    # Print summary statistics
    total_notes = sum(len(f['notes']) for f in features)
    print(f"\n=== Summary ===")
    print(f"Total files processed: {len(features)}")
    print(f"Total notes extracted: {total_notes}")
