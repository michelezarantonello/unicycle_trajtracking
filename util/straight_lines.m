% Straight Line Trajectory with Start Point, Length, and Constant Orientation
% Parameters: x, y, theta (heading angle in radians)

% Clear workspace and close figures
clear;
clc;
close all;

% Trajectory parameters (USER INPUT)
x_start = 0;     % Start x position
y_start = 0;     % Start y position
L       = 300;    % Length of the line
theta   = pi/4;   % Orientation angle (rad), CCW from x-axis

% Generate trajectory points
num_points = 1000;   % High resolution
s = linspace(0, L, num_points);   % Path parameter

x_positions = x_start + s * cos(theta);
y_positions = y_start + s * sin(theta);
theta_positions = ones(1, num_points) * theta;

% Compute end point
x_end = x_positions(end);
y_end = y_positions(end);

% Display trajectory information
fprintf('Straight Line Trajectory:\n');
fprintf('Start position: (%.1f, %.1f)\n', x_start, y_start);
fprintf('End position:   (%.1f, %.1f)\n', x_end, y_end);
fprintf('Orientation: %.3f radians (%.1f degrees)\n', theta, rad2deg(theta));
fprintf('Trajectory length: %.2f units\n', L);
fprintf('Number of points: %d\n', num_points);
fprintf('Sampling resolution: %.4f units\n', L/(num_points-1));

% Plot the trajectory
figure;
plot(x_positions, y_positions, 'b-', 'LineWidth', 2);
hold on;

% Mark start and end points
plot(x_start, y_start, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
plot(x_end, y_end, 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Add orientation arrows at several points
arrow_indices = round(linspace(1, num_points, 10));  % FORCE integers
arrow_indices = unique(arrow_indices);

for i = arrow_indices
    arrow_length = 0.5;
    quiver(x_positions(i), y_positions(i), ...
           arrow_length * cos(theta_positions(i)), ...
           arrow_length * sin(theta_positions(i)), ...
           'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
end

% Formatting
grid on;
axis equal;
xlabel('X Position');
ylabel('Y Position');
title('Straight Line Trajectory with Constant Orientation');
legend('Trajectory', 'Start', 'End', 'Location', 'northwest');
grid minor;


% Optional: Create trajectory data structure
trajectory = struct();
trajectory.x = x_positions;
trajectory.y = y_positions;
trajectory.theta = theta_positions;
trajectory.timestamp = linspace(0, 10, num_points); % Example timestamps


