function T_inv = T_INV(T)
% 齐次变换矩阵求逆函数
%
% 输入:
%   T - 4x4 齐次变换矩阵
% 输出:
%   T_inv - T 的逆矩阵 (4x4)
%
% 齐次变换矩阵形式:
%   T = [ R(3x3)  p(3x1)
%         0(1x3)   1    ]
%
% 逆矩阵公式:
%   T_inv = [ R'   -R'*p
%             0      1   ]

    % 检查输入矩阵的维度
    if ~isequal(size(T), [4, 4])
        error('输入矩阵必须是 4x4 矩阵');
    end
    
    % 检查最后一行是否为 [0, 0, 0, 1]
    if ~isequal(T(4, :), [0, 0, 0, 1])
        warning('输入矩阵的最后一行不是 [0, 0, 0, 1]，可能不是有效的齐次变换矩阵');
    end
    
    % 提取旋转矩阵 R 和平移向量 p
    R = T(1:3, 1:3);
    p = T(1:3, 4);

    R_inv = R.';
    p_new = -R_inv * p;
    
    % 构建逆矩阵
    T_inv = eye(4);
    T_inv(1:3, 1:3) = R_inv;
    T_inv(1:3, 4) = p_new;
end