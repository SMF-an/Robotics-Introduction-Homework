function J = J(T, q)
% 使用符号微分直接计算雅可比矩阵
% 输入:
%   T - 变换矩阵
%   q - 符号关节变量向量
% 输出:
%   J - 符号雅可比矩阵

    n = length(q);
    J = sym(zeros(6, n));
    
    % 获取变换矩阵
    p = T(1:3, 4); % 位置向量
    R = T(1:3, 1:3); % 旋转矩阵
    
    for i = 1:n
        % 位置导数（线速度部分）
        J(1:3, i) = diff(p, q(i));
        
        % 姿态导数（角速度部分）
        dR = diff(R, q(i));
        
        omega_skew = dR * R.';  % 角速度的反对称矩阵
        J(4:6, i) = [omega_skew(3,2);  % ω_x
                     omega_skew(1,3);  % ω_y  
                     omega_skew(2,1)]; % ω_z
    end
end