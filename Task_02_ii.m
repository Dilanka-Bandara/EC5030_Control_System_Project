% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 2(ii): Step responses and performance metrics
t = 0:0.01:40;
figure; hold on;
metrics = zeros(3,4); % RiseTime, Overshoot, SettlingTime, Offset

for i = 1:3
    T = feedback(G(K_vals(i)), 1);
    y = step(T, t);
    plot(t, y, 'LineWidth', 2);
    S = stepinfo(y, t);
    metrics(i,1) = S.RiseTime;
    metrics(i,2) = S.Overshoot;
    metrics(i,3) = S.SettlingTime;
    metrics(i,4) = abs(1 - y(end));
end
legend(damping_types, 'Location', 'southeast');
xlabel('Time (s)'); ylabel('Response');
title('Step Responses for Different Damping');
grid on;

% Display table
T_metrics = table(K_vals', damping_types', metrics(:,1), metrics(:,2), metrics(:,3), metrics(:,4), ...
    'VariableNames', {'K', 'Damping', 'RiseTime', 'Overshoot', 'SettlingTime', 'Offset'});
disp(T_metrics);
