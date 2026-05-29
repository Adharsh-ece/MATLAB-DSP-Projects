% =========================================================
% 02_fft_analysis.m
% Fast Fourier Transform (FFT) Analysis
% Topics: FFT, frequency spectrum, magnitude & phase
% =========================================================

clear; clc; close all;

%% Parameters
fs = 1000;           % Sampling frequency (Hz)
T  = 1;              % Duration (seconds)
N  = fs * T;         % Number of samples
t  = (0:N-1) / fs;   % Time vector

%% Composite Signal: 50 Hz + 120 Hz + noise
f1 = 50;   A1 = 1.0;
f2 = 120;  A2 = 0.5;

x = A1 * sin(2*pi*f1*t) + A2 * sin(2*pi*f2*t) + 0.3*randn(size(t));

%% Compute FFT
X     = fft(x);
X_mag = abs(X/N);              % Normalized magnitude
X_mag = X_mag(1:N/2+1);        % Single-sided spectrum
X_mag(2:end-1) = 2*X_mag(2:end-1);

f_axis = fs * (0:(N/2)) / N;   % Frequency axis

%% Phase Spectrum
X_phase = angle(X);
X_phase = X_phase(1:N/2+1);

%% Plotting
figure('Name', 'FFT Analysis', 'NumberTitle', 'off');

subplot(3,1,1);
plot(t, x, 'b');
title('Original Signal (Time Domain)');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
plot(f_axis, X_mag, 'r');
title('Single-Sided Magnitude Spectrum');
xlabel('Frequency (Hz)'); ylabel('|X(f)|'); grid on;
xlim([0 fs/2]);

subplot(3,1,3);
plot(f_axis, X_phase, 'g');
title('Phase Spectrum');
xlabel('Frequency (Hz)'); ylabel('Phase (rad)'); grid on;
xlim([0 fs/2]);

sgtitle('FFT Analysis of a Composite Signal');

%% Print dominant frequencies
[~, idx] = sort(X_mag, 'descend');
fprintf('Top 3 dominant frequencies:\n');
for k = 1:3
    fprintf('  %.1f Hz  (magnitude = %.4f)\n', f_axis(idx(k)), X_mag(idx(k)));
end
