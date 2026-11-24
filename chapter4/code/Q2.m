syms theta1 theta2 theta4 theta5 theta6 d3 d7 l2 

dh_table = [0, 0, 0, theta1;
            0, -pi/2, l2, theta2;  
            0, pi/2, d3, 0;
            0, 0, 0, theta4;
            0, -pi/2, 0, theta5;
            0, pi/2, 0, theta6];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));
T_4_5 = dh2T(dh_table(5,1), dh_table(5,2), dh_table(5,3), dh_table(5,4));
T_5_6 = dh2T(dh_table(6,1), dh_table(6,2), dh_table(6,3), dh_table(6,4));

T_0_3 = T_0_1 * T_1_2 * T_2_3;
T_3_0 = T_INV_sym(T_0_3);
T_0_4 = T_0_3 * T_3_4;
T_4_0 = T_INV_sym(T_0_4);

T_4_6 = T_4_5 * T_5_6;
T_3_6 = T_3_4 * T_4_6;
T_1_6 = T_1_2 * T_2_3 * T_3_6;
T_total = T_0_1 * T_1_6;

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

fprintf("T_3_0:\n");
disp(mylatex(T_3_0));
fprintf("T_4_0:\n");
disp(mylatex(T_4_0));

fprintf("T_4_6:\n");
disp(mylatex(T_4_6));
fprintf("T_3_6:\n");
disp(mylatex(T_3_6));
fprintf("T_1_6:\n");
disp(mylatex(T_1_6));
fprintf("T_total:\n");
disp(mylatex(T_total));
