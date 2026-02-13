function k = calculate_gains_traj_lin(vd, wd)
% TODO: find good values via analysis

xi = 0.7;
a  = 6;

k1 = 2*xi*a;
k3 = 2*xi*a;
k2 = (a^2 - wd^2) / max(vd, 1e-6);

k = [k1, 0, 0; 0, k2, k3];
end
