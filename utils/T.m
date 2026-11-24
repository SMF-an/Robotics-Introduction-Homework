function T = T(R, p)
% 将旋转矩阵R和平移向量构成齐次变换矩阵T

    T = eye(4);
    T(1:3, 1:3) = R;
    T(1:3, 4) = p;
end

