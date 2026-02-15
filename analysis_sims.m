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
