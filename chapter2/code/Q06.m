syms l

T_0_1 = [-1/sqrt(6), -1/sqrt(2), 1/sqrt(3), l/2;
         1/sqrt(6), -1/sqrt(2), -1/sqrt(3), l/2;
         2/sqrt(6), 0, 1/sqrt(3), l/2;
         0, 0, 0, 1];

T_0_2 = [0, -1, 0, l;
         0, 0, 1, l/2;
         -1, 0, 0, 0;
         0, 0, 0, 1];

T_1_2 = T_INV_sym(T_0_1) * T_0_2;
fprintf('T_1_2:\n');disp(T_1_2);
