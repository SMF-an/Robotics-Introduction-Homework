T = [1, 2, 3, 4;
     12, 13, 14, 5;
     11, 16, 15, 6;
     10, 9, 8, 7];

% 将 T 分块为 A, B, C, D
A = T(1:2, 1:2);  % 左上角 2x2 子矩阵
B = T(1:2, 3:4);  % 右上角 2x2 子矩阵
C = T(3:4, 1:2);  % 左下角 2x2 子矩阵
D = T(3:4, 3:4);  % 右下角 2x2 子矩阵

% 计算 A 的逆矩阵
det_A = A(1,1)*A(2,2) - A(1,2)*A(2,1);
A_inv = (1/det_A) * [A(2,2), -A(1,2); -A(2,1), A(1,1)];

% 计算 E = D - C * A_inv * B
E = D - C * A_inv * B;

% 计算 E 的逆矩阵
det_E = E(1,1)*E(2,2) - E(1,2)*E(2,1);
E_inv = (1/det_E) * [E(2,2), -E(1,2); -E(2,1), E(1,1)];

% 计算 T 的逆矩阵的分块
T_inv_11 = A_inv + A_inv * B * E_inv * C * A_inv;
T_inv_12 = -A_inv * B * E_inv;
T_inv_21 = -E_inv * C * A_inv;
T_inv_22 = E_inv;

% 组合成完整的逆矩阵
T_inv = [T_inv_11, T_inv_12; T_inv_21, T_inv_22];

disp('T 的逆矩阵 (使用分块方法):');
disp(T_inv);

% 验证结果：使用 MATLAB 内置函数计算逆矩阵
T_inv_builtin = inv(T);
disp('T 的逆矩阵 (使用 MATLAB 内置函数):');
disp(T_inv_builtin);

% 检查两个结果是否相等（考虑浮点误差）
difference = norm(T_inv - T_inv_builtin);
disp(['两种方法的差异范数: ', num2str(difference)]);

% 验证逆矩阵性质：T * T_inv 应该接近单位矩阵
identity_check = T * T_inv;
disp('T * T_inv (应该接近单位矩阵):');
disp(identity_check);