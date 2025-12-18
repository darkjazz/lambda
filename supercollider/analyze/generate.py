#!/usr/bin/env python
"""
Generate musical sequences using trained LSTM models
Usage: python generate.py [num_notes] [--seed-notes NOTE1,NOTE2,...] [--seed-ioi IOI1,IOI2,...] [--pitch-temp TEMP] [--rhythm-temp TEMP]

Temperature controls randomness:
  --pitch-temp: 1.0-5.0 (default 2.0) - higher = more varied notes
  --rhythm-temp: 0.2-1.0 (default 0.5) - higher = more varied rhythms
"""

import sys
import json
import numpy as np
from tensorflow import keras

def load_models():
    """Load trained models and normalization params"""
    pitch_model = keras.models.load_model('pitch_lstm_model.keras')
    rhythm_model = keras.models.load_model('rhythm_lstm_model.keras')

    with open('pitch_norm_params.json', 'r') as f:
        norm_params = json.load(f)

    return pitch_model, rhythm_model, norm_params

def generate_sequence(pitch_model, rhythm_model, norm_params,
                     num_notes=20, seed_notes=None, seed_ioi=None,
                     pitch_temperature=2.0, rhythm_temperature=0.5):
    """Generate a music sequence with temperature-based randomness

    Args:
        pitch_temperature: Higher = more random notes (try 1.0-5.0)
        rhythm_temperature: Higher = more random rhythms (try 0.2-1.0)
    """
    # Default seed sequences if none provided
    if seed_notes is None:
        seed_notes = [60, 62, 64, 65, 67]  # C major scale
    if seed_ioi is None:
        seed_ioi = [0.5, 0.5, 0.5, 0.5, 0.5]  # Eighth notes at 120 BPM

    generated_notes = list(seed_notes)
    generated_ioi = list(seed_ioi)

    # Use the pitch sequence length (should match for both)
    sequence_length = min(len(seed_notes), len(seed_ioi))

    for _ in range(num_notes):
        # Predict next note with temperature-based randomness
        pitch_input = np.array(generated_notes[-sequence_length:])
        pitch_input = (pitch_input - norm_params['min']) / (norm_params['max'] - norm_params['min'])
        pitch_input = pitch_input.reshape(1, sequence_length, 1)
        next_note_norm = pitch_model.predict(pitch_input, verbose=0)[0][0]

        # Add Gaussian noise scaled by temperature
        noise = np.random.normal(0, pitch_temperature * 0.02)  # 0.02 in normalized space
        next_note_norm = next_note_norm + noise

        next_note = int(np.round(next_note_norm * (norm_params['max'] - norm_params['min']) + norm_params['min']))
        next_note = np.clip(next_note, 21, 108)
        generated_notes.append(next_note)

        # Predict next IOI with temperature-based randomness
        rhythm_input = np.array(generated_ioi[-sequence_length:])
        rhythm_input = np.log1p(rhythm_input)
        rhythm_input = rhythm_input.reshape(1, sequence_length, 1)
        next_ioi_log = rhythm_model.predict(rhythm_input, verbose=0)[0][0]

        # Add Gaussian noise to rhythm
        rhythm_noise = np.random.normal(0, rhythm_temperature * 0.1)
        next_ioi_log = next_ioi_log + rhythm_noise

        next_ioi = np.expm1(next_ioi_log)
        next_ioi = max(0.1, next_ioi)
        generated_ioi.append(next_ioi)

    return generated_notes[sequence_length:], generated_ioi[sequence_length:]

def notes_to_ratios(notes):
    """Convert MIDI notes to frequency ratios between consecutive notes"""
    if len(notes) < 2:
        return []

    ratios = []
    for i in range(len(notes) - 1):
        # Frequency ratio = 2^(semitone_diff / 12)
        semitone_diff = notes[i + 1] - notes[i]
        ratio = 2.0 ** (semitone_diff / 12.0)
        ratios.append(ratio)

    return ratios

def ioi_to_rhythm_pattern(ioi_value):
    """Convert IOI to amplitude pattern and delta value

    Returns: (delta_fraction, amp_array)
    delta_fraction: beat fraction (0.25 = 1/4, 0.125 = 1/8, etc.)
    amp_array: [1, 0, 0, ...] pattern for Pseq
    """
    # Quantize to standard subdivisions at 120 BPM
    # At 120 BPM, quarter note = 0.5 seconds
    beat_duration = 0.5  # quarter note at 120 BPM

    # Common subdivisions
    subdivisions = {
        4.0: (1.0, 4),      # whole note = 4 beats
        2.0: (0.5, 4),      # half note = 2 beats
        1.0: (0.25, 4),     # quarter note = 1 beat
        0.666: (0.25, 3),   # quarter triplet
        0.5: (0.125, 4),    # eighth note
        0.333: (0.125, 3),  # eighth triplet
        0.25: (0.0625, 4),  # sixteenth note
        0.166: (0.0625, 3), # sixteenth triplet
    }

    # Find nearest quantized value
    ioi_in_beats = ioi_value / beat_duration
    closest_key = min(subdivisions.keys(), key=lambda x: abs(x - ioi_in_beats))

    delta, num_steps = subdivisions[closest_key]

    # Create amplitude array: [1, 0, 0, ...] with length num_steps
    amp_array = [1] + [0] * (num_steps - 1)

    return (delta, amp_array)

def main():
    # Parse arguments
    num_notes = 20
    seed_notes = None
    seed_ioi = None
    pitch_temperature = 2.0
    rhythm_temperature = 0.5

    i = 1
    while i < len(sys.argv):
        arg = sys.argv[i]
        if arg == '--seed-notes' and i + 1 < len(sys.argv):
            seed_notes = [int(n) for n in sys.argv[i + 1].split(',')]
            i += 2
        elif arg == '--seed-ioi' and i + 1 < len(sys.argv):
            seed_ioi = [float(n) for n in sys.argv[i + 1].split(',')]
            i += 2
        elif arg == '--pitch-temp' and i + 1 < len(sys.argv):
            pitch_temperature = float(sys.argv[i + 1])
            i += 2
        elif arg == '--rhythm-temp' and i + 1 < len(sys.argv):
            rhythm_temperature = float(sys.argv[i + 1])
            i += 2
        elif arg.isdigit():
            num_notes = int(arg)
            i += 1
        else:
            i += 1

    # Load models
    pitch_model, rhythm_model, norm_params = load_models()

    # Generate sequence
    notes, ioi = generate_sequence(pitch_model, rhythm_model, norm_params,
                                   num_notes, seed_notes, seed_ioi,
                                   pitch_temperature, rhythm_temperature)

    # Convert notes to frequency ratios
    ratios = notes_to_ratios(notes)

    # Convert IOIs to rhythm patterns
    rhythm_patterns = []
    for ioi_val in ioi:
        delta, amp_array = ioi_to_rhythm_pattern(ioi_val)
        rhythm_patterns.append({
            'delta': delta,
            'amp': amp_array
        })

    # Output as JSON
    output = {
        'ratios': [float(r) for r in ratios],
        'rhythms': rhythm_patterns,
        # Keep original data for reference
        'notes': [int(n) for n in notes],
        'ioi': [float(i) for i in ioi]
    }

    print(json.dumps(output))

if __name__ == '__main__':
    main()
