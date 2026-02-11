% Square Trajectory
% Parameters: center_x, center_y, side_length

% Clear workspace and close figures
clear;
clc;
close all;

% Square parameters
center_x = 200;         % Square center x
center_y = 200;         % Square center y
side_length = 150;      % Length of square side

% Trajectory parameters
num_points = 1000;      % High resolution

% Calculate half-side for convenience
half_side = side_length / 2;

% Define square vertices (counter-clockwise order)
% Starting from bottom-right, going counter-clockwise
vertices = [
    center_x + half_side, center_y - half_side;  % Bottom-right
    center_x + half_side, center_y + half_side;  % Top-right  
    center_x - half_side, center_y + half_side;  % Top-left
    center_x - half_side, center_y - half_side;  % Bottom-left
    center_x + half_side, center_y - half_side;  % Back to start
];

% Generate trajectory points with equal distribution along each side
x_positions = [];
y_positions = [];
theta_positions = [];

points_per_side = num_points / 4;

for side = 1:4
    % Start and end points of current side
    start_point = vertices(side, :);
    end_point = vertices(side + 1, :);
    
    % Generate points along this side
    side_x = linspace(start_point(1), end_point(1), points_per_side);
    side_y = linspace(start_point(2), end_point(2), points_per_side);
    
    % Calculate heading angles for this side
    % For horizontal sides, theta is 0 or pi
    % For vertical sides, theta is pi/2 or 3*pi/2
    if side == 1  % Bottom side (moving left)
        side_theta = zeros(1, points_per_side);
    elseif side == 2  % Right side (moving up)
        side_theta = pi/2 * ones(1, points_per_side);
    elseif side == 3  % Top side (moving right)
        side_theta = pi * ones(1, points_per_side);
    else  % Left side (moving down)
        side_theta = 3*pi/2 * ones(1, points_per_side);
    end
    
    % Add to trajectory arrays
    x_positions = [x_positions, side_x];
    y_positions = [y_positions, side_y];
    theta_positions = [theta_positions, side_theta];
end

% Remove the last point to avoid duplication
x_positions = x_positions(1:end-1);
y_positions = y_positions(1:end-1);
theta_positions = theta_positions(1:end-1);

% Display trajectory information
fprintf('Square Trajectory:\n');
fprintf('Center: (%.1f, %.1f)\n', center_x, center_y);
fprintf('Side length: %.1f units\n', side_length);
fprintf('Perimeter: %.2f units\n', 4 * side_length);
fprintf('Number of points: %d\n', numel(x_positions));
fprintf('Points per side: %.1f\n', points_per_side);

% Plot the trajectory
figure;
plot(x_positions, y_positions, 'b-', 'LineWidth', 2);
hold on;

% Mark center, start, and end points
plot(center_x, center_y, 'kx', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_positions(1), y_positions(1), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
plot(x_positions(end), y_positions(end), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Mark vertices
for i = 1:4
    plot(vertices(i, 1), vertices(i, 2), 'mo', 'MarkerSize', 8, 'MarkerFaceColor', 'm');
end

% Add orientation arrows
%arrow_indices = round(linspace(1, numel(x_positions), 12));
%for i = arrow_indices
%    arrow_length = 15;
%    quiver(x_positions(i), y_positions(i), ...
%           arrow_length * cos(theta_positions(i)), ...
%           arrow_length * sin(theta_positions(i)), ...
%           'k', 'LineWidth', 1.5, 'MaxHeadSize', 0.3);
%end

% Formatting
grid on;
axis equal;
xlabel('X Position');
ylabel('Y Position');
title(['Square Trajectory (Center = [', num2str(center_x), ', ', num2str(center_y), ...
       '], Side Length = ', num2str(side_length), ')']);
legend('Trajectory', 'Center', 'Start', 'End', 'Vertices', 'Location', 'best');
grid minor;

% Optional: Create trajectory data structure
trajectory = struct();
trajectory.x = x_positions;
trajectory.y = y_positions;
trajectory.theta = theta_positions;
trajectory.timestamp = linspace(0, 10, numel(x_positions)); % Example timestamps

