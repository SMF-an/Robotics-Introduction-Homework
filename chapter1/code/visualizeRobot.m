%% 自定义可视化函数
function visualizeRobot(ax, robot, q, height)
    % 清除坐标轴
    cla(ax);
    hold(ax, 'on');
    
    % 获取所有变换矩阵
    T0 = getTransform(robot, q, 'link1', 'base');
    T1 = getTransform(robot, q, 'link2', 'base');
    T2 = getTransform(robot, q, 'link3', 'base');
    T3 = getTransform(robot, q, 'end_effector', 'base');
    
    % 提取位置
    p0 = [0, 0, height]; % 基座位置
    p1 = tform2trvec(T0); % 关节1位置
    p2 = tform2trvec(T1); % 关节2位置
    p3 = tform2trvec(T2); % 关节3位置
    p4 = tform2trvec(T3); % 末端位置

    % 绘制基座
    drawCylinderBetweenPoints(ax, [0, 0, 0], p0, 0.0015, [0 0 1]);
    text(ax, p0(1)/2, p0(2)/2, p0(3)/2, '基座', 'FontSize', 10, 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制关节1 
    drawSphere(ax, p1, 0.04, [1 0 0]);
    text(ax, p1(1), p1(2), p1(3)+0.03, '关节1', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制连杆1 (从基座到关节1) 
    drawCylinderBetweenPoints(ax, p0, p1, 0.0015, [0 0 1]);
    text(ax, (p0(1)+p1(1))/2, (p0(2)+p1(2))/2, (p0(3)+p1(3))/2, '连杆1', 'FontSize', 10, 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制关节2 
    drawSphere(ax, p2, 0.04, [1 0 0]);
    text(ax, p2(1), p2(2), p2(3)+0.03, '关节2', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制连杆2 (从关节1到关节2) 
    drawCylinderBetweenPoints(ax, p1, p2, 0.0015, [0 0 1]);
    text(ax, (p1(1)+p2(1))/2, (p1(2)+p2(2))/2, (p1(3)+p2(3))/2, '连杆2', 'FontSize', 10, 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制关节3 
    drawSphere(ax, p3, 0.04, [1 0 0]);
    text(ax, p3(1), p3(2), p3(3)+0.03, '关节3', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制连杆3 (从关节2到关节3) 
    drawCylinderBetweenPoints(ax, p2, p3, 0.0015, [0 0 1]);
    text(ax, (p2(1)+p3(1))/2, (p2(2)+p3(2))/2, (p2(3)+p3(3))/2, '连杆3', 'FontSize', 10, 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 绘制末端执行器
    drawEndEffector(ax, p4, [0 1 0]);
    text(ax, p4(1), p4(2), p4(3)-0.03, '末端', 'FontSize', 10, 'FontWeight', 'bold', 'Color', 'k', 'HorizontalAlignment', 'center');
    
    % 设置坐标轴属性
    axis(ax, 'equal');
    xlabel(ax, 'X (m)');
    ylabel(ax, 'Y (m)');
    zlabel(ax, 'Z (m)');
    grid(ax, 'on');
    view(ax, 45, 30);
    
    % 添加光照
    light(ax, 'Position', [1 1 1], 'Style', 'infinite');
    lighting(ax, 'gouraud');
    material(ax, 'shiny');
end
