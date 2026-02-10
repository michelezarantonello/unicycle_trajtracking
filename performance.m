function metrics = performance_from_ew(ew_ts)
% PERFORMANCE_FROM_EW - Compute control performance metrics from ew timeseries
%
% Input:
%   ew_ts - timeseries with columns [ex, ey, dtheta]
%
% Output:
%   metrics - struct with performance metrics

% Extract time and data
t = ew_ts.Time;
ex = ew_ts.Data(:,1);
ey = ew_ts.Data(:,2);
dtheta = ew_ts.Data(:,3);

% Position error norm
e_pos = sqrt(ex.^2 + ey.^2);

% Steady-state errors
metrics.SS_error.ex = ex(end);
metrics.SS_error.ey = ey(end);
metrics.SS_error.dtheta = dtheta(end);
metrics.SS_error.pos = e_pos(end);

% RMSE
metrics.RMSE.ex = sqrt(mean(ex.^2));
metrics.RMSE.ey = sqrt(mean(ey.^2));
metrics.RMSE.dtheta = sqrt(mean(dtheta.^2));
metrics.RMSE.pos = sqrt(mean(e_pos.^2));

% Max error
metrics.max_error.pos = max(e_pos);
metrics.max_error.dtheta = max(abs(dtheta));

% Rise time & settling time (position error norm)
tol = 0.02; % 2% tolerance

% Rise time: first time e_pos <= 10% of max
e_max = max(e_pos);
idx_rise = find(e_pos <= 0.1*e_max, 1, 'first');
metrics.t_rise = t(idx_rise);

% Settling time: last time e_pos leaves 2% band
idx_settle = find(e_pos > tol*e_max, 1, 'last');
metrics.t_settle = t(idx_settle);

% Overshoot
metrics.overshoot = e_max - e_pos(end);

end
