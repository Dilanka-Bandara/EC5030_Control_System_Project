% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS

%% PART 1: Substitute parameters and obtain G(s) = aK/(s(s+b))
clc; clear; close all;

% System parameters (from assignment)
Ks = 1;      % V/rad
K = 1;       % Variable preamplifier gain (leave as 1 for symbolic)
K1 = 10;     % Power amplifier gain
K2 = 0.5;    % Current feedback gain
Kt = 0;      % Tachometer feedback gain (0)
Ra = 5;      % Ohms
Ki = 9;      % oz-in/A
Kb = 0.0636; % V/rad/s
Jm = 0.0001; % oz-in-s^2
JL = 0.01;   % oz-in-s^2
Bm = 0.005;  % oz-in-s
BL = 1.0;    % oz-in-s
N = 0.1;     % Gear ratio

% Equivalent inertia and friction
Jt = Jm + N^2*JL;
Bt = Bm + N^2*BL;

% Numerator constant (without K)
num_coeff = Ks * K1 * Ki * N;

% Denominator coefficients
A = 1 + Kb*Bt + K1*K2*Jt;
B = K1*K2*Bt + Ra*Bt + Ki*Kb;

% Compute constants a and b for G(s) = aK/(s(s+b))
a = num_coeff / A;
b = B / A;

% Display results
fprintf('Jt = %.4f oz-in-s^2\n', Jt);
fprintf('Bt = %.4f oz-in-s\n', Bt);
fprintf('A = %.4f\n', A);
fprintf('B = %.4f\n', B);
fprintf('a = %.4f\n', a);
fprintf('b = %.4f\n', b);
fprintf('\nSimplified Open-Loop Transfer Function:\n');
fprintf('G(s) = (%.4f K) / [s(s + %.4f)]\n', a, b);

% Define plant for later use
G = @(K) tf(a*K, [1, b, 0]);
