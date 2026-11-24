U_T_P = [0, 1, 0, -1;
         0, 0, -1, 3;
         -1, 0, 0, 4;
         0, 0, 0, 1];

U_T_B = [1, 0, 0, 1;
         0, 1, 0, 5;
         0, 0, 1, 9;
         0, 0, 0, 1];

H_T_B = T_INV(U_T_P) * U_T_B;
disp(H_T_B);

% 验证结果：通过变换链验证手爪是否与工件重合
verification = U_T_B * T_INV(H_T_B);
disp('验证结果 (U_T_B * B_T_H):');
disp(verification);

% 检查是否与 U_T_P 相等（考虑数值误差）
tolerance = 1e-10;
if max(abs(verification(:) - U_T_P(:))) < tolerance
    disp('验证成功！手爪与工件重合。');
else
    disp('验证失败！');
end
