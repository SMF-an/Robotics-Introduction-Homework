function flag = iforth(R)
% 检查是否是旋转矩阵（正交且行列式≈1）
    flag = true;
    tolerance = 0.01;

    if ~ismatrix(R) || any(size(R) ~= [3, 3])
        fprintf('输入矩阵不是3*3方阵\n')
        flag = false;
    end

    if norm(R'*R - eye(3), 'fro') > tolerance
        fprintf('输入矩阵不是正交矩阵\n')
        flag = false;
    end
    
    if abs(det(R) - 1) > tolerance
        fprintf('输入矩阵行列式不为1\n')
        flag = false;
    end
end

