% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 3: PD controller stability analysis
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
figure;
subplot(3,1,1);
T1 = feedback(series(PD(Kp, Kd_stable), G), 1);
step(T1, t); title('Stable: Kd > Kd_{min}'); grid on;
subplot(3,1,2);
T2 = feedback(series(PD(Kp, Kd_boundary), G), 1);
step(T2, t); title('Marginally Stable: Kd = Kd_{min}'); grid on;
subplot(3,1,3);
T3 = feedback(series(PD(Kp, Kd_unstable), G), 1);
step(T3, t); title('Unstable: Kd < Kd_{min}'); grid on;
xlabel('Time (s)');
