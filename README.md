# DSP with MATLAB

A collection of clean, well-commented MATLAB scripts covering core **Digital Signal Processing (DSP)** concepts. Each file is self-contained and produces plots to visualize the concept.

---

## Files

| File | Topic | Key Concepts |
|------|-------|--------------|
| `01_signal_generation.m` | Basic Signals | Sine, cosine, square, sawtooth, noise |
| `02_fft_analysis.m` | FFT | Frequency spectrum, magnitude, phase |
| `03_fir_filter.m` | FIR Filters | Low-pass, high-pass, band-pass (window method) |
| `04_iir_filter.m` | IIR Filters | Butterworth, Chebyshev, Elliptic, pole-zero |
| `05_sampling_aliasing.m` | Sampling Theorem | Nyquist criterion, aliasing demonstration |
| `06_convolution_correlation.m` | Convolution & Correlation | Linear conv, auto/cross-correlation |
| `07_spectrogram_stft.m` | STFT / Spectrogram | Time-frequency analysis, chirp signals |

---

## Requirements

- MATLAB R2018b or later
- **Signal Processing Toolbox** (required for `fir1`, `butter`, `cheby1`, `ellip`, `spectrogram`, etc.)

---

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/YOUR_USERNAME/dsp-matlab.git
   cd dsp-matlab
   ```

2. Open MATLAB and navigate to the folder.

3. Run any script directly:
   ```matlab
   run('01_signal_generation.m')
   ```

Each script uses `clear; clc; close all;` at the top — safe to run independently.

---

## Topics Covered

- **Signal Generation** — standard waveforms and noise
- **Spectral Analysis** — FFT, single-sided magnitude & phase spectra
- **FIR Filter Design** — window method (Hamming), frequency response
- **IIR Filter Design** — analog prototype methods, `filtfilt` zero-phase filtering
- **Sampling Theory** — Nyquist theorem, aliasing visualization
- **Convolution** — linear convolution, delay detection via cross-correlation
- **Time-Frequency Analysis** — STFT, spectrogram, chirp signals

---

## License

MIT License — free to use and modify for learning purposes.
