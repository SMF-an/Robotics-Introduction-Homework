%% 给定参数
theta1 = 10.0;   
theta2 = 15.0;   
theta3 = 40.0;   
td12 = 1.0;      
td23 = 1.0;      
acc = 80.0;      

t1 = 0.065;      
t2 = 0.323;       
t3 = 0.388;     

theta_dot12 = 5.168;   
theta_dot23 = 31.017;  

tA = td12 - t2/2;          % 过渡段开始时间
tB = td12 + t2/2;          % 过渡段结束时间
t_dec = td12 + td23 - t3;  % 减速段开始时间
total_time = td12 + td23;  % 总时间

%% 分段计算轨迹
dt = 0.001;    % 时间分辨率
t = 0:dt:total_time;
N = length(t);

% 初始化
theta = zeros(1, N);
theta_dot = zeros(1, N);
theta_ddot = zeros(1, N);

for i = 1:N
    ti = t(i);
    
    if ti <= t1
        % 第一阶段：加速段（0~t1）
        theta_ddot(i) = acc;
        theta_dot(i) = acc * ti;
        theta(i) = theta1 + 0.5 * acc * ti^2;
        
    elseif ti <= tA
        % 第二阶段：匀速段1（t1~tA）
        % 计算t1时刻的状态
        theta1_end = theta1 + 0.5 * acc * t1^2;
        
        theta_ddot(i) = 0;
        theta_dot(i) = theta_dot12;
        theta(i) = theta1_end + theta_dot12 * (ti - t1);
        
    elseif ti <= tB
        % 第三阶段：过渡段（tA~tB）
        % 计算tA时刻的状态
        theta1_end = theta1 + 0.5 * acc * t1^2;
        thetaA = theta1_end + theta_dot12 * (tA - t1);
        
        theta_ddot(i) = acc;
        theta_dot(i) = theta_dot12 + acc * (ti - tA);
        theta(i) = thetaA + theta_dot12 * (ti - tA) + 0.5 * acc * (ti - tA)^2;
        
    elseif ti <= t_dec
        % 第四阶段：匀速段2（tB~t_dec）
        % 计算tB时刻的状态
        theta1_end = theta1 + 0.5 * acc * t1^2;
        thetaA = theta1_end + theta_dot12 * (tA - t1);
        thetaB = thetaA + theta_dot12 * t2 + 0.5 * acc * t2^2;
        
        theta_ddot(i) = 0;
        theta_dot(i) = theta_dot23;
        theta(i) = thetaB + theta_dot23 * (ti - tB);
        
    else
        % 第五阶段：减速段（t_dec~total_time）
        % 计算t_dec时刻的状态
        theta1_end = theta1 + 0.5 * acc * t1^2;
        thetaA = theta1_end + theta_dot12 * (tA - t1);
        thetaB = thetaA + theta_dot12 * t2 + 0.5 * acc * t2^2;
        theta_dec = thetaB + theta_dot23 * (t_dec - tB);
        
        tau = ti - t_dec;
        theta_ddot(i) = -acc;
        theta_dot(i) = theta_dot23 - acc * tau;
        theta(i) = theta_dec + theta_dot23 * tau - 0.5 * acc * tau^2;
    end
end

%% 绘制图形
figure('Position', [100, 100, 1200, 800]);

% 1. 位置曲线
subplot(3, 1, 1);
plot(t, theta, 'b-', 'LineWidth', 2);
hold on;
% 标记关键点
plot([t1, t1], [min(theta), max(theta)], 'r--', 'LineWidth', 1);
plot([tA, tA], [min(theta), max(theta)], 'g--', 'LineWidth', 1);
plot([tB, tB], [min(theta), max(theta)], 'g--', 'LineWidth', 1);
plot([t_dec, t_dec], [min(theta), max(theta)], 'm--', 'LineWidth', 1);
plot([total_time, total_time], [min(theta), max(theta)], 'k--', 'LineWidth', 1);

plot([0, t1/2], [theta1, theta1], 'k--', 'LineWidth', 1);
plot([t1/2, td12], [theta1, theta2], 'k--', 'LineWidth', 1);
plot([td12, total_time-t3/2], [theta2, theta3], 'k--', 'LineWidth', 1);
plot([total_time-t3/2, total_time], [theta3, theta3], 'k--', 'LineWidth', 1);

% 标记路径点
plot(td12, theta2, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
plot(t1/2, theta1, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');
plot(total_time-t3/2, theta3, 'ko', 'MarkerSize', 6, 'MarkerFaceColor', 'k');

xlabel('时间 (s)', 'FontSize', 12);
ylabel('位置 (°)', 'FontSize', 12);
title('位置曲线', 'FontSize', 14);
grid on;
xlim([0, total_time]);

% 2. 速度曲线
subplot(3, 1, 2);
plot(t, theta_dot, 'r-', 'LineWidth', 2);
hold on;
plot([t1, t1], [min(theta_dot), max(theta_dot)], 'r--', 'LineWidth', 1);
plot([tA, tA], [min(theta_dot), max(theta_dot)], 'g--', 'LineWidth', 1);
plot([tB, tB], [min(theta_dot), max(theta_dot)], 'g--', 'LineWidth', 1);
plot([t_dec, t_dec], [min(theta_dot), max(theta_dot)], 'm--', 'LineWidth', 1);
plot([total_time, total_time], [min(theta_dot), max(theta_dot)], 'k--', 'LineWidth', 1);

xlabel('时间 (s)', 'FontSize', 12);
ylabel('速度 (°/s)', 'FontSize', 12);
title('速度曲线', 'FontSize', 14);
grid on;
xlim([0, total_time]);

% 3. 加速度曲线
subplot(3, 1, 3);
stairs(t, theta_ddot, 'k-', 'LineWidth', 2); % 使用stairs显示分段常数
hold on;
plot([t1, t1], [min(theta_ddot), max(theta_ddot)], 'r--', 'LineWidth', 1);
plot([tA, tA], [min(theta_ddot), max(theta_ddot)], 'g--', 'LineWidth', 1);
plot([tB, tB], [min(theta_ddot), max(theta_ddot)], 'g--', 'LineWidth', 1);
plot([t_dec, t_dec], [min(theta_ddot), max(theta_ddot)], 'm--', 'LineWidth', 1);
plot([total_time, total_time], [min(theta_ddot), max(theta_ddot)], 'k--', 'LineWidth', 1);

xlabel('时间 (s)', 'FontSize', 12);
ylabel('加速度 (°/s²)', 'FontSize', 12);
title('加速度曲线', 'FontSize', 14);
grid on;
xlim([0, total_time]);
ylim([min(theta_ddot)-10, max(theta_ddot)+10]);
