% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS
%% PART 2(i): Find K for different damping conditions
% Standard 2nd order: s^2 + b s + aK = 0
K_crit = b^2/(4*a); % Critically damped
K_over = 0.8 * K_crit; % Overdamped
K_under = 2.0 * K_crit; % Underdamped

K_vals = [K_over, K_crit, K_under];
damping_types = {'Overdamped', 'Critically Damped', 'Underdamped'};

fprintf('\nCritical Gain Calculation:\n');
fprintf('K_crit = %.4f\n', K_crit);
fprintf('K_over = %.4f\n', K_over);
fprintf('K_under = %.4f\n', K_under);
