Rx = R('x', pi/3);
Rz = R('z', pi/6);
R_ = Rz * Rx;

disp(R_); 

rows = size(R_, 1);
tol = 1e-4;
    
% 检查R是否已经是单位矩阵
if norm(R_ - eye(rows)) < tol
    n = 1;
    fprintf('R已经是单位矩阵，n = 1\n');
else  
    % 计算特征值
    eigenvalues = eig(R_);
    fprintf('R的特征值为：\n')
    disp(eigenvalues);
    
    % 检查特征值是否在单位圆上
    magnitudes = abs(eigenvalues);
    if any(abs(magnitudes - 1) > tol)
        warning('有些特征值不在单位圆上，可能不存在有限的n使得R^n = I');
        % 继续计算，但结果可能不准确
    end
    
    % 为每个特征值找到最小的k使得λ^k = 1
    orders = [];
    
    for i = 1:length(eigenvalues)
        lambda = eigenvalues(i);
        
        % 跳过非常接近1的特征值（阶为1）
        if abs(lambda - 1) < tol
            orders = [orders, 1];
            continue;
        end
        
        % 找到最小的k使得λ^k ≈ 1
        k = find_eigenvalue_order(lambda, tol);
        
        if k > 0
            orders = [orders, k];
        else
            warning('无法找到特征值λ = %.6f + %.6fi的阶', real(lambda), imag(lambda));
        end
    end
    
    % 移除重复的阶（优化计算）
    unique_orders = unique(orders);
    
    % 计算所有阶的最小公倍数
    if isempty(unique_orders)
        error('无法确定矩阵的阶');
    end
    
    n = unique_orders(1);
    for i = 2:length(unique_orders)
        n = lcm(n, unique_orders(i));
    end
    
    % 验证结果
    fprintf('计算得到的阶 n = %d\n', n);
    fprintf('验证 R^%d 是否接近单位矩阵:\n', n);
    
    R_power = R_^n;
    disp(R_power);
    error_norm = norm(R_power - eye(rows));
    fprintf('||R^%d - I|| = %.2e\n', n, error_norm);
    
    if error_norm > tol
        warning('验证误差较大，可能需要检查矩阵性质');
    end
end

function k = find_eigenvalue_order(lambda, tol)
% 找到最小的正整数k使得λ^k ≈ 1

    lambda_power = lambda;
    max_k = 1e6;  % 设置最大搜索范围
    k = 1;

    while k <= max_k
        
        % 检查是否接近1
        if abs(lambda_power - 1) < tol
            return;
        end
        
        % 对于实数特征值，检查是否接近1或-1
        if abs(imag(lambda)) < tol
            if abs(lambda_power - 1) < tol || abs(lambda_power + 1) < tol
                return;
            end
        end

        lambda_power = lambda_power * lambda;
        k = k + 1;
    end
    
    % 如果没找到，返回-1表示失败
    k = -1;
end

% 辅助函数：计算最小公倍数
function result = lcm(a, b)
    result = a * b / gcd(a, b);
end

% 辅助函数：计算最大公约数
function result = gcd(a, b)
    while b ~= 0
        temp = b;
        b = mod(a, b);
        a = temp;
    end
    result = a;
end
