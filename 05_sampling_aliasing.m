% =========================================================
% 05_sampling_aliasing.m
% Sampling Theorem & Aliasing Demonstration
% Topics: Nyquist criterion, aliasing, reconstruction
% =========================================================

clear; clc; close all;

%% "Continuous" signal (very high fs to simulate analog)
fs_cont = 10000;
t_cont  = 0 : 1/fs_cont : 1 - 1/fs_cont;
f_sig   = 100;   % Signal frequency (Hz)
x_cont  = sin(2 * pi * f_sig * t_cont);

%% Case 1 — Proper Sampling (fs > 2*f_sig, Nyquist satisfied)
fs_good = 500;   % Well above 200 Hz Nyquist rate
t_good  = 0 : 1/fs_good : 1 - 1/fs_good;
x_good  = sin(2 * pi * f_sig * t_good);

%% Case 2 — Aliasing (fs < 2*f_sig, Nyquist violated)
fs_bad  = 150;   % Below Nyquist rate → aliased frequency
t_bad   = 0 : 1/fs_bad : 1 - 1/fs_bad;
x_bad   = sin(2 * pi * f_sig * t_bad);

% Alias frequency = |f_sig - fs_bad| = |100 - 150| = 50 Hz
f_alias = abs(f_sig - fs_bad);
fprintf('Signal frequency : %d Hz\n', f_sig);
fprintf('Under-sampling fs: %d Hz  (Nyquist = %d Hz)\n', fs_bad, 2*f_sig);
fprintf('Aliased frequency: %d Hz\n', f_alias);

%% Plot
figure('Name', 'Sampling & Aliasing', 'NumberTitle', 'off');

subplot(3,1,1);
plot(t_cont(1:200), x_cont(1:200), 'b', 'LineWidth', 1);
title(sprintf('Original Signal — %.0f Hz (simulated analog)', f_sig));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;

subplot(3,1,2);
plot(t_cont(1:200), x_cont(1:200), 'b--'); hold on;
stem(t_good(t_good <= t_cont(200)), x_good(t_good <= t_cont(200)), 'r', 'filled');
hold off;
title(sprintf('Proper Sampling — fs = %d Hz (no aliasing)', fs_good));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
legend('Analog signal', 'Sampled points');

subplot(3,1,3);
plot(t_cont(1:200), x_cont(1:200), 'b--'); hold on;
stem(t_bad(t_bad <= t_cont(200)), x_bad(t_bad <= t_cont(200)), 'r', 'filled');
% Show aliased waveform
t_alias = 0 : 1/fs_cont : t_cont(200);
x_alias = sin(2 * pi * f_alias * t_alias);
plot(t_alias, x_alias, 'g', 'LineWidth', 2);
hold off;
title(sprintf('Under-Sampling — fs = %d Hz → Aliased at %d Hz', fs_bad, f_alias));
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
legend('Original', 'Sampled points', sprintf('Alias (%d Hz)', f_alias));

sgtitle('Nyquist Sampling Theorem & Aliasing');

%% Spectrum comparison
figure('Name', 'Aliasing Spectrum', 'NumberTitle', 'off');

N_good = length(x_good); F_good = abs(fft(x_good)/N_good); F_good = F_good(1:N_good/2+1);
N_bad  = length(x_bad);  F_bad  = abs(fft(x_bad)/N_bad);   F_bad  = F_bad(1:N_bad/2+1);

subplot(2,1,1);
plot(linspace(0,fs_good/2,length(F_good)), 2*F_good, 'r');
title(sprintf('Spectrum — fs=%d Hz (correct)', fs_good));
xlabel('Frequency (Hz)'); ylabel('|X(f)|'); grid on;

subplot(2,1,2);
plot(linspace(0,fs_bad/2,length(F_bad)), 2*F_bad, 'g');
title(sprintf('Spectrum — fs=%d Hz (aliased: 100Hz → %dHz)', fs_bad, f_alias));
xlabel('Frequency (Hz)'); ylabel('|X(f)|'); grid on;

sgtitle('Spectrum: Proper Sampling vs Aliasing');
