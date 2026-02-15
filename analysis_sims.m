files = [
    % "data/sims/flat1.mat"
    % "data/sims/flat2.mat"
    % "data/sims/flat3.mat"
    % "data/sims/flat4.mat"
    % "data/sims/flat5.mat"
    % "data/sims/flat6.mat"
    % "data/sims/flat7.mat"
    % "data/sims/flat8.mat"
    % "data/sims/flat9.mat"
    "data/sims/lin1.mat"
    "data/sims/lin2.mat"
    "data/sims/lin3.mat"
    "data/sims/lin4.mat"
    "data/sims/lin5.mat"
    "data/sims/lin6.mat"
    "data/sims/lin7.mat"
    "data/sims/lin8.mat"
    "data/sims/lin9.mat"
    "data/sims/nonlin1.mat"
    "data/sims/nonlin2.mat"
    "data/sims/nonlin3.mat"
    "data/sims/nonlin4.mat"
    "data/sims/nonlin5.mat"
    "data/sims/nonlin6.mat"
    "data/sims/nonlin7.mat"
    "data/sims/nonlin8.mat"
    "data/sims/nonlin9.mat"
    "data/sims/output1.mat"
    "data/sims/output2.mat"
    "data/sims/output3.mat"
    "data/sims/output4.mat"
    "data/sims/output5.mat"
    "data/sims/output6.mat"
    "data/sims/output7.mat"
    "data/sims/output8.mat"
    "data/sims/output9.mat"
];


refNums = zeros(numel(files),1);

for k = 1:numel(files)
    name = erase(files(k), ".mat");
    token = regexp(name, '\d+$', 'match');
    refNums(k) = str2double(token{1});
end

uniqueRefs = unique(refNums);


for r = 1:numel(uniqueRefs)

    refID = uniqueRefs(r);
    idx = refNums == refID;
    groupFiles = files(idx);

    figs.traj = figure('Name',"Trajectory Ref "+refID); hold on; grid on;
    title("Trajectory " + refID); xlabel("x"); ylabel("y");

    figs.v = figure('Name',"V Ref "+refID); hold on; grid on;
    title("Linear Velocity - Trajectory " + refID); xlabel("t (s)"); ylabel("V");

    figs.w = figure('Name',"W Ref "+refID); hold on; grid on;
    title("Angular Velocity - Trajectory " + refID); xlabel("t (s)"); ylabel("\omega");

    figs.se_x = figure('Name',"SE X Ref "+refID); hold on; grid on;
    title("Squared Error X - Trajectory " + refID); xlabel("t (s)"); ylabel("SE");

    figs.se_y = figure('Name',"SE Y Ref "+refID); hold on; grid on;
    title("Squared Error Y - Trajectory " + refID); xlabel("t (s)"); ylabel("SE");

    figs.se_euc = figure('Name',"SE Euc Ref "+refID); hold on; grid on;
    title("Squared Error Euclidean - Trajectory " + refID); xlabel("t (s)"); ylabel("SE");

    figs.se_lat = figure('Name',"SE Lat Ref "+refID); hold on; grid on;
    title("Squared Error Lateral - Trajectory " + refID); xlabel("t (s)"); ylabel("SE");

    figs.se_head = figure('Name',"SE Heading Ref "+refID); hold on; grid on;
    title("Squared Error Heading - Trajectory " + refID); xlabel("t (s)"); ylabel("SE");

    figs.cos = figure('Name',"CosLoss Ref "+refID); hold on; grid on;
    title("Cosine Loss - Trajectory " + refID); xlabel("t (s)"); ylabel("Cos Loss");

    figs.x = figure('Name',"X Ref "+refID); hold on; grid on;
    title("X vs Time - Trajectory " + refID); xlabel("t (s)"); ylabel("X");

    figs.y = figure('Name',"Y Ref "+refID); hold on; grid on;
    title("Y vs Time - Trajectory " + refID); xlabel("t (s)"); ylabel("Y");

    figs.theta = figure('Name',"Theta Ref "+refID); hold on; grid on;
    title("\theta vs Time - Trajectory " + refID); xlabel("t (s)"); ylabel("\theta (rad)");

    for k = 1:numel(groupFiles)

        data = load(groupFiles(k));
        out = data.out;

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

        perf_ss = performance(t, x, y, theta, v, w, ...
                              xd, yd, thetad, vd, wd, "");

        [~, fname, ~] = fileparts(groupFiles(k));
        controller = regexprep(fname, '\d+$', '');


        figure(figs.traj);
        plot(x, y, 'LineWidth',2, 'DisplayName',controller);
        if k==1
            plot(xd, yd, 'k--','LineWidth',3,'DisplayName','Reference');
        end

        figure(figs.v);
        plot(t, v,'LineWidth',2,'DisplayName',controller);
        if k==1
            plot(t, vd,'k--','LineWidth',3,'DisplayName','Desired');
        end

        figure(figs.w);
        plot(t, w,'LineWidth',2,'DisplayName',controller);
        if k==1
            plot(t, wd,'k--','LineWidth',3,'DisplayName','Desired');
        end

        figure(figs.se_x);
        plot(t, perf_ss.se_x,'LineWidth',2,'DisplayName',controller+" [MSE="+perf_ss.mse_x+"]");
        figure(figs.se_y);
        plot(t, perf_ss.se_y,'LineWidth',2,'DisplayName',controller+" [MSE="+perf_ss.mse_y+"]");
        figure(figs.se_euc);
        plot(t, perf_ss.se_euc,'LineWidth',2,'DisplayName',controller+" [MSE="+perf_ss.mse_euc+"]");
        figure(figs.se_lat);
        plot(t, perf_ss.se_lateral,'LineWidth',2,'DisplayName',controller+" [MSE="+perf_ss.mse_lateral+"]");
        figure(figs.se_head);
        plot(t, perf_ss.se_heading,'LineWidth',2,'DisplayName',controller+" [MSE="+perf_ss.mse_heading+"]");
        figure(figs.cos);
        plot(t, perf_ss.cos_loss_theta,'LineWidth',2,'DisplayName',controller+" [Mean="+perf_ss.mcos_loss_theta+"]");

        disp("trajectory " + refID);
        disp("controller " + controller);
        disp("mse x " + perf_ss.mse_x);
        disp("mse y " + perf_ss.mse_y);
        disp("mse euc " + perf_ss.mse_euc);
        disp("mse lat " + perf_ss.mse_lateral);
        disp("mse head " + perf_ss.mse_heading);
        disp("cos loss mean " + perf_ss.mcos_loss_theta);


        figure(figs.x);
        plot(t, x,'LineWidth',2,'DisplayName',controller);
        if k==1
            plot(t, xd,'k--','LineWidth',3,'DisplayName','Desired');
        end

        figure(figs.y);
        plot(t, y,'LineWidth',2,'DisplayName',controller);
        if k==1
            plot(t, yd,'k--','LineWidth',3,'DisplayName','Desired');
        end

        figure(figs.theta);
        plot(t, theta,'LineWidth',2,'DisplayName',controller);
        if k==1
            plot(t, thetad,'k--','LineWidth',3,'DisplayName','Desired');
        end

    end

    f = fieldnames(figs);
    for i = 1:numel(f)
        figure(figs.(f{i}));
        legend show;
    end

    outputFolder = "data/sims/plots";
    if ~exist(outputFolder, 'dir')
        mkdir(outputFolder);
    end

    f = fieldnames(figs);
    for i = 1:numel(f)
        figHandle = figs.(f{i});
        filename = outputFolder + "/" + f{i} + "_Ref" + refID + ".png";
        exportgraphics(figHandle, filename, 'Resolution', 300);
    end

end




%{

\begin{table}[ht]
\centering
\small
\begin{tabular}{c c r r r r r r}
\hline
Traj & Controller & MSE$_x$ & MSE$_y$ & MSE$_{euc}$ & MSE$_{lat}$ & MSE$_{head}$ & Mean Cos Loss \\
\hline
1 &           lin &     \textbf{0.35286} &     \textbf{0.35286} &     \textbf{0.70571} &           0.010733 &     \textbf{0.00047725} &     \textbf{0.00023855} \\
1 &           nonlin &           0.40586 &           0.38987 &           0.79573 &     \textbf{0.0020413} &           0.00071567 &           0.0003576 \\
1 &           output &           1.5228 &           1.6127 &           3.1355 &           0.022871 &           0.002528 &           0.0012616 \\
\hline
2 &           lin &     \textbf{0.5801} &     \textbf{0.49281} &     \textbf{1.0729} &     \textbf{0.0024109} &     \textbf{0.00067085} &     \textbf{0.00033527} \\
2 &           nonlin &           0.69103 &           0.56246 &           1.2535 &           0.0097205 &           0.0013021 &           0.00065036 \\
2 &           output &           1.9258 &           1.8001 &           3.7259 &           0.0092507 &           0.003342 &           0.0016671 \\
\hline
3 &           lin &           3.8417 &           3.2029 &           7.0446 &           3.3429 &           0.059455 &           0.019096 \\
3 &           nonlin &     \textbf{0.37978} &     \textbf{0.33559} &   \textbf{0.71537} &        0.028473 &     \textbf{0.022173} &     \textbf{0.0066106} \\
3 &           output &           1.493 &           1.5245 &           3.0176 &     \textbf{0.0046243} &           0.029811 &           0.0078014 \\
\hline
4 &           lin &           3.2942 &           2.0532 &           5.3474 &           4.117 &     \textbf{0.0084831} &     \textbf{0.0041636} \\
4 &           nonlin &  \textbf{0.4893} &  \textbf{0.39651} &  \textbf{0.88581} &  \textbf{0.0081814} &           0.0093383 &           0.0044685 \\
4 &           output &           1.7457 &           1.54 &           3.2856 &           0.042389 &           0.017123 &           0.0080092 \\
\hline
5 &           lin &           7.9535 &           6.3641 &           14.3176 &           8.8023 &           0.070341 &           0.024238 \\
5 &           nonlin &     \textbf{0.57222} &     \textbf{0.28562} &     \textbf{0.85784} &   0.027989 &     \textbf{0.027231} &     \textbf{0.0091123} \\
5 &           output &           2.1335 &           1.1132 &           3.2468 &     \textbf{0.017072} &           0.039226 &           0.012214 \\
\hline
6 &           lin &     \textbf{1.806} &     \textbf{0.75286} &     \textbf{2.5589} &           0.0021848 &     \textbf{0.0002728} &     \textbf{0.00013639} \\
6 &           nonlin &           2.0689 &           0.87849 &           2.9474 &     \textbf{0.0011348} &           0.00035802 &           0.00017898 \\
6 &           output &           3.8381 &           1.7087 &           5.5468 &           0.03195 &           0.001258 &           0.0006287 \\
\hline
7 &           lin &           106.1178 &           113.5517 &           219.6695 &           162.3627 &           0.087516 &           0.034289 \\
7 &           nonlin &     \textbf{4.0673} &     \textbf{2.4296} &     \textbf{6.4969} &     \textbf{0.1086} &     \textbf{0.019465} &     \textbf{0.0092882} \\
7 &           output &           5.9929 &           3.5339 &           9.5269 &           0.11647 &           0.025089 &           0.011844 \\
\hline
8 &           lin &     \textbf{0.015634} &   3.8133e-71 &     \textbf{0.015634} &  3.8133e-71 &           2.0972e-72 &     \textbf{0} \\
8 &           nonlin &           0.015847 &   5.7723e-71 &           0.015847 &     5.7723e-71 &           2.6976e-72 &     \textbf{0} \\
8 &           output &           1.1376 &     \textbf{0} &           1.1376 &     \textbf{0} &     \textbf{0} &     \textbf{0} \\
\hline
9 &           lin &     \textbf{0.033175} &     \textbf{0.035425} &     \textbf{0.0686} &           0.00096095 &     \textbf{4.3395e-05} &     \textbf{2.1694e-05} \\
9 &           nonlin &           0.035146 &           0.035476 &           0.070622 &     \textbf{0.00014215} &           4.5971e-05 &           2.298e-05 \\
9 &           output &           0.64196 &           0.78529 &           1.4273 &           0.00076788 &           0.00029428 &           0.00014698 \\

\hline
\end{tabular}
\caption{Controller performance metrics across trajectories}
\label{tab:controller_results}
\end{table}

%}