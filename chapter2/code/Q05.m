syms a b h c d

T_0_2 = [0, 0, 1, -b;
         1, 0, 0, 0;
         0, 1, 0, 0;
         0, 0, 0, 1];

T_0_1 = [1, 0, 0, -b;
         0, -1, 0, a;
         0, 0, -1, h;
         0, 0, 0, 1];

T_0_3 = [1, 0, 0, -b;
         0, a/d, c/d, 0;
         0, -c/d, a/d, h+c;
         0, 0, 0, 1];

T_3_4 = [-1, 0, 0, b;
         0, 1, 0, 0;
         0, 0, -1, 0;
         0, 0, 0, 1];

T_0_4 = T_0_3 * T_3_4;
T_1_2 = T_INV_sym(T_0_1) * T_0_2;
T_2_3 = T_INV_sym(T_0_2) * T_0_3;

fprintf('符号结果:\n');
fprintf('T_0_1:\n');disp(T_0_1);
fprintf('T_0_2:\n');disp(T_0_2);
fprintf('T_0_3:\n');disp(T_0_3);
fprintf('T_0_4:\n');disp(T_0_4);
fprintf('T_1_2:\n');disp(T_1_2);
fprintf('T_2_3:\n');disp(T_2_3);
fprintf('T_3_4:\n');disp(T_3_4);

a_val = 76.2;
b_val = 88.9;
h_val = 20;
c_val = 101.6;
d_val = 127;

T_0_1_num = double(subs(T_0_1, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_0_2_num = double(subs(T_0_2, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_0_3_num = double(subs(T_0_3, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_0_4_num = double(subs(T_0_4, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_1_2_num = double(subs(T_1_2, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_2_3_num = double(subs(T_2_3, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));
T_3_4_num = double(subs(T_3_4, {a, b, h, c, d}, {a_val, b_val, h_val, c_val, d_val}));

fprintf('\n数值结果:\n');
fprintf('T_0_1:\n'); disp(T_0_1_num);
fprintf('T_0_2:\n'); disp(T_0_2_num);
fprintf('T_0_3:\n'); disp(T_0_3_num);
fprintf('T_0_4:\n'); disp(T_0_4_num);
fprintf('T_1_2:\n'); disp(T_1_2_num);
fprintf('T_2_3:\n'); disp(T_2_3_num);
fprintf('T_3_4:\n'); disp(T_3_4_num);
