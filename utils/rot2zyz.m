function [alpha, beta, gamma] = rot2zyz(R)
% ROT2ZYZ 将旋转矩阵转换为 Z-Y-Z 欧拉角
%
% 输入:
%   R - 3x3 旋转矩阵
%
% 输出:
%   alpha - 绕 Z 轴第一次旋转的角度
%   beta - 绕 Y 轴旋转的角度  
%   gamma - 绕 Z 轴第二次旋转的角度
%
% 注意: 当 beta = 0 或 pi 时，存在万向节锁，此时 alpha 和 gamma 不唯一
    
    if iforth(R) == false
        error('输入的矩阵不是旋转矩阵')
    end
    
    r11 = R(1,1); r12 = R(1,2); r13 = R(1,3);
    r21 = R(2,1); r22 = R(2,2); r23 = R(2,3);
    r31 = R(3,1); r32 = R(3,2); r33 = R(3,3);
    
    % 计算 beta 角 (绕 Y 轴旋转)
    beta = acos(r33);
    
    % 处理数值误差
    if r33 > 1
        beta = 0;
    elseif r33 < -1
        beta = pi;
    end
    
    tolerance = 1e-6;
    % 检查是否出现万向节锁 (sin(beta) ≈ 0)
    if abs(sin(beta)) < tolerance
        % 退化情况：beta = 0 或 beta = pi
        % 此时只能确定 alpha + gamma
        if beta < tolerance  % beta = 0
            alpha = 0;
            gamma = atan2(-r12, r11);
        else  % beta = pi
            alpha = 0;
            gamma = atan2(r12, -r11);
        end
        warning('万向节锁：beta = %f°', rad2deg(beta));
    else
        % 正常情况
        alpha = atan2(r23/sin(beta), r13/sin(beta));
        gamma = atan2(r32/sin(beta), -r31/sin(beta));
    end
    
    % 确保角度在合理范围内
    alpha = mod(alpha, 2*pi);
    beta = mod(beta, 2*pi); 
    gamma = mod(gamma, 2*pi);
end
