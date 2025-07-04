% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 3: PD Controller Stability Analysis and Step Response Verification
clc; clear; close all;

a = 8.9824; b = 0.7210; % from Part 1
G = tf(a, [1, b, 0]);
Kp = 0.02;

% Stability boundary for Kd
Kd_min = -b/a;
Kd_stable = 0.03;
Kd_boundary = Kd_min;
Kd_unstable = -0.1;

PD = @(Kp, Kd) tf([Kd Kp], [1]);
t = 0:0.01:20;

figure('Position',[100 100 700 600]);
subplot(3,1,1);
T1 = feedback(series(PD(Kp, Kd_stable), G), 1);
[y1, t1] = step(T1, t);
plot(t1, y1, 'b', 'LineWidth', 2);
title('Stable: Kd > Kd_{min}'); grid on; ylabel('Amplitude');
xlim([0 20]);

subplot(3,1,2);
T2 = feedback(series(PD(Kp, Kd_boundary), G), 1);
[y2, t2] = step(T2, t);
plot(t2, y2, 'm', 'LineWidth', 2);
title('Marginally Stable: Kd = Kd_{min}'); grid on; ylabel('Amplitude');
xlim([0 20]);

subplot(3,1,3);
T3 = feedback(series(PD(Kp, Kd_unstable), G), 1);
[y3, t3] = step(T3, t);
plot(t3, y3, 'r', 'LineWidth', 2);
title('Unstable: Kd < Kd_{min}'); grid on; ylabel('Amplitude'); xlabel('Time (s)');
xlim([0 20]);

sgtitle('Step Responses for Different PD Controller Gains');
