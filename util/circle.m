% Circular Trajectory
% Parameters: x, y, theta (heading angle in radians)

% Clear workspace and close figures
clear;
clc;
close all;

% Circle parameters
center_x = 200;     % Circle center x
center_y = 200;     % Circle center y
radius   = 150;     % Circle radius

% Trajectory parameters
num_points = 1000;              % High resolution
angles = linspace(0, 2*pi, num_points);  % Full circle

% Generate circular trajectory points
x_positions = center_x + radius * cos(angles);
y_positions = center_y + radius * sin(angles);

% Heading angle (tangent to the circle, CCW motion)
theta_positions = angles + pi/2;

% Display trajectory information
fprintf('Circular Trajectory:\n');
fprintf('Center: (%.1f, %.1f)\n', center_x, center_y);
fprintf('Radius: %.1f units\n', radius);
fprintf('Trajectory length (circumference): %.2f units\n', 2*pi*radius);
fprintf('Number of points: %d\n', num_points);
fprintf('Angular resolution: %.6f rad\n', (2*pi)/(num_points-1));

% Plot the trajectory
figure;
plot(x_positions, y_positions, 'b-', 'LineWidth', 2);
hold on;

% Mark center, start, and end points
plot(center_x, center_y, 'kx', 'MarkerSize', 10, 'LineWidth', 2);
plot(x_positions(1), y_positions(1), 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
plot(x_positions(end), y_positions(end), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% Add orientation arrows
arrow_indices = round(linspace(1, num_points, 12));
for i = arrow_indices
    arrow_length = 15;
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
title('Circular Trajectory (Center = [200, 200], Radius = 150)');
legend('Trajectory', 'Center', 'Start', 'End', 'Location', 'best');
grid minor;

% Optional: Create trajectory data structure
trajectory = struct();
trajectory.x = x_positions;
trajectory.y = y_positions;
trajectory.theta = theta_positions;
trajectory.timestamp = linspace(0, 10, num_points); % Example timestamps

% Display first few and last few points
fprintf('\nFirst 5 trajectory points:\n');
fprintf('Time\tX\tY\tTheta (rad)\tTheta (deg)\n');
for i = 1:5
    fprintf('%.2f\t%.2f\t%.2f\t%.3f\t\t%.1f\n', ...
            trajectory.timestamp(i), trajectory.x(i), ...
            trajectory.y(i), trajectory.theta(i), rad2deg(trajectory.theta(i)));
end

fprintf('\nLast 5 trajectory points:\n');
fprintf('Time\tX\tY\tTheta (rad)\tTheta (deg)\n');
for i = num_points-4:num_points
    fprintf('%.2f\t%.2f\t%.2f\t%.3f\t\t%.1f\n', ...
            trajectory.timestamp(i), trajectory.x(i), ...
            trajectory.y(i), trajectory.theta(i), rad2deg(trajectory.theta(i)));
end
