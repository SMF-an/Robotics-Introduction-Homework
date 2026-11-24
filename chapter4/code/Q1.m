syms theta1 theta3 d2 l1 l2

dh_table = [0, 0, 0, theta1;
            l1, -pi/2, d2, 0;  
            0, pi/2, 0, theta3 + pi/2;
            l2, 0, 0, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));

T_total = T_0_1 * T_1_2 * T_2_3 * T_3_4;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);
fprintf("T_2_3:\n");
disp(T_2_3);
fprintf("T_3_4:\n");
disp(T_3_4);
fprintf("T_total:\n");
disp(T_total);
disp(mylatex(T_total));
