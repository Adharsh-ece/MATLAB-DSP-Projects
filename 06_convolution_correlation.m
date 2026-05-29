% =========================================================
% 06_convolution_correlation.m
% Convolution and Cross-Correlation
% Topics: Linear convolution, circular convolution,
%         auto-correlation, cross-correlation
% =========================================================

clear; clc; close all;

%% --- 1. Linear Convolution ---
x = [1, 2, 3, 4, 3, 2, 1];   % Input signal
h = [1, 0, -1];               % Simple differentiator-like filter

y_linear = conv(x, h);        % Output length = len(x)+len(h)-1

fprintf('Input length   : %d\n', length(x));
fprintf('Filter length  : %d\n', length(h));
fprintf('Output length  : %d  (linear conv)\n', length(y_linear));

%% --- 2. Circular Convolution (via FFT) ---
N_circ = max(length(x), length(h));  % Must be >= max length
X = fft(x, N_circ);
H = fft(h, N_circ);
y_circ = real(ifft(X .* H));

%% --- 3. Auto-Correlation ---
fs      = 500;
t       = (0:499)/fs;
sig     = sin(2*pi*10*t) + 0.5*randn(size(t));
[acorr, lags] = xcorr(sig, 'normalized');

%% --- 4. Cross-Correlation (delay detection) ---
t2      = (0:999)/1000;
s_ref   = sin(2*pi*5*t2);          % Reference signal
delay   = 50;                       % Known delay in samples
s_del   = [zeros(1,delay), s_ref(1:end-delay)];
[xcr, lags2] = xcorr(s_del, s_ref, 'normalized');
[~, idx]     = max(xcr);
detected_delay = lags2(idx);
fprintf('\nTrue delay     : %d samples\n', delay);
fprintf('Detected delay : %d samples\n', detected_delay);

%% Plotting
figure('Name', 'Convolution', 'NumberTitle', 'off');

subplot(3,1,1);
stem(x, 'b', 'filled'); title('Input Signal x[n]'); xlabel('n'); ylabel('x[n]'); grid on;

subplot(3,1,2);
stem(h, 'r', 'filled'); title('Filter Impulse Response h[n]'); xlabel('n'); ylabel('h[n]'); grid on;

subplot(3,1,3);
stem(y_linear, 'g', 'filled'); title('Linear Convolution y = x * h'); xlabel('n'); ylabel('y[n]'); grid on;

sgtitle('Linear Convolution');

figure('Name', 'Correlation', 'NumberTitle', 'off');

subplot(2,1,1);
plot(lags/fs, acorr, 'b');
title('Auto-Correlation of Noisy Sine (10 Hz)');
xlabel('Lag (s)'); ylabel('Normalized Corr.'); grid on;

subplot(2,1,2);
plot(lags2, xcr, 'r');
xline(detected_delay, 'k--', sprintf('Detected: %d samples', detected_delay));
title('Cross-Correlation — Delay Detection');
xlabel('Lag (samples)'); ylabel('Normalized Corr.'); grid on;

sgtitle('Auto & Cross-Correlation');
