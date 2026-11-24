%% 初始化清理
clc;
clear;
close all;

%% 1. 创建空的刚性体树（机器人）
robot = rigidBodyTree('DataFormat', 'column', 'MaxNumBodies', 5);

%% 2-4. 创建并添加连杆和关节（SCARA型）
% 基座
base = rigidBody('base');
height = 0.8;

% 第一个关节（旋转关节，绕Z轴）
body1 = rigidBody('link1');
joint1 = rigidBodyJoint('joint1', 'revolute');
dhparams1 = [0.3, 0, height, 0]; % DH参数: [a, alpha, d, theta]
setFixedTransform(joint1, dhparams1, 'dh');
joint1.JointAxis = [0 0 1]; % 绕Z轴旋转
body1.Joint = joint1;
addBody(robot, body1, 'base');

% 第二个关节（旋转关节，绕Z轴）
body2 = rigidBody('link2');
joint2 = rigidBodyJoint('joint2', 'revolute');
dhparams1 = [0.25, 0, 0, 0]; % DH参数: [a, alpha, d, theta]
setFixedTransform(joint2, dhparams1, 'dh');
joint2.JointAxis = [0 0 1]; % 绕Z轴旋转
body2.Joint = joint2;
addBody(robot, body2, 'link1');

% 第三个关节（平移关节，沿Z轴）
body3 = rigidBody('link3');
joint3 = rigidBodyJoint('joint3', 'prismatic');
setFixedTransform(joint3, trvec2tform([0, 0, 0]));
joint3.JointAxis = [0 0 1]; % 沿Z轴移动
body3.Joint = joint3;
addBody(robot, body3, 'link2');

% 末端执行器
endEffector = rigidBody('end_effector');
setFixedTransform(endEffector.Joint, trvec2tform([0, 0, 0.04])); % 末端长度
addBody(robot, endEffector, 'link3');

%% 5. 指定关节位置（SCARA型：角度1、角度2、高度）
q = [pi/4, -pi/6, -0.3]';
q_min = [-pi*2/3, -pi*2/3, -height];
q_max = [pi*2/3, pi*2/3, -0.1];

%% 6. 创建主图形窗口
fig_main = figure('Name', 'SCARA机械臂可视化', 'Position', [100, 100, 1200, 800]);

% 创建子图1：形象化机械臂
ax1 = subplot(1, 2, 1);
visualizeRobot(ax1, robot, q, height);
title('SCARA机械臂显示');
axis([-0.6 0.6 -0.6 0.6 -0.2 1.2]);
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;

% 添加地面
[x_ground, y_ground] = meshgrid(-0.6:0.1:0.6, -0.6:0.1:0.6);
z_ground = zeros(size(x_ground));
surf(ax1, x_ground, y_ground, z_ground, 'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');

%% 7. 计算并绘制工作空间
numPoints = 3000;
workspace_points = zeros(numPoints, 3);

% 设置SCARA机械臂的工作范围
theta1_range = linspace(q_min(1), q_max(1), 50);   % 第一个关节角度范围
theta2_range = linspace(q_min(2), q_max(2), 50);   % 第二个关节角度范围
z_range = linspace(q_min(3), q_max(3), 50);        % Z轴移动范围

for i = 1:numPoints
    theta1_rand = theta1_range(randi(length(theta1_range)));
    theta2_rand = theta2_range(randi(length(theta2_range)));
    z_rand = z_range(randi(length(z_range)));
    q_rand = [theta1_rand; theta2_rand; z_rand];
    
    tf_rand = getTransform(robot, q_rand, 'end_effector', 'base');
    pos_rand = tform2trvec(tf_rand);
    workspace_points(i, :) = pos_rand;
end

% 子图2：工作空间
ax2 = subplot(1, 2, 2);
visualizeRobot(ax2, robot, q, height);
hold(ax2, 'on');
scatter3(ax2, workspace_points(:,1), workspace_points(:,2), workspace_points(:,3), 10, 'filled', ...
         'MarkerFaceAlpha', 0.5, 'MarkerEdgeAlpha', 0.5, 'MarkerFaceColor', [0.2 0.6 0.8]);
title('SCARA机械臂工作空间');
axis([-0.6 0.6 -0.6 0.6 -0.2 1.2]);
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
grid on;

% 添加地面
surf(ax2, x_ground, y_ground, z_ground, 'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');

%% 8. 创建交互式控制窗口
createInteractiveControl(robot, q, q_min, q_max, height);
