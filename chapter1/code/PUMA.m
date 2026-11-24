%% 初始化清理
clc;
clear;
close all;

%% 1. 创建空的刚性体树（机器人）
robot = rigidBodyTree('DataFormat', 'column', 'MaxNumBodies', 5);

%% 2-4. 创建并添加连杆和关节
% 基座
base = rigidBody('base');
height = 0.5;

% 第一个连杆和关节
body1 = rigidBody('link1');
joint1 = rigidBodyJoint('joint1', 'revolute');
dhparams1 = [0, pi/2, height, 0];
setFixedTransform(joint1, dhparams1, 'dh');
body1.Joint = joint1;
addBody(robot, body1, robot.BaseName);

% 第二个连杆和关节
body2 = rigidBody('link2');
joint2 = rigidBodyJoint('joint2', 'revolute');
dhparams2 = [0.4, 0, 0, 0];
setFixedTransform(joint2, dhparams2, 'dh');
body2.Joint = joint2;
addBody(robot, body2, 'link1');

% 第三个连杆和关节
body3 = rigidBody('link3');
joint3 = rigidBodyJoint('joint3', 'revolute');
dhparams3 = [0.4, 0, 0, 0];
setFixedTransform(joint3, dhparams3, 'dh');
body3.Joint = joint3;
addBody(robot, body3, 'link2');

% 末端执行器
endEffector = rigidBody('end_effector');
setFixedTransform(endEffector.Joint, trvec2tform([0 0 0.04])); % 末端长度
addBody(robot, endEffector, 'link3');

%% 5. 指定关节角度
q = [0.5, 0.8, -0.3]';
q_min = [-pi*2/3, -pi/4, -pi*2/3];
q_max = [pi*2/3, pi/3, pi*2/3];

%% 6. 创建主图形窗口
fig_main = figure('Name', 'PUMA机械臂可视化', 'Position', [100, 100, 1200, 800]);

% 创建子图1：形象化机械臂
ax1 = subplot(1, 2, 1);
visualizeRobot(ax1, robot, q, height);
title('形象化机械臂显示');
axis([-1 1 -1 1 -0.2 1.2]);
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;

% 添加地面
[x_ground, y_ground] = meshgrid(-1:0.2:1, -1:0.2:1);
z_ground = zeros(size(x_ground));
surf(ax1, x_ground, y_ground, z_ground, 'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');

%% 7. 计算并绘制工作空间
numPoints = 3000;
workspace_points = zeros(numPoints, 3);
q1_range = linspace(q_min(1), q_max(1), 100);
q2_range = linspace(q_min(2), q_max(2), 100);
q3_range = linspace(q_min(3), q_max(3), 100);

for i = 1:numPoints
    q1 = q1_range(randi(length(q1_range)));
    q2 = q2_range(randi(length(q2_range)));
    q3 = q3_range(randi(length(q3_range)));
    q_rand = [q1; q2; q3];
    
    tf_rand = getTransform(robot, q_rand, 'end_effector', 'base');
    pos_rand = tform2trvec(tf_rand);
    
    if pos_rand(3) > 0
        workspace_points(i, :) = pos_rand;
    else
        i = i - 1;
    end
end

% 子图2：工作空间
ax2 = subplot(1, 2, 2);
visualizeRobot(ax2, robot, q, height);
hold(ax2, 'on');
scatter3(ax2, workspace_points(:,1), workspace_points(:,2), workspace_points(:,3), 10, 'filled', ...
         'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5, 'MarkerFaceColor', [0.2 0.6 0.8]);
title('机械臂工作空间');
axis([-1 1 -1 1 -0.2 1.2]);
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;

% 添加地面
surf(ax2, x_ground, y_ground, z_ground, 'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');

%% 8. 创建交互式控制窗口
createInteractiveControl(robot, q, q_min, q_max, height);
