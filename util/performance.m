function out = performance(t, x, y, theta, v, w, xd, yd, thetad, vd, wd, typestr, statestr)

%% transient (for straight lines)
rising_time_x = 0;
rising_time_y = 0;
rising_time_theta = 0;
overshoot_x = 0;
overshoot_y = 0;
overshoot_theta = 0;
settling_time_x = 0;
settling_time_y = 0;
settling_time_theta = 0;

%% steady state (for any trajectory)
% per state
se_x = 0;
mse_x = 0;
se_y = 0;
mse_y = 0;
cos_loss_theta = 0;
mcos_loss_theta = 0;
% overall
se_lateral = 0;
mse_lateral = 0;
se_heading = 0;
mse_heading = 0;
se_euc = 0;
mse_euc = 0;

%% calculations
if typestr == "transient"
    if statestr == "x" % vertical line, x offset
        S = stepinfo(xd - x, t);
        rising_time_x = S.RiseTime;
        settling_time_x = S.SettlingTime;
        overshoot_x = S.Overshoot;
    elseif statestr == "y" % horizontal line, y offset
        S = stepinfo(yd - y, t);
        rising_time_y = S.RiseTime;
        settling_time_y = S.SettlingTime;
        overshoot_y = S.Overshoot;
    elseif statestr == "theta" % slanted line, 0 offset
        e_theta = atan2(sin(theta - thetad), cos(theta - thetad));
        S = stepinfo(e_theta, t);
        rising_time_theta = S.RiseTime;
        settling_time_theta = S.SettlingTime;
        overshoot_theta = S.Overshoot;
    end
end

se_x = (xd - x).^2;
mse_x = mean(se_x);
se_y = (yd - y).^2;
mse_y = mean(se_y);
se_euc = se_x + se_y;
mse_euc = mean(se_euc);

dtheta = atan2(sin(theta - thetad), cos(theta - thetad));
cos_loss_theta = 1 - cos(dtheta);
mcos_loss_theta = mean(cos_loss_theta);

ex = x - xd;
ey = y - yd;
e_lateral = -sin(thetad).*ex + cos(thetad).*ey;
e_theta = atan2(sin(theta - thetad), cos(theta - thetad));

se_heading  = e_theta.^2;
mse_heading = mean(se_heading);
se_lateral  = e_lateral.^2;
mse_lateral = mean(se_lateral);

out.rising_time_x = rising_time_x;
out.rising_time_y = rising_time_y;
out.rising_time_theta = rising_time_theta;
out.overshoot_x = overshoot_x;
out.overshoot_y = overshoot_y;
out.overshoot_theta = overshoot_theta;
out.settling_time_x = settling_time_x;
out.settling_time_y = settling_time_y;
out.settling_time_theta = settling_time_theta;
out.se_x = se_x;
out.mse_x = mse_x;
out.se_y = se_y;
out.mse_y = mse_y;
out.cos_loss_theta = cos_loss_theta;
out.mcos_loss_theta = mcos_loss_theta;
out.se_lateral = se_lateral;
out.mse_lateral = mse_lateral;
out.se_heading = se_heading;
out.mse_heading = mse_heading;
out.se_euc = se_euc;
out.mse_euc = mse_euc;

end