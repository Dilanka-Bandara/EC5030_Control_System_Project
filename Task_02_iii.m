% 2022E048 
% BANDARA H.G.T.D.
% EC 5030 – CONTROL SYSTEMS 
%% PART 2(iii): Frequency response analysis (Bode plots)
w = logspace(-2, 2, 1000);
figure;
for i = 1:3
    T = feedback(G(K_vals(i)), 1);
    [mag, phase, wout] = bode(T, w);
    mag = squeeze(mag);
    phase = squeeze(phase);
    subplot(2,1,1); semilogx(wout, 20*log10(mag), 'LineWidth', 2); hold on;
    subplot(2,1,2); semilogx(wout, phase, 'LineWidth', 2); hold on;
end
subplot(2,1,1);
title('Bode Magnitude Plot'); ylabel('Magnitude (dB)'); grid on;
legend(damping_types, 'Location', 'southwest');
subplot(2,1,2);
title('Bode Phase Plot'); ylabel('Phase (deg)'); xlabel('Frequency (rad/s)'); grid on;
legend(damping_types, 'Location', 'southwest');

% Frequency metrics (Resonant peak and bandwidth)
for i = 1:3
    T = feedback(G(K_vals(i)), 1);
    [mag, ~, wout] = bode(T, w);
    mag_db = 20*log10(squeeze(mag));
    % Resonant peak
    [max_db, ~] = max(mag_db);
    if max_db > mag_db(1) + 3
        resonant_peak = max_db;
    else
        resonant_peak = -Inf;
    end
    % Bandwidth (-3dB from DC)
    dc_gain_db = mag_db(1);
    idx_bw = find(mag_db >= dc_gain_db - 3, 1, 'last');
    if ~isempty(idx_bw)
        bandwidth = wout(idx_bw);
    else
        bandwidth = NaN;
    end
    fprintf('K=%.5f: Resonant Peak = %.2f dB, Bandwidth = %.3f rad/s\n', K_vals(i), resonant_peak, bandwidth);
end
