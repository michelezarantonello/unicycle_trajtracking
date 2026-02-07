function k = calculate_gains_traj_lin(vd, wd)
% TODO: find good values via analysis

xi = 0.7;
a  = 1.5;
k1 = 2*xi*a;
k3 = 2*xi*a;
k2 = (a^2 - wd^2) / vd;

k = [k1, k2, k3];
end
