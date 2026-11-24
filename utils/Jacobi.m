function J_col = Jacobi(T, joint_type)
% 使用微分变换法计算雅可比矩阵的某一列
% 输入:
%   T - 当前关节相对于基坐标系的齐次变换矩阵 (4x4)，可以是符号矩阵
%   joint_type - 关节类型: 'revolute' (旋转) 或 'prismatic' (平移)
% 输出:
%   J_col - 雅可比矩阵的对应列 (6x1)，类型与输入保持一致

    % 验证输入
    if nargin < 2
        error('需要2个输入参数: T, joint_type');
    end
    
    if ~ismatrix(T) || size(T,1) ~= 4 || size(T,2) ~= 4
        error('T 必须是 4x4 的齐次变换矩阵');
    end
    
    % 检查输入类型并相应初始化 J_col
    if isa(T, 'sym')
        % 如果是符号矩阵，初始化符号类型的零矩阵
        J_col = sym(zeros(6, 1));
    else
        % 如果是数值矩阵，初始化双精度零矩阵
        J_col = zeros(6, 1);
    end
    
    % 提取位置向量
    p = T(1:3, 4);

    p_x = p(1);
    p_y = p(2);
    p_z = p(3);
    
    % 提取旋转矩阵
    R = T(1:3, 1:3);

    n_x = R(1, 1);
    n_y = R(2, 1);
    n_z = R(3, 1);
    o_x = R(1, 2);
    o_y = R(2, 2);
    o_z = R(3, 2);
    a_x = R(1, 3);
    a_y = R(2, 3);
    a_z = R(3, 3);
    
    % 根据关节类型计算雅可比矩阵列
    switch lower(joint_type)
        case 'revolute'  % 旋转关节
            J_col(1) = n_y * p_x - n_x * p_y;
            J_col(2) = o_y * p_x - o_x * p_y;
            J_col(3) = a_y * p_x - a_x * p_y;
            J_col(4) = n_z;
            J_col(5) = o_z;
            J_col(6) = a_z;
            
        case 'prismatic' % 平移关节
            J_col(1) = n_z;
            J_col(2) = o_z;
            J_col(3) = a_z;
            % 注意：平移关节的角速度部分保持为0
            
        otherwise
            error('不支持的关节类型。请使用 "revolute" 或 "prismatic"');
    end
end