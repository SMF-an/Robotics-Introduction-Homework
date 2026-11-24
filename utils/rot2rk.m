function [axis, angle] = rot2rk(R)
%将旋转矩阵转换为轴角表示
%
% 输入:
%   R - 3x3 旋转矩阵
%
% 输出:
%   axis - 旋转轴单位向量 (3x1)
%   angle - 旋转角度 (弧度)
%
% 说明:
%   使用旋转矩阵的迹和特征值分解来提取旋转轴和角度
%   处理特殊情况：零旋转和180度旋转

    if iforth(R) == false
        error('输入的矩阵不是旋转矩阵')
    end
    
    % 计算旋转角度（使用矩阵的迹）
    traceR = trace(R);
    angle = acos((traceR - 1) / 2);
    
    tolerance = 10e-6;
    % 处理数值误差
    if angle < tolerance
        % 零旋转情况
        axis = [1; 0; 0]; % 任意轴
        angle = 0;
        return;
    elseif abs(angle - pi) < tolerance
        % 180度旋转特殊情况
        % 旋转轴是 R+I 的非零特征向量
        [V, D] = eig(R);
        % 找到特征值接近1的特征向量
        for i = 1:3
            if abs(D(i,i) - 1) < tolerance
                axis = real(V(:,i));
                axis = axis / norm(axis);
                % 确保轴的方向一致（选择第一个非零分量正的）
                if axis(1) < 0
                    axis = -axis;
                end
                return;
            end
        end
        % 如果没找到，使用备选方法
        axis = [sqrt((R(1,1)+1)/2); sqrt((R(2,2)+1)/2); sqrt((R(3,3)+1)/2)];
        % 处理符号
        if R(1,2) < 0
            axis(2) = -axis(2);
        end
        if R(1,3) < 0
            axis(3) = -axis(3);
        end
        axis = axis / norm(axis);
    else
        % 一般情况：使用反对称部分提取旋转轴
        skew = (R - R') / (2 * sin(angle));
        axis = [skew(3,2); skew(1,3); skew(2,1)];
        axis = axis / norm(axis);
    end
    
    % 确保角度在 [0, π] 范围内
    if angle > pi
        angle = 2*pi - angle;
        axis = -axis;
    end
end
