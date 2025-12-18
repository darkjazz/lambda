# Music Generation LSTM Model

Generative music model for live coding performances in SuperCollider, trained on audio from Pixies, Arvo Pärt, Radiohead, TR/ST, and Sigur Rós.

## Overview

This project extracts melodic and rhythmic features from audio files and trains LSTM models to generate new musical sequences. The models output:
- **Pitch sequences**: MIDI notes (will be converted to ratios later)
- **Temporal intervals**: Inter-onset intervals (IOI) quantized to 120 BPM

## Setup

### Conda Environment

```bash
conda create -n music-gen python=3.10 -y
conda activate music-gen

# Install dependencies
pip install Cython numpy
pip install --no-build-isolation madmom
conda install -c conda-forge numba -y
pip install tensorflow librosa matplotlib
```

## Scripts

### 1. Feature Extraction (`extract_features.py`)

Extracts musical features from audio files using madmom and librosa:

- **Onset detection**: Note attack times using madmom RNN
- **Tempo estimation**: BPM extraction for quantization
- **Pitch detection**: MIDI note numbers at each onset
- **IOI calculation**: Inter-onset intervals
- **Quantization**: Temporal data quantized to 120 BPM standard tempo

**Usage:**
```bash
python extract_features.py
```

**Output:**
- `music_features.pkl`: Pickled feature data
- `music_features.json`: Human-readable JSON version

### 2. Model Training (`train_model.py`)

Trains two separate LSTM models:

#### Pitch Model
- **Input**: Sequences of MIDI notes (normalized)
- **Output**: Next MIDI note prediction
- **Architecture**:
  - 2x LSTM layers (128 units each)
  - Dropout (0.3)
  - Dense layers for regression

#### Rhythm Model
- **Input**: Sequences of quantized IOI values
- **Output**: Next IOI prediction
- **Architecture**:
  - 2x LSTM layers (64 units each)
  - Dropout (0.3)
  - Log-transformed values for better scaling

**Usage:**
```bash
python train_model.py
```

**Output:**
- `pitch_lstm_model.keras`: Trained pitch model
- `rhythm_lstm_model.keras`: Trained rhythm model
- `pitch_norm_params.json`: Normalization parameters

## Data

### Audio Files
Location: `~/snd/analyze/artists`

Supported formats: WAV, MP3, M4A

Artists included:
- Pixies
- Arvo Pärt
- Radiohead
- TR/ST
- Sigur Rós

### Feature Structure

Each processed file contains:
```json
{
  "file": "path/to/audio.mp3",
  "tempo": 120.5,
  "notes": [60, 62, 64, ...],
  "onsets": [0.0, 0.5, 1.0, ...],
  "ioi": [0.5, 0.5, 0.75, ...],
  "ioi_quantized": [0.5, 0.5, 0.666, ...]
}
```

## Model Generation

### Command-line generation

Generate sequences using `generate.py`:

```bash
# Basic generation (20 notes with default seed and temperature)
python generate.py 20

# With custom seed sequences
python generate.py 30 --seed-notes 60,64,67,72 --seed-ioi 0.5,0.5,1.0,0.5

# Control randomness with temperature
python generate.py 20 --pitch-temp 2.0 --rhythm-temp 0.5
```

**Temperature parameters:**
- `--pitch-temp` (1.0-5.0, default 2.0): Controls pitch variation
  - Lower (1.0): Conservative, stays close to learned patterns
  - Higher (4.0+): Wild, wider melodic jumps
- `--rhythm-temp` (0.2-1.0, default 0.5): Controls rhythmic variation

### Python API

```python
from train_model import MusicLSTMTrainer

trainer = MusicLSTMTrainer()

# Seed sequences
seed_notes = [60, 62, 64, 65, 67]  # C, D, E, F, G
seed_ioi = [0.5, 0.5, 1.0, 0.5]     # Eighth, eighth, quarter, eighth

# Generate 50 new notes/intervals
generated_notes, generated_ioi = trainer.generate_sequence(
    seed_notes, seed_ioi, num_steps=50
)
```

## Quantization

Temporal intervals are quantized to standard rhythmic values at 120 BPM:
- 4.0 = Whole note
- 2.0 = Half note
- 1.0 = Quarter note
- 0.5 = Eighth note
- 0.25 = Sixteenth note
- 0.666 = Quarter triplet
- 0.333 = Eighth triplet
- 0.166 = Sixteenth triplet

The quantization accounts for the original tempo, converting IOI values to beats at the detected tempo, then finding the nearest standard division.

## Next Steps

- [ ] Complete feature extraction on all audio files
- [ ] Train both models (pitch and rhythm)
- [ ] Convert MIDI notes to frequency ratios
- [ ] Integrate with SuperCollider for live performance
- [ ] Create real-time generation interface

## Notes

- Models trained on melodies only (monophonic)
- All tracks quantized to 120 BPM reference tempo
- Temperature-based sampling prevents mean-regression issue

### Why Temperature?

The LSTM models use regression to predict continuous values (MIDI notes and IOI). Without noise, regression models tend to predict the expected value (mean) from training data, causing repetitive output that converges to the average pitch (~65/F4).

Temperature-based sampling adds controlled Gaussian noise to predictions, creating natural variation while still respecting learned patterns. Higher temperature = more randomness, lower = more conservative.
