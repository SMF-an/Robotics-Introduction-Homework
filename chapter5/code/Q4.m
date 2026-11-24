syms theta1 theta2 theta3 theta4 theta5 theta6 d3 d4 a1 a2 a3

dh_table = [0, 0, a1, theta1;
            0, -pi/2, 0, theta2;  
            a2, 0, d3, theta3;
            a3, -pi/2, d4, theta4;
            0, pi/2, 0, theta5;
            0, -pi/2, 0, theta6];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));
T_4_5 = dh2T(dh_table(5,1), dh_table(5,2), dh_table(5,3), dh_table(5,4));
T_5_6 = dh2T(dh_table(6,1), dh_table(6,2), dh_table(6,3), dh_table(6,4));

T_4_6 = T_4_5 * T_5_6;
T_3_6 = T_3_4 * T_4_6;
T_2_6 = T_2_3 * T_3_6;
T_1_6 = T_1_2 * T_2_6;

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
fprintf("T_5_6:\n");
disp(T_5_6);
fprintf("T_4_6:\n");
disp(T_4_6);
fprintf("T_3_6:\n");
disp(mylatex(T_3_6));
fprintf("T_2_6:\n");
disp(mylatex(T_2_6));
fprintf("T_1_6:\n");
disp(mylatex(T_1_6));

J_1 = simplify(Jacobi(T_1_6, 'revolute'));
J_2 = simplify(Jacobi(T_2_6, 'revolute'));
J_3 = simplify(Jacobi(T_3_6, 'revolute'));
J_4 = simplify(Jacobi(T_4_6, 'revolute'));
J_5 = simplify(Jacobi(T_5_6, 'revolute'));
fprintf("J_1:\n");
disp(mylatex(J_1));
fprintf("J_2:\n");
disp(mylatex(J_2));
fprintf("J_3:\n");
disp(mylatex(J_3));
fprintf("J_4:\n");
disp(J_4);
fprintf("J_5:\n");
disp(J_5);
