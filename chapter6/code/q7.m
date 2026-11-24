syms theta1 theta2 theta3 l1 l2 l3 m3

dh_table = [0, 0, 0, theta1;
            l1, 0, 0, theta2;
            l2, 0, 0, theta3;
            l3, 0, 0, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));

T_0_3 = T_0_1 * T_1_2 * T_2_3;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);
fprintf("T_2_3:\n");
disp(T_2_3);

fprintf("T_0_3:\n");
disp(mylatex(T_0_3));

T_0_3_d1 = diff(T_0_3, theta1);
T_0_3_d1d1 = diff(T_0_3_d1, theta1);
T_0_3_d1d2 = diff(T_0_3_d1, theta2);
T_0_3_d1d3 = diff(T_0_3_d1, theta3);
T_0_3_d2 = diff(T_0_3, theta2);
T_0_3_d2d2 = diff(T_0_3_d2, theta2);
T_0_3_d2d3 = diff(T_0_3_d2, theta3);
T_0_3_d3 = diff(T_0_3, theta3);
T_0_3_d3d3 = diff(T_0_3_d3, theta3);

fprintf("T_0_3_d1:\n");
disp(simplify(T_0_3_d1));
fprintf("T_0_3_d1d1:\n");
disp(simplify(T_0_3_d1d1));
fprintf("T_0_3_d1d2:\n");
disp(simplify(T_0_3_d1d2));
fprintf("T_0_3_d1d3:\n");
disp(simplify(T_0_3_d1d3));
fprintf("T_0_3_d2:\n");
disp(simplify(T_0_3_d2));
fprintf("T_0_3_d2d2:\n");
disp(simplify(T_0_3_d2d2));
fprintf("T_0_3_d2d3:\n");
disp(simplify(T_0_3_d2d3));
fprintf("T_0_3_d3:\n");
disp(simplify(T_0_3_d3));
fprintf("T_0_3_d3d3:\n");
disp(simplify(T_0_3_d3d3));

I_3 = [m3 * l3 * l3, 0, 0, m3 * l3;
       0, 0, 0, 0;
       0, 0, 0, 0;
       m3 * l3, 0, 0, m3];

D_31 = trace(T_0_3_d1 * I_3 * T_0_3_d3.');
D_32 = trace(T_0_3_d2 * I_3 * T_0_3_d3.');
D_33 = trace(T_0_3_d3 * I_3 * T_0_3_d3.');

fprintf("D_31:\n");
disp(simplify(D_31));
fprintf("D_32:\n");
disp(simplify(D_32));
fprintf("D_33:\n");
disp(simplify(D_33));

H_311 = trace(T_0_3_d3 * I_3 * T_0_3_d1d1.');
H_312 = trace(T_0_3_d3 * I_3 * T_0_3_d1d2.');
H_313 = trace(T_0_3_d3 * I_3 * T_0_3_d1d3.');
H_322 = trace(T_0_3_d3 * I_3 * T_0_3_d2d2.');
H_323 = trace(T_0_3_d3 * I_3 * T_0_3_d2d3.');
H_333 = trace(T_0_3_d3 * I_3 * T_0_3_d3d3.');

fprintf("H_311:\n");
disp(simplify(H_311));
fprintf("H_312:\n");
disp(simplify(H_312));
fprintf("H_313:\n");
disp(simplify(H_313));
fprintf("H_322:\n");
disp(simplify(H_322));
fprintf("H_323:\n");
disp(simplify(H_323));
fprintf("H_333:\n");
disp(simplify(H_333));
