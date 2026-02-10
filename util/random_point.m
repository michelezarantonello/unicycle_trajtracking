% Generate a single random point on a 0-500 plane

% Parameters
x_min = 0;
x_max = 500;
y_min = 0;
y_max = 500;

% Generate one random point
x = x_min + (x_max - x_min) * rand();
y = y_min + (y_max - y_min) * rand();

% Display the point
fprintf('Random point: X = %.2f, Y = %.2f\n', x, y);

% Optional: plot it
figure;
scatter(x, y, 100, 'filled');
grid on;
axis([0 500 0 500]);  % keep axes fixed
xlabel('X Position');
ylabel('Y Position');
title('Randomly Generated Single Point');
