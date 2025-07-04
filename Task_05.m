% 2022E048 
% EC 5030 – CONTROL SYSTEMS 
%% PART 5: Heuristic PD tuning
clc; clear; close all;
a = 8.9824; b = 0.7210;
G = tf(a, [1, b, 0]);
Kp = 0.02; Kd = 0.03;
t = 0:0.01:20;
figure; hold on;
for iter = 1:4
    C = tf([Kd Kp], [1]);
    T = feedback(series(C, G), 1);
    y = step(T, t);
    plot(t, y, 'LineWidth', 1.5, 'DisplayName', sprintf('Kp=%.2f, Kd=%.2f', Kp, Kd));
    S = stepinfo(y, t);
    fprintf('Iter %d: Kp=%.2f, Kd=%.2f, Rise=%.2f, OS=%.2f%%, Settle=%.2f\n', ...
        iter, Kp, Kd, S.RiseTime, S.Overshoot, S.SettlingTime);
    % Heuristic tuning: alternate Kp/Kd
    if iter == 1
        Kp = Kp * 2;
    elseif iter == 2
        Kd = Kd * 2;
    elseif iter == 3
        Kp = 0.05; Kd = 0.08; % Final tuned
    end
end
title('PD Tuning Iterations'); xlabel('Time (s)'); ylabel('Amplitude');
legend show; grid on;
