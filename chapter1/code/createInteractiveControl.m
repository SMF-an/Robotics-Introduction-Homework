%% 创建机械臂交互式控制窗口
function createInteractiveControl(robot, q_init, q_min, q_max, height)  
    % 创建交互窗口
    fig_interactive = figure('Name', '交互式机械臂控制', 'Position', [200, 200, 600, 500]);
    
    % 初始化数据存储结构体
    handles = struct();
    handles.robot = robot;               % 机器人模型
    [handles.x_ground, handles.y_ground] = meshgrid(-1:0.2:1, -1:0.2:1);
    handles.z_ground = zeros(size(handles.x_ground));
    
    % 创建关节角度滑块
    handles.q1_slider = uicontrol('Style', 'slider', 'Min', q_min(1), 'Max', q_max(1), ...
        'Value', q_init(1), 'Position', [100 70 400 20], ...
        'Callback', {@updatePlot, fig_interactive});
    
    handles.q2_slider = uicontrol('Style', 'slider', 'Min', q_min(2), 'Max', q_max(2), ...
        'Value', q_init(2), 'Position', [100 100 400 20], ...
        'Callback', {@updatePlot, fig_interactive});
    
    handles.q3_slider = uicontrol('Style', 'slider', 'Min', q_min(3), 'Max', q_max(3), ...
        'Value', q_init(3), 'Position', [100 130 400 20], ...
        'Callback', {@updatePlot, fig_interactive});
    
    % 创建滑块标签
    uicontrol('Style', 'text', 'Position', [50 65 40 20], 'String', '关节1');
    uicontrol('Style', 'text', 'Position', [50 95 40 20], 'String', '关节2');
    uicontrol('Style', 'text', 'Position', [50 125 40 20], 'String', '关节3');
    
    % 创建角度显示文本框
    handles.q1_text = uicontrol('Style', 'text', 'Position', [510 65 60 20], ...
        'String', num2str(q_init(1)));
    handles.q2_text = uicontrol('Style', 'text', 'Position', [510 95 60 20], ...
        'String', num2str(q_init(2)));
    handles.q3_text = uicontrol('Style', 'text', 'Position', [510 125 60 20], ...
        'String', num2str(q_init(3)));
    
    % 添加角度单位标签
    uicontrol('Style', 'text', 'Position', [575 65 20 20], 'String', 'rad');
    uicontrol('Style', 'text', 'Position', [575 95 20 20], 'String', 'rad');
    uicontrol('Style', 'text', 'Position', [575 125 20 20], 'String', 'rad');
    
    % 创建机械臂显示坐标轴
    handles.ax = axes('Parent', fig_interactive, 'Position', [0.1 0.3 0.8 0.6]);
    visualizeRobot(handles.ax, robot, q_init, height);
    hold(handles.ax, 'on');
    surf(handles.ax, handles.x_ground, handles.x_ground, handles.x_ground, ...
        'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');
    axis(handles.ax, [-1 1 -1 1 -0.2 1.2]);
    grid(handles.ax, 'on');
    title(handles.ax, sprintf('关节角度: [%.2f, %.2f, %.2f] rad', ...
        q_init(1), q_init(2), q_init(3)));
    
    % 保存句柄数据
    guidata(fig_interactive, handles);
    
    % 回调函数：更新机械臂显示
    function updatePlot(source, event, fig)
        handles = guidata(fig);
        
        % 获取当前关节角度
        q1_val = handles.q1_slider.Value;
        q2_val = handles.q2_slider.Value;
        q3_val = handles.q3_slider.Value;
        q_new = [q1_val; q2_val; q3_val];
        
        % 更新角度显示文本框
        handles.q1_text.String = num2str(q1_val, '%.4f');
        handles.q2_text.String = num2str(q2_val, '%.4f');
        handles.q3_text.String = num2str(q3_val, '%.4f');
        
        % 更新机械臂姿态
        visualizeRobot(handles.ax, handles.robot, q_new, height);
        hold(handles.ax, 'on');
        surf(handles.ax, handles.x_ground, handles.y_ground, handles.z_ground, ...
            'FaceAlpha', 0.2, 'FaceColor', [0.5 0.5 0.5], 'EdgeColor', 'none');
        
        % 保持显示参数
        view(handles.ax, 45, 30);
        axis(handles.ax, [-1 1 -1 1 -0.2 1.2]);
        grid(handles.ax, 'on');
        title(handles.ax, sprintf('关节角度: [%.2f, %.2f, %.2f] rad', ...
            q1_val, q2_val, q3_val));
        
        % 保存更新后的句柄数据
        guidata(fig, handles);
    end
end
