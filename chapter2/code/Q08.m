Rx = R('x', pi/3);
Rz = R('z', pi/6);
R_ = Rz * Rx;

disp(R_);

% 法一
current = R_;
tol = 1e-4;
max_iter = 1e6;
n = 1;
I = eye(3);
    
while n <= max_iter
    if norm(current - I) < tol  
        break;
    end
    current = current * R_;  
    n = n + 1;
end

if n > max_iter
    error('超过最大迭代次数，未找到满足条件的n');
else
    disp(n);
end

% 法二
[axis, angle] = rot2rk(R_);
angle_deg = rad2deg(angle);
    
fprintf('复合旋转矩阵的旋转角度: %.6f 度\n', angle_deg);
fprintf('旋转轴: [%.6f, %.6f, %.6f]\n', axis);
    
% 寻找最小的 k，使得 k * angle_deg 是 360 的整数倍
k = 1;
while k <= max_iter
    ratio = k * angle_deg / 360;
    if abs(ratio - round(ratio)) < tol
        break;
    end
    k = k + 1;
end
    
if k > max_iter
    error('未找到 k within %d 次迭代', max_iter);
end
    
fprintf('需要重复旋转 %d 次后点 P 回到初始位置\n', k);
    
% 验证
R__ = R('k', angle, axis);
disp(R__);

R_k = R__^k;
disp(R_k);
