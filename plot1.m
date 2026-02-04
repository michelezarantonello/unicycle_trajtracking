figure
plot(xd(:,1), yd(:,1), 'r--', 'LineWidth', 2)
hold on
plot(x(:,1),  y(:,1),  'b',  'LineWidth', 2)
axis equal
grid on
legend('Desired','Actual')
xlabel('x')
ylabel('y')
title('Trajectory Tracking')