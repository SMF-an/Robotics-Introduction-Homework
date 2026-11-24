syms theta1 theta2 theta3 l1 l2 l3 d1 d2

dh_table = [0, 0, d1, theta1;
            0, -pi/2, 0, theta2;  
            l2, 0, d2, theta3;
            l3, 0, 0, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));

T_2_4 = T_2_3 * T_3_4;
T_1_4 = T_1_2 * T_2_4;
T_0_4 = T_0_1 * T_1_4;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);
fprintf("T_2_3:\n");
disp(T_2_3);
fprintf("T_3_4:\n");
disp(T_3_4);
fprintf("T_2_4:\n");
disp(T_2_4);
fprintf("T_1_4:\n");
disp(T_1_4);
fprintf("T_0_4:\n");
disp(mylatex(T_0_4));

J_1 = simplify(Jacobi(T_1_4, 'revolute'));
J_2 = simplify(Jacobi(T_2_4, 'revolute'));
J_3 = simplify(Jacobi(T_3_4, 'revolute'));
fprintf("J_1:\n");
disp(J_1);
fprintf("J_2:\n");
disp(J_2);
fprintf("J_3:\n");
disp(J_3);

Jn = [J_1, J_2, J_3];
fprintf("Jn:\n");
disp(Jn);

q = [theta1; theta2; theta3];
J_0 = simplify(J(T_0_4, q));
fprintf("J_0:\n");
disp(J_0);
disp(mylatex(J_0));

R_0_4 = T_0_4(1:3, 1:3);
RR_4_0 = [R_0_4.', zeros(3); zeros(3), R_0_4.'];
J_n = simplify(RR_4_0 * J_0);
disp(J_n - Jn);

RR_0_4 = [R_0_4, zeros(3); zeros(3), R_0_4];
J0 = simplify(RR_0_4 * Jn);
disp(simplify(J0 - J_0));
