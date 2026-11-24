syms theta1 theta2 theta3

dh_table = [0, 0, 40, theta1;
            0, -pi/2, 0, theta2;  
            0, pi/2, 0, theta3;
            0, 0, 10, 0;
            10, 0, 5, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));
T_4_5 = dh2T(dh_table(5,1), dh_table(5,2), dh_table(5,3), dh_table(5,4));

T_3_5 = T_3_4 * T_4_5;
T_2_5 = T_2_3 * T_3_5;
T_1_5 = T_1_2 * T_2_5;
T_0_5 = T_0_1 * T_1_5;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);
fprintf("T_2_3:\n");
disp(T_2_3);
fprintf("T_3_4:\n");
disp(T_3_4);
fprintf("T_4_5:\n");
disp(T_4_5);

fprintf("T_3_5:\n");
disp(T_3_5);
fprintf("T_2_5:\n");
disp(T_2_5);
fprintf("T_1_5:\n");
disp(T_1_5);
fprintf("T_0_5:\n");
disp(mylatex(T_0_5));

J_1 = simplify(Jacobi(T_1_5, 'revolute'));
J_2 = simplify(Jacobi(T_2_5, 'revolute'));
J_3 = simplify(Jacobi(T_3_5, 'revolute'));
fprintf("J_1:\n");
disp(J_1);
fprintf("J_2:\n");
disp(J_2);
fprintf("J_3:\n");
disp(J_3);

Jn = [J_1, J_2, J_3];
fprintf("Jn:\n");
disp(Jn);

F = [-1.414; -12.728; 0; 4; 0; 0];
J_num = subs(Jn, {theta1, theta2, theta3}, {pi/2, pi/4, 0});
tau = J_num.' * F;
fprintf("tau:\n");
disp(double(tau));

syms fx fy fz mx my mz
R_4_5 = T_4_5(1:3, 1:3);
R_5_4 = R_4_5.';
P_4_5 = T_4_5(1:3, 4);
P_5_4 = - R_5_4 * P_4_5;
S = [0, -P_5_4(3), P_5_4(2);
     P_5_4(3), 0, -P_5_4(1);
     -P_5_4(2), P_5_4(1), 0];
RR_5_4 = [R_5_4, zeros(3); S * R_5_4, R_5_4];
F_4 = [fx; fy; fz; mx; my; mz];
F_5 = RR_5_4 * F_4;
fprintf("F_5:\n");
disp(F_5);

R_0_5 = T_0_5(1:3, 1:3);
RR_0_5 = [R_0_5, zeros(3); zeros(3), R_0_5];
F_0 = RR_0_5 * F_5;
fprintf("F_0:\n");
disp(mylatex(F_0));
