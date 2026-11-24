%% 参数设置
theta0 = 5.0;     
thetav = 15.0;     
thetag = -15.0;    
t = 2.0;   

% 第一段三次样条系数
a0 = 5;
a1 = 0;
a2 = 7.5;
a3 = -2.5;

% 第二段三次样条系数
b0 = 15;
b1 = 0;
b2 = -22.5;
b3 = 7.5;

dt = 0.001;  % 时间分辨率
t1 = 0:dt:t;     
t2 = t:dt:2*t;  

%% 第一段轨迹计算
% 位置
theta1 = a0 + a1*t1 + a2*t1.^2 + a3*t1.^3;
% 速度
theta1_dot = a1 + 2*a2*t1 + 3*a3*t1.^2;
% 加速度
theta1_ddot = 2*a2 + 6*a3*t1;

%% 第二段轨迹计算
t2_ = t2 - t;
% 位置
theta2 = b0 + b1*t2_ + b2*t2_.^2 + b3*t2_.^3;
% 速度
theta2_dot = b1 + 2*b2*t2_ + 3*b3*t2_.^2;
% 加速度
theta2_ddot = 2*b2 + 6*b3*t2_;

%% 合并两段轨迹
t_total = [t1, t2];
theta = [theta1, theta2];
theta_dot = [theta1_dot, theta2_dot];
theta_ddot = [theta1_ddot, theta2_ddot];

%% 绘制图形
figure('Position', [100, 100, 1200, 800]);

% 1. 位置曲线
subplot(3, 1, 1);
plot(t_total, theta, 'b-', 'LineWidth', 2);
hold on;
% 标记关键点
plot(0, theta0, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
plot(t, thetav, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');
plot(2*t, thetag, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

xlabel('时间 (s)', 'FontSize', 12);
ylabel('位置 (°)', 'FontSize', 12);
title('位置曲线', 'FontSize', 14);
grid on;
xlim([0, 2*t]);
ylim([min(theta)-5, max(theta)+5]);

% 2. 速度曲线
subplot(3, 1, 2);
plot(t_total, theta_dot, 'r-', 'LineWidth', 2);
hold on;
% 标记中间点速度（应为0）
plot(t, 0, 'ro', 'MarkerSize', 6, 'MarkerFaceColor', 'r');

xlabel('时间 (s)', 'FontSize', 12);
ylabel('速度 (°/s)', 'FontSize', 12);
title('速度曲线', 'FontSize', 14);
grid on;
xlim([0, 2*t]);
ylim([min(theta_dot)-5, max(theta_dot)+5]);

% 3. 加速度曲线
subplot(3, 1, 3);
plot(t_total, theta_ddot, 'k-', 'LineWidth', 2);
hold on;

xlabel('时间 (s)', 'FontSize', 12);
ylabel('加速度 (°/s²)', 'FontSize', 12);
title('加速度曲线', 'FontSize', 14);
grid on;
xlim([0, 2*t]);
ylim([min(theta_ddot)-20, max(theta_ddot)+20]);
