% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 4: Bode plot stability margins for PD controller
clc; clear; close all;
a = 8.9824; b = 0.7210;
G = tf(a, [1, b, 0]);
Kp = 0.02;
Kd_stable = 0.03;
Kd_unstable = -0.1;

C_stable = tf([Kd_stable Kp], [1]);
C_unstable = tf([Kd_unstable Kp], [1]);
L_stable = series(C_stable, G);
L_unstable = series(C_unstable, G);

figure; margin(L_stable); grid on; title('Bode Plot - Stable System');
figure; margin(L_unstable); grid on; title('Bode Plot - Unstable System');

[GM_stable, PM_stable, w_gc_stable, w_pc_stable] = margin(L_stable);
[GM_unstable, PM_unstable, w_gc_unstable, w_pc_unstable] = margin(L_unstable);

fprintf('Stable: GM=%.2f dB, PM=%.2f deg\n', 20*log10(GM_stable), PM_stable);
fprintf('Unstable: GM=%.2f dB, PM=%.2f deg\n', 20*log10(GM_unstable), PM_unstable);
