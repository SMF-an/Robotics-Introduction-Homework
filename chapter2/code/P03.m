p_B = [1; 0; 2];
theta = deg2rad(30);
p_A = R('y', theta)' * p_B;
disp(p_A);

fprintf("Corke MATLAB Robotics\n");
disp(roty(theta)' * p_B);

figure('Position', [100, 100, 1200, 800]);

hold on; grid on; axis equal;
xlabel('X'); ylabel('Y'); zlabel('Z');
title('3D 旋转可视化');
view(45, 30);

% 绘制原始坐标系
quiver3(0,0,0, 2,0,0, 'r', 'LineWidth', 2, 'MaxHeadSize', 0.5); % X轴
quiver3(0,0,0, 0,2,0, 'g', 'LineWidth', 2, 'MaxHeadSize', 0.5); % Y轴
quiver3(0,0,0, 0,0,2, 'b', 'LineWidth', 2, 'MaxHeadSize', 0.5); % Z轴
text(2.1,0,0, 'X', 'Color', 'r', 'FontSize', 12);
text(0,2.1,0, 'Y', 'Color', 'g', 'FontSize', 12);
text(0,0,2.1, 'Z', 'Color', 'b', 'FontSize', 12);

% 绘制旋转轴（Z轴）
plot3([0,0], [0,0], [-0.5,2.5], 'k--', 'LineWidth', 1);

% 绘制初始点和目标点
plot3(p_B(1), p_B(2), p_B(3), 'ro', 'MarkerSize', 8, 'MarkerFaceColor', 'r');
plot3(p_A(1), p_A(2), p_A(3), 'bo', 'MarkerSize', 8, 'MarkerFaceColor', 'b');

% 绘制旋转轨迹（圆弧）
t_values = linspace(0, theta, 50);
arc_points = zeros(3, length(t_values));
for i = 1:length(t_values)
    R_temp = R('y', t_values(i)); 
    arc_points(:, i) = R_temp * p_A;
end
plot3(arc_points(1,:), arc_points(2,:), arc_points(3,:), 'm-', 'LineWidth', 2);

% 添加标注
text(p_B(1)+0.1, p_B(2), p_B(3), 'p_B (旋转后)', 'FontSize', 10);
text(p_A(1)+0.1, p_A(2), p_A(3), 'p_A (初始点)', 'FontSize', 10);

% 添加旋转角度标注
angle_text = sprintf('旋转角度: %.0f°', rad2deg(theta));
text(-1, -1, 2.5, angle_text, 'FontSize', 12, 'BackgroundColor', 'white');

% 绘制从原点到点的连线
plot3([0, p_B(1)], [0, p_B(2)], [0, p_B(3)], 'k:', 'LineWidth', 1);
plot3([0, p_A(1)], [0, p_A(2)], [0, p_A(3)], 'k:', 'LineWidth', 1);
