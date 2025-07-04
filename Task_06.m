% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 6: Final tuned controller performance
clc; clear; close all;
a = 8.9824; b = 0.7210;
G = tf(a, [1, b, 0]);
Kp = 0.05; Kd = 0.08;
C = tf([Kd Kp], [1]);
L = series(C, G);
T = feedback(L, 1);

% Step response and metrics
t = 0:0.01:5;
y = step(T, t);
S = stepinfo(y, t);
offset = abs(1 - y(end));
figure; plot(t, y, 'LineWidth', 2);
title('Step Response - Tuned PD Controller');
xlabel('Time (s)'); ylabel('Amplitude'); grid on;
legend(sprintf('Kp=%.2f, Kd=%.2f', Kp, Kd));

% Bode plot and margins
figure; margin(L); grid on; title('Bode Plot - Tuned PD Controller');
[GM, PM, w_gc, w_pc] = margin(L);
GM_db = 20*log10(GM);

% Display metrics
fprintf('Rise Time: %.4f s\n', S.RiseTime);
fprintf('Overshoot: %.2f%%\n', S.Overshoot);
fprintf('Settling Time: %.4f s\n', S.SettlingTime);
fprintf('Offset: %.4f\n', offset);
fprintf('Gain Margin: %.2f dB\n', GM_db);
fprintf('Phase Margin: %.2f deg\n', PM);
fprintf('Gain Crossover Freq: %.4f rad/s\n', w_gc);
fprintf('Phase Crossover Freq: %.4f rad/s\n', w_pc);
