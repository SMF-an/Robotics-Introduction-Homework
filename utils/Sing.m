function comprehensive_singularity_analysis()
    syms theta1 theta2 theta3 l1 l2 l3 real
    
    % 示例：3R机械臂的雅可比矩阵
    % 这里使用一个简单的平面3R机械臂作为示例
    J = [
        -l1*sin(theta1) - l2*sin(theta1+theta2) - l3*sin(theta1+theta2+theta3), ...
        -l2*sin(theta1+theta2) - l3*sin(theta1+theta2+theta3), ...
        -l3*sin(theta1+theta2+theta3);
        
        l1*cos(theta1) + l2*cos(theta1+theta2) + l3*cos(theta1+theta2+theta3), ...
        l2*cos(theta1+theta2) + l3*cos(theta1+theta2+theta3), ...
        l3*cos(theta1+theta2+theta3);
        
        1, 1, 1  % 平面机械臂，所有关节产生绕z轴的旋转
    ];
    
    q_vars = [theta1, theta2, theta3];
    
    fprintf('雅可比矩阵:\n');
    disp(J);
    
    % 方法1: 行列式法
    fprintf('\n=== 方法1: 行列式法 ===\n');
    find_singularities(J, q_vars);
    
    % 方法2: 奇异值分解法
    fprintf('\n=== 方法2: 奇异值分解法 ===\n');
    q_sample = [0, pi/2, 0];  % 示例配置
    analyze_singularities_svd(J, q_vars, q_sample);
    
    % 方法3: 秩分析
    fprintf('\n=== 方法3: 秩分析 ===\n');
    analyze_rank(J, q_vars);
end

function analyze_rank(J, q_vars)
% 通过秩分析寻找奇异位形

    fprintf('符号秩分析:\n');
    
    % 计算雅可比矩阵的秩
    J_rank = rank(J);
    fprintf('雅可比矩阵的秩: %d\n', J_rank);
    fprintf('雅可比矩阵大小: %dx%d\n', size(J));
    
    % 如果秩小于最小维度，则存在奇异
    min_dim = min(size(J));
    if J_rank < min_dim
        fprintf('⚠️ 雅可比矩阵秩亏！秩 = %d < %d\n', J_rank, min_dim);
    else
        fprintf('✓ 雅可比矩阵满秩\n');
    end
    
    % 分析导致秩亏的条件
    fprintf('\n寻找秩亏条件:\n');
    
    % 对于简单情况，可以分析子矩阵的行列式
    if size(J,1) >= size(J,2)  % 胖矩阵或方阵
        % 分析所有可能的子矩阵
        analyze_submatrices(J, q_vars);
    end
end

function analyze_submatrices(J, q_vars)
% 分析雅可比矩阵的子矩阵

    n = size(J, 2);  % 关节数量
    
    fprintf('分析 %dx%d 子矩阵:\n', n, n);
    
    % 如果雅可比矩阵不是方阵，选择前n行
    if size(J,1) > n
        J_sub = J(1:n, :);
    else
        J_sub = J;
    end
    
    % 计算子矩阵的行列式
    sub_det = det(J_sub);
    fprintf('子矩阵行列式:\n');
    disp(simplify(sub_det));
    
    % 求解行列式为零的条件
    singular_conditions = solve(sub_det == 0, q_vars);
    
    if ~isempty(singular_conditions)
        fprintf('奇异位形条件:\n');
        disp(singular_conditions);
    else
        fprintf('未找到明显的奇异位形条件\n');
    end
end
