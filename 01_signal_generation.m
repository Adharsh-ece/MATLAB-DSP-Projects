% =========================================================
% 01_signal_generation.m
% Basic Signal Generation in MATLAB
% Topics: Sine, Cosine, Square, Sawtooth, Noise
% =========================================================

clear; clc; close all;

%% Parameters
fs = 1000;          % Sampling frequency (Hz)
T  = 1;             % Duration (seconds)
t  = 0:1/fs:T-1/fs; % Time vector
f  = 5;             % Signal frequency (Hz)

%% 1. Sine Wave
sine_wave = sin(2 * pi * f * t);

%% 2. Cosine Wave
cosine_wave = cos(2 * pi * f * t);

%% 3. Square Wave
square_wave = square(2 * pi * f * t);

%% 4. Sawtooth Wave
sawtooth_wave = sawtooth(2 * pi * f * t);

%% 5. White Gaussian Noise
noise = randn(size(t));

%% Plotting
figure('Name', 'Signal Generation', 'NumberTitle', 'off');

subplot(5,1,1);
plot(t, sine_wave, 'b');
title('Sine Wave'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(5,1,2);
plot(t, cosine_wave, 'r');
title('Cosine Wave'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(5,1,3);
plot(t, square_wave, 'g');
title('Square Wave'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(5,1,4);
plot(t, sawtooth_wave, 'm');
title('Sawtooth Wave'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(5,1,5);
plot(t, noise, 'k');
title('White Gaussian Noise'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;

sgtitle('Basic Signal Types');
