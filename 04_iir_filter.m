% =========================================================
% 04_iir_filter.m
% IIR Filter Design — Butterworth, Chebyshev, Elliptic
% Topics: IIR design, pole-zero plot, filter comparison
% =========================================================

clear; clc; close all;

%% Parameters
fs   = 1000;    % Sampling frequency (Hz)
fc   = 150;     % Cutoff frequency (Hz)
Wn   = fc / (fs/2);  % Normalized cutoff
ord  = 4;       % Filter order

%% Design Filters
% Butterworth — maximally flat passband
[b_butter, a_butter] = butter(ord, Wn, 'low');

% Chebyshev Type I — equiripple in passband
Rp = 1;  % Passband ripple (dB)
[b_cheby1, a_cheby1] = cheby1(ord, Rp, Wn, 'low');

% Elliptic — steepest rolloff, ripple in both bands
Rs = 40; % Stopband attenuation (dB)
[b_ellip, a_ellip] = ellip(ord, Rp, Rs, Wn, 'low');

%% Frequency Responses
[H_b, f] = freqz(b_butter, a_butter, 1024, fs);
[H_c, ~] = freqz(b_cheby1, a_cheby1, 1024, fs);
[H_e, ~] = freqz(b_ellip,  a_ellip,  1024, fs);

%% Plot Magnitude Response Comparison
figure('Name', 'IIR Filter Comparison', 'NumberTitle', 'off');

subplot(2,1,1);
hold on;
plot(f, 20*log10(abs(H_b)), 'b',  'LineWidth', 1.5);
plot(f, 20*log10(abs(H_c)), 'r--','LineWidth', 1.5);
plot(f, 20*log10(abs(H_e)), 'g:', 'LineWidth', 2);
hold off;
legend('Butterworth','Chebyshev I','Elliptic');
title('IIR Low-Pass Filter Comparison (Order 4, fc=150 Hz)');
xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)'); grid on;
ylim([-80 5]); xlim([0 fs/2]);
xline(fc, 'k--', 'fc'); % Mark cutoff

subplot(2,1,2);
hold on;
plot(f, unwrap(angle(H_b))*180/pi, 'b',  'LineWidth', 1.5);
plot(f, unwrap(angle(H_c))*180/pi, 'r--','LineWidth', 1.5);
plot(f, unwrap(angle(H_e))*180/pi, 'g:', 'LineWidth', 2);
hold off;
legend('Butterworth','Chebyshev I','Elliptic');
title('Phase Response');
xlabel('Frequency (Hz)'); ylabel('Phase (degrees)'); grid on;
xlim([0 fs/2]);

sgtitle('IIR Filter Design Comparison');

%% Pole-Zero Plots
figure('Name', 'Pole-Zero Plots', 'NumberTitle', 'off');

subplot(1,3,1); zplane(b_butter, a_butter); title('Butterworth');
subplot(1,3,2); zplane(b_cheby1, a_cheby1); title('Chebyshev I');
subplot(1,3,3); zplane(b_ellip,  a_ellip);  title('Elliptic');
sgtitle('Pole-Zero Plots (Order 4 Low-Pass IIR)');

%% Apply Butterworth to noisy signal
fs2     = 1000;
t2      = (0:999)/fs2;
x       = sin(2*pi*50*t2) + 0.8*sin(2*pi*300*t2) + 0.4*randn(size(t2));
y       = filtfilt(b_butter, a_butter, x);  % Zero-phase filtering

figure('Name', 'IIR Filtering Demo', 'NumberTitle', 'off');
subplot(2,1,1); plot(t2, x, 'b'); title('Noisy Input Signal');  xlabel('Time (s)'); ylabel('Amplitude'); grid on;
subplot(2,1,2); plot(t2, y, 'r'); title('After Butterworth Low-Pass (filtfilt)'); xlabel('Time (s)'); ylabel('Amplitude'); grid on;
sgtitle('IIR Filtering with Zero-Phase (filtfilt)');
