function [x, y, xd, yd] = match_samples(x, y, xd, yd, n)
% make sure the reference and 
% ref, act: Nx2 (x-y)

if nargin < 3
    n = 1000;
end

s_ref = [0; cumsum(hypot(diff(xd), diff(yd)))];
s_act = [0; cumsum(hypot(diff(x), diff(y)))];

s_max = min(s_ref(end), s_act(end));
s = linspace(0, s_max, n);

xd = interp1(s_ref, xd, s, 'linear');
yd = interp1(s_ref, yd, s, 'linear');

x = interp1(s_act, x, s, 'linear');
y = interp1(s_act, y, s, 'linear');
end
