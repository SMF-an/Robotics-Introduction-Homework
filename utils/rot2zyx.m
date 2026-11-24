function [yaw, pitch, roll] = rot2zyx(R)
% ROT2ZYX 将旋转矩阵转换为X-Y-Z固定角 （或Z-Y-X 欧拉角）
%
% 输入:
%   R - 3x3 旋转矩阵
%
% 输出:
%   yaw - 绕 Z 轴旋转的角度（偏航角）
%   pitch - 绕 Y 轴旋转的角度（俯仰角）
%   roll - 绕 X 轴旋转的角度（翻滚角）

    if iforth(R) == false
        error('输入的矩阵不是旋转矩阵')
    end

    r11 = R(1,1); r12 = R(1,2); r13 = R(1,3);
    r21 = R(2,1); r22 = R(2,2); r23 = R(2,3);
    r31 = R(3,1); r32 = R(3,2); r33 = R(3,3);
    
    tolerance = 1e-10;
    
    % 检查是否出现万向节锁 (cos(pitch) ≈ 0)
    if abs(r31) > 1 - tolerance
        % 退化情况：pitch = ±90°
        if r31 < -tolerance  % pitch = 90°
            yaw = 0;
            pitch = pi/2;
            roll = atan2(r12, r22);
        else  % pitch = -90°
            yaw = 0;
            pitch = -pi/2;
            roll = -atan2(r12, r22);
        end
        warning('万向节锁：pitch = %f°', rad2deg(pitch));
    else
        % 正常情况
        pitch = asin(-r31);
        yaw = atan2(r21/cos(pitch), r11/cos(pitch));
        roll = atan2(r32/cos(pitch), r33/cos(pitch));
    end
    
    % 确保角度在合理范围内
    yaw = mod(yaw, 2*pi);
    pitch = max(-pi/2, min(pi/2, pitch)); % 限制pitch在[-90°, 90°]
    roll = mod(roll, 2*pi);
end
