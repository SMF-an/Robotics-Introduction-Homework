syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 l0 l1 l2 l3 l4 l5 l6 l7 d

dh_table = [0, 0, l0, theta1;
            0, -pi/2, l1, theta2;  
            0, -pi/2, l2, theta3;
            l3, 0, d, theta4;
            l4, 0, l5, theta5;
            0, -pi/2, l6, theta6;
            0, -pi/2, l7, theta7];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));
T_4_5 = dh2T(dh_table(5,1), dh_table(5,2), dh_table(5,3), dh_table(5,4));
T_5_6 = dh2T(dh_table(6,1), dh_table(6,2), dh_table(6,3), dh_table(6,4));
T_6_7 = dh2T(dh_table(7,1), dh_table(7,2), dh_table(7,3), dh_table(7,4));

T_0_2 = T_0_1 * T_1_2;
T_2_0 = T_INV_sym(T_0_2);
T_2_5 = T_2_3 * T_3_4 * T_4_5;
T_2_6 = T_2_5 * T_5_6;
T_2_7 = T_2_6 * T_6_7;
T_total = T_0_2 * T_2_7;

l0_val = 37;
l1_val = 60;
l2_val = 55;
l3_val = 600;
l4_val = 600;
l5_val = 50;
l6_val = 73;
l7_val = 80;
d_val = 20;
T_0_1_num = subs(T_0_1, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_1_2_num = subs(T_1_2, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_2_3_num = subs(T_2_3, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_3_4_num = subs(T_3_4, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_4_5_num = subs(T_4_5, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_5_6_num = subs(T_5_6, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_6_7_num = subs(T_6_7, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});
T_total_num = subs(T_total, {l0, l1, l2, l3, l4, l5, l6, l7, d}, {l0_val, l1_val, l2_val, l3_val, l4_val, l5_val, l6_val, l7_val, d_val});

T_2_0_num = subs(T_2_0, {theta1}, {0});
T_total1 = subs(T_total, {theta1}, {0});
T_total2 = subs(T_total, {theta5}, {0});

fprintf("T_0_1:\n");
disp(T_0_1_num);
fprintf("T_1_2:\n");
disp(T_1_2_num);
fprintf("T_2_3:\n");
disp(T_2_3_num);
fprintf("T_3_4:\n");
disp(T_3_4_num);
fprintf("T_4_5:\n");
disp(T_4_5_num);
fprintf("T_5_6:\n");
disp(T_5_6_num);
fprintf("T_6_7:\n");
disp(T_6_7_num);
fprintf("T_total:\n");
disp(mylatex(T_total_num));

fprintf("T_2_5:\n");
disp(mylatex(T_2_5));
fprintf("T_2_0:\n");
disp(T_2_0_num);
fprintf("T_2_6:\n");
disp(mylatex(T_2_6));
fprintf("T_2_7:\n");
disp(mylatex(T_2_7));
fprintf("T_total1:\n");
disp(mylatex(T_total1));
fprintf("T_total2:\n");
disp(mylatex(T_total2));
