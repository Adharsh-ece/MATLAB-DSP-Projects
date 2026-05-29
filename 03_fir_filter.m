% =========================================================
% 03_fir_filter.m
% FIR Filter Design using Window Method
% Topics: Low-pass, High-pass, Band-pass FIR filters
% =========================================================

clear; clc; close all;

%% Parameters
fs   = 1000;   % Sampling frequency (Hz)
N    = 51;     % Filter order (odd = symmetric)

%% --- Low-Pass FIR Filter ---
fc_lp = 100;   % Cutoff frequency (Hz)
Wn_lp = fc_lp / (fs/2);   % Normalized cutoff (0 to 1)
b_lp  = fir1(N-1, Wn_lp, 'low', hamming(N));

%% --- High-Pass FIR Filter ---
fc_hp = 200;
Wn_hp = fc_hp / (fs/2);
b_hp  = fir1(N-1, Wn_hp, 'high', hamming(N));

%% --- Band-Pass FIR Filter ---
fc_bp = [100 200];
Wn_bp = fc_bp / (fs/2);
b_bp  = fir1(N-1, Wn_bp, 'bandpass', hamming(N));

%% Frequency Response
[H_lp, f] = freqz(b_lp, 1, 1024, fs);
[H_hp, ~] = freqz(b_hp, 1, 1024, fs);
[H_bp, ~] = freqz(b_bp, 1, 1024, fs);

%% Plotting — Magnitude Response
figure('Name', 'FIR Filter Design', 'NumberTitle', 'off');

subplot(3,2,1);
plot(f, 20*log10(abs(H_lp)), 'b', 'LineWidth', 1.5);
title('Low-Pass FIR (fc=100 Hz)');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);

subplot(3,2,2);
plot(0:N-1, b_lp, 'b.-');
title('Low-Pass Impulse Response');
xlabel('Sample'); ylabel('Amplitude'); grid on;

subplot(3,2,3);
plot(f, 20*log10(abs(H_hp)), 'r', 'LineWidth', 1.5);
title('High-Pass FIR (fc=200 Hz)');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);

subplot(3,2,4);
plot(0:N-1, b_hp, 'r.-');
title('High-Pass Impulse Response');
xlabel('Sample'); ylabel('Amplitude'); grid on;

subplot(3,2,5);
plot(f, 20*log10(abs(H_bp)), 'g', 'LineWidth', 1.5);
title('Band-Pass FIR (100–200 Hz)');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on; ylim([-80 5]);

subplot(3,2,6);
plot(0:N-1, b_bp, 'g.-');
title('Band-Pass Impulse Response');
xlabel('Sample'); ylabel('Amplitude'); grid on;

sgtitle('FIR Filter Design — Window Method (Hamming)');

%% Apply Low-Pass filter to a noisy signal
t_vec   = (0:999)/fs;
signal  = sin(2*pi*50*t_vec);           % 50 Hz tone
noisy   = signal + 0.5*sin(2*pi*300*t_vec) + 0.3*randn(size(t_vec));
filtered = filter(b_lp, 1, noisy);

figure('Name', 'FIR Filtering Demo', 'NumberTitle', 'off');
subplot(2,1,1); plot(t_vec, noisy,    'b'); title('Noisy Signal');    xlabel('Time (s)'); ylabel('Amplitude'); grid on;
subplot(2,1,2); plot(t_vec, filtered, 'r'); title('After Low-Pass FIR Filter'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;
sgtitle('FIR Filtering Demo');
