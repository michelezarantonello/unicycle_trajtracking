function k = calculate_gains_traj_nonlin(vd, wd)
% TODO: find good values via analysis

xi = 1;
b  = 1;

k1 = 2*xi*sqrt(b*vd + wd^2);
k3 = 2*xi*sqrt(b*vd + wd^2);
k2 = b;

% k = [k1, 0, 0; 0, k2, k3];
k = [k1, k2, k3];
end
