t = out.logsout.get("x_sampled").Values.Time;
x = out.logsout.get("x_sampled").Values.Data;
xd = out.logsout.get("xd").Values.Data;
y = out.logsout.get("y_sampled").Values.Data;
yd = out.logsout.get("yd").Values.Data;

theta = out.logsout.get("theta_sampled").Values.Data;
thetad = out.logsout.get("theta_d").Values.Data;

v = out.logsout.get("v_sampled").Values.Data;
vd = out.logsout.get("vd").Values.Data;
w = out.logsout.get("w_sampled").Values.Data;
wd = out.logsout.get("wd").Values.Data;

%%% no need for this anymore, samples are matched in simulation
% %% account for different sample times
% tx  = out.logsout.get("x").Values.Time;
% txd = out.logsout.get("xd").Values.Time;
% 
% if numel(tx) > numel(txd)
%     t = txd;
%     x = interp1(tx, x, t);
%     y = interp1(tx, y, t);
%     theta = interp1(tx, theta, t);
%     v = interp1(tx, v, t);
%     w = interp1(tx, w, t);
% else
%     t = tx;
%     xd = interp1(txd, xd, t);
%     yd = interp1(txd, yd, t);
%     thetad = interp1(txd, thetad, t);
%     vd = interp1(txd, vd, t);
%     wd = interp1(txd, wd, t);
% end

%%
perf = performance(t, x, y, theta, v, w, xd, yd, thetad, vd, wd, "", "");

figure;
plot(x, y, "DisplayName", "Followed Trajectory", "LineWidth", 3.0);
hold on;
plot(xd, yd, "DisplayName", "Reference Trajectory", "LineWidth", 2.0);
plot(x(1), y(1), ">", "LineWidth", 4.0, "DisplayName", "Start");
plot(x(end), y(end), "o", "LineWidth", 4.0, "DisplayName", "End");
hold off;
title("Reference and Followed Trajectories");
grid("on");
xlabel("x");
ylabel("y");
legend();

figure;
plot(t, v, "LineWidth", 2.0, "DisplayName", "V");
hold on;
plot(t, vd, "LineWidth", 2.0, "DisplayName", "Desired V");
hold off;
title("Linear Velocity vs. Time");
grid("on");
xlabel("t (s)");
ylabel("V");
legend();

figure;
plot(t, w, "LineWidth", 2.0, "DisplayName", "\omega");
hold on;
plot(t, wd, "LineWidth", 2.0, "DisplayName", "Desired \omega");
hold off;
title("Angular Velocity vs. Time");
grid("on");
xlabel("t (s)");
ylabel("\omega (rad/s)");
legend();

figure;
plot(t, perf.se_x, "LineWidth", 2.0);
title("Squared Error (X) vs. Time [MSE = " + perf.mse_x + "]");
grid("on");
xlabel("t (s)");
ylabel("SE");

figure;
plot(t, perf.se_y, "LineWidth", 2.0);
title("Squared Error (Y) vs. Time [MSE = " + perf.mse_y + "]");
grid("on");
xlabel("t (s)");
ylabel("SE");

figure;
plot(t, perf.se_euc, "LineWidth", 2.0);
title("Squared Error (Euclidean) vs. Time [MSE = " + perf.mse_euc + "]");
grid("on");
xlabel("t (s)");
ylabel("SE");

figure;
plot(t, perf.se_lateral, "LineWidth", 2.0);
title("Squared Error (Lateral) vs. Time [MSE = " + perf.mse_lateral+ "]");
grid("on");
xlabel("t (s)");
ylabel("SE");

figure;
plot(t, perf.se_heading, "LineWidth", 2.0);
title("Squared Error (Heading) vs. Time [MSE = " + perf.mse_heading+ "]");
grid("on");
xlabel("t (s)");
ylabel("SE");

figure;
plot(t, perf.cos_loss_theta, "LineWidth", 2.0);
title("Cosine Loss (\theta) vs. Time [Mean Cosine Loss = " + perf.mcos_loss_theta+ "]");
grid("on");
xlabel("t (s)");
ylabel("Cosine Loss");

figure;
plot(t, x, "LineWidth", 2.0, "DisplayName", "X");
hold on;
plot(t, xd, "LineWidth", 2.0, "DisplayName", "Desired X");
hold off;
title("X position vs. Time [MSE = " + perf.mse_x + "]");
grid("on");
xlabel("t (s)");
ylabel("X");
legend();

figure;
plot(t, y, "LineWidth", 2.0, "DisplayName", "Y");
hold on;
plot(t, yd, "LineWidth", 2.0, "DisplayName", "Desired Y");
hold off;
title("Y position vs. Time [MSE = " + perf.mse_y + "]");
grid("on");
xlabel("t (s)");
ylabel("Y");
legend();

figure;
plot(t, theta, "LineWidth", 2.0, "DisplayName", "\theta");
hold on;
plot(t, thetad, "LineWidth", 2.0, "DisplayName", "Desired \theta");
hold off;
title("\theta angle vs. Time [Mean Cosine Loss = " + perf.mcos_loss_theta + "]");
grid("on");
xlabel("t (s)");
ylabel("\theta (rad)");
legend();
