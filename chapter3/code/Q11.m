syms theta1 theta2 theta3 theta4 theta5 theta6 theta7 l0 l1 l2 l3 l4 l5 l6 l7 a b A B

dh_table = [0, 0, l0, theta1;
            0, -pi/2, l1, theta2;  
            0, -pi/2, l2, theta3;
            l3, 0, 0, theta4;
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
fprintf("T_6_7:\n");
disp(T_6_7);

T_4_7 = T_4_5 * T_5_6 * T_6_7;

fprintf("T_4_7:\n");
disp(T_4_7);
               
denominator = sqrt(A^2 + B^2);  

T_4_8 = [
    A/denominator,    B/denominator,    0,    l4 - a;
    B/denominator,    -A/denominator,   0,    b;
    0,                    0,            1,    0;
    0,                    0,            0,    1
];

T_8_7 = T_INV_sym(T_4_8) * T_4_7;

T_3_8 = T_3_4 * T_4_8;

T_2_4 = T_2_3 * T_3_4;
T_2_4 = simplify(T_2_4);

T_2_8 = T_2_4 * T_4_8;
T_1_8 = T_1_2 * T_2_8;
T_0_8 = T_0_1 * T_1_8;

fprintf("T_8_7:\n");
disp(T_8_7);
disp(mylatex(T_8_7));

fprintf("T_3_8:\n");
disp(T_3_8);
disp(mylatex(T_3_8));
fprintf("T_2_4:\n");
disp(T_2_4);
disp(mylatex(T_2_4));

fprintf("T_2_8:\n");
disp(T_2_8);
disp(mylatex(T_2_8));
fprintf("T_1_8:\n");
disp(T_1_8);
disp(mylatex(T_1_8));
fprintf("T_0_8:\n");
disp(T_0_8);
disp(mylatex(T_0_8));
