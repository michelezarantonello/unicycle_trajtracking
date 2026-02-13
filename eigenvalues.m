xi_nominal = 0.7;
a_nominal = 2.5;
v_des_nominal = 165;
w_des_nominal = 10;

xi_vals = linspace(0.05, 1, 100);
a_vals = linspace(0.05, 2, 100);
v_vals = linspace(-250, 250, 100);
w_vals = linspace(-pi, pi, 100);


%% 2d - xi
lambda_re = zeros(3, length(xi_vals));
lambda_im = zeros(3, length(xi_vals));
for xi_i = 1:length(xi_vals)
    xi = xi_vals(xi_i);
    a = a_nominal;
    v_des = v_des_nominal;
    w_des = w_des_nominal;

    k1 = 2*xi*a;
    k3 = k1;
    k2 = (a^2 - w_des^2)/v_des;
    A = [-k1, w_des, 0;
         -w_des, 0, v_des;
         0, -k2, -k3];
    lambda = eig(A);
    
    for eig_i = 1:3
        lambda_re(eig_i, xi_i) = real(lambda(eig_i));
        lambda_im(eig_i, xi_i) = imag(lambda(eig_i));
    end
end

figure;
hold on;
colors = ['r','g','b'];
for eig_i = 1:3
    plot(lambda_re(eig_i,:), lambda_im(eig_i,:), 'Color', colors(eig_i), 'LineWidth', 2);
    
    text(lambda_re(eig_i,1), lambda_im(eig_i,1), ...
        sprintf('\\xi = %.1f', xi_vals(1)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','right','VerticalAlignment','bottom');
    
    text(lambda_re(eig_i,end), lambda_im(eig_i,end), ...
        sprintf('\\xi = %.1f', xi_vals(end)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','left','VerticalAlignment','top');
end
xlabel('Re(\lambda)');
ylabel('Im(\lambda)');
grid on;
legend('\lambda_1','\lambda_2','\lambda_3');
axis equal;


%% 2d - a
lambda_re = zeros(3, length(a_vals));
lambda_im = zeros(3, length(a_vals));
for a_i = 1:length(a_vals)
    a = a_vals(a_i);
    xi = xi_nominal;
    v_des = v_des_nominal;
    w_des = w_des_nominal;

    k1 = 2*xi*a;
    k3 = k1;
    k2 = (a^2 - w_des^2)/v_des;
    A = [-k1, w_des, 0;
         -w_des, 0, v_des;
         0, -k2, -k3];
    lambda = eig(A);
    
    for eig_i = 1:3
        lambda_re(eig_i, a_i) = real(lambda(eig_i));
        lambda_im(eig_i, a_i) = imag(lambda(eig_i));
    end
end

figure;
hold on;
colors = ['r','g','b'];
for eig_i = 1:3
    plot(lambda_re(eig_i,:), lambda_im(eig_i,:), 'Color', colors(eig_i), 'LineWidth', 2);
    
    text(lambda_re(eig_i,1), lambda_im(eig_i,1), ...
        sprintf('a = %.1f', a_vals(1)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','right','VerticalAlignment','bottom');
    
    text(lambda_re(eig_i,end), lambda_im(eig_i,end), ...
        sprintf('a = %.1f', a_vals(end)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','left','VerticalAlignment','top');
end
xlabel('Re(\lambda)');
ylabel('Im(\lambda)');
grid on;
legend('\lambda_1','\lambda_2','\lambda_3');
axis equal;


%% 2d - v
lambda_re = zeros(3, length(v_vals));
lambda_im = zeros(3, length(v_vals));
for v_i = 1:length(v_vals)
    v_des = v_vals(v_i);
    a = a_nominal;
    xi = xi_nominal;
    w_des = w_des_nominal;

    k1 = 2*xi*a;
    k3 = k1;
    k2 = (a^2 - w_des^2)/v_des;
    A = [-k1, w_des, 0;
         -w_des, 0, v_des;
         0, -k2, -k3];
    lambda = eig(A);
    
    for eig_i = 1:3
        lambda_re(eig_i, v_i) = real(lambda(eig_i));
        lambda_im(eig_i, v_i) = imag(lambda(eig_i));
    end
end

figure;
hold on;
colors = ['r','g','b'];
for eig_i = 1:3
    plot(lambda_re(eig_i,:), lambda_im(eig_i,:), 'Color', colors(eig_i), 'LineWidth', 2);
    
    text(lambda_re(eig_i,1), lambda_im(eig_i,1), ...
        sprintf('v = %.1f', v_vals(1)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','right','VerticalAlignment','bottom');
    
    text(lambda_re(eig_i,end), lambda_im(eig_i,end), ...
        sprintf('v = %.1f', v_vals(end)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','left','VerticalAlignment','top');
end
xlabel('Re(\lambda)');
ylabel('Im(\lambda)');
grid on;
legend('\lambda_1','\lambda_2','\lambda_3');
axis equal;


%% 2d - w
lambda_re = zeros(3, length(v_vals));
lambda_im = zeros(3, length(v_vals));
for w_i = 1:length(w_vals)
    w_des = w_vals(w_i);
    a = a_nominal;
    xi = xi_nominal;
    v_des = v_des_nominal;

    k1 = 2*xi*a;
    k3 = k1;
    k2 = (a^2 - w_des^2)/v_des;
    A = [-k1, w_des, 0;
         -w_des, 0, v_des;
         0, -k2, -k3];
    lambda = eig(A);
    
    for eig_i = 1:3
        lambda_re(eig_i, w_i) = real(lambda(eig_i));
        lambda_im(eig_i, w_i) = imag(lambda(eig_i));
    end
end

figure;
hold on;
colors = ['r','g','b'];
for eig_i = 1:3
    plot(lambda_re(eig_i,:), lambda_im(eig_i,:), 'Color', colors(eig_i), 'LineWidth', 2);
    
    text(lambda_re(eig_i,1), lambda_im(eig_i,1), ...
        sprintf('w = %.1f', w_vals(1)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','right','VerticalAlignment','bottom');
    
    text(lambda_re(eig_i,end), lambda_im(eig_i,end), ...
        sprintf('w = %.1f', w_vals(end)), 'FontSize', 10, 'Color', colors(eig_i), ...
        'HorizontalAlignment','left','VerticalAlignment','top');
end
xlabel('Re(\lambda)');
ylabel('Im(\lambda)');
grid on;
legend('\lambda_1','\lambda_2','\lambda_3');
axis equal;


%%
%%
%%
%%


% %% 3d - xi - v
% figure;
% colors = ['r','g','b'];
% for eig_i = 1:3
%     for v_des = v_vals
%         lambda_re = zeros(1,length(xi_vals));
%         lambda_im = zeros(1,length(xi_vals));
%         for xi_i = 1:length(xi_vals)
%             xi = xi_vals(xi_i);
%             a = a_nominal;
%             w_des = w_des_nominal;
% 
%             k1 = 2*xi*a;
%             k3 = k1;
%             k2 = (a^2 - w_des^2)/v_des;
%             A = [-k1, w_des, 0;
%                  -w_des, 0, v_des;
%                  0, -k2, -k3];
%             lambda = eig(A);
% 
%             lambda_im(xi_i) = imag(lambda(eig_i));
%             lambda_re(xi_i) = real(lambda(eig_i));
%         end
%         % plot3(lambda_re, lambda_im, xi_vals, "Color", colors(eig_i));
%         plot(lambda_re, lambda_im, "Color", colors(eig_i));
%         hold on;
%     end
% end
% hold off;
% xlabel('Re(\lambda)');
% ylabel('Im(\lambda)');
% % zlabel('\xi');
% grid on;
% title('xi - v');
% % view(45,30);
% 
% 
% %% 3d - xi - w
% figure;
% colors = ['r','g','b'];
% for eig_i = 1:3
%     for w_des = w_vals
%         lambda_re = zeros(1,length(xi_vals));
%         lambda_im = zeros(1,length(xi_vals));
%         for xi_i = 1:length(xi_vals)
%             xi = xi_vals(xi_i);
%             a = a_nominal;
%             v_des = v_des_nominal;
% 
%             k1 = 2*xi*a;
%             k3 = k1;
%             k2 = (a^2 - w_des^2)/v_des;
%             A = [-k1, w_des, 0;
%                  -w_des, 0, v_des;
%                  0, -k2, -k3];
%             lambda = eig(A);
% 
%             lambda_im(xi_i) = imag(lambda(eig_i));
%             lambda_re(xi_i) = real(lambda(eig_i));
%         end
%         % plot3(lambda_re, lambda_im, xi_vals, "Color", colors(eig_i));
%         plot(lambda_re, lambda_im, "Color", colors(eig_i));
%         hold on;
%     end
% end
% hold off;
% xlabel('Re(\lambda)');
% ylabel('Im(\lambda)');
% % zlabel('\xi');
% grid on;
% title('xi - w');
% % view(45,30);
% 
% 
% %% 3d - a - v
% figure;
% colors = ['r','g','b'];
% for eig_i = 1:3
%     for v_des = v_vals
%         lambda_re = zeros(1,length(xi_vals));
%         lambda_im = zeros(1,length(xi_vals));
%         for a_i = 1:length(a_vals)
%             a = a_vals(a_i);
%             xi = xi_nominal;
%             w_des = w_des_nominal;
% 
%             k1 = 2*xi*a;
%             k3 = k1;
%             k2 = (a^2 - w_des^2)/v_des;
%             A = [-k1, w_des, 0;
%                  -w_des, 0, v_des;
%                  0, -k2, -k3];
%             lambda = eig(A);
% 
%             lambda_im(a_i) = imag(lambda(eig_i));
%             lambda_re(a_i) = real(lambda(eig_i));
%         end
%         % plot3(lambda_re, lambda_im, a_vals, "Color", colors(eig_i));
%         plot(lambda_re, lambda_im, "Color", colors(eig_i));
%         hold on;
%     end
% end
% hold off;
% xlabel('Re(\lambda)');
% ylabel('Im(\lambda)');
% % zlabel('a');
% grid on;
% title('a - v');
% % view(45,30);
% 
% 
% %% 3d - a - w
% figure;
% colors = ['r','g','b'];
% for eig_i = 1:3
%     for w_des = w_vals
%         lambda_re = zeros(1,length(xi_vals));
%         lambda_im = zeros(1,length(xi_vals));
%         for a_i = 1:length(a_vals)
%             a = a_vals(a_i);
%             xi = xi_nominal;
%             v_des = v_des_nominal;
% 
%             k1 = 2*xi*a;
%             k3 = k1;
%             k2 = (a^2 - w_des^2)/v_des;
%             A = [-k1, w_des, 0;
%                  -w_des, 0, v_des;
%                  0, -k2, -k3];
%             lambda = eig(A);
% 
%             lambda_im(a_i) = imag(lambda(eig_i));
%             lambda_re(a_i) = real(lambda(eig_i));
%         end
%         % plot3(lambda_re, lambda_im, a_vals, "Color", colors(eig_i));
%         plot(lambda_re, lambda_im, "Color", colors(eig_i));
%         hold on;
%     end
% end
% hold off;
% xlabel('Re(\lambda)');
% ylabel('Im(\lambda)');
% % zlabel('a');
% grid on;
% title('a - w');
% % view(45,30);
% 
