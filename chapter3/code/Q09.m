syms l_thigh l_shin theta1 theta2 theta3

dh_table = [0, 0, 0, theta1;
            l_thigh, 0, 0, theta2;  
            l_shin, 0, 0, theta3 + pi/2];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_total = T_0_1 * T_1_2 * T_2_3;

fprintf("T_total:\n");
disp(T_total);
disp(mylatex(T_total));

l_thigh_val = 500;
l_shin_val = 400;
l_heel_val = 50;
l_toe_val = 150;
theta_val_1 = [deg2rad(-4.15), deg2rad(-38.2), deg2rad(-2.57)];
theta_val_2 = [deg2rad(9.64), deg2rad(-19.9), deg2rad(21.8)];

T_total_1 = double(subs(T_total, {l_thigh, l_shin, theta1, theta2, theta3}, {l_thigh_val, l_shin_val, theta_val_1(1), theta_val_1(2), theta_val_1(3)}));
T_total_2 = double(subs(T_total, {l_thigh, l_shin, theta1, theta2, theta3}, {l_thigh_val, l_shin_val, theta_val_2(1), theta_val_2(2), theta_val_2(3)}));
fprintf("T_total_1:\n");
disp(T_total_1);
fprintf("T_total_2:\n");
disp(T_total_2);

p_toe_3 = [l_toe_val; 0; 0; 1];
p_toe_0 = T_total_1 * p_toe_3;
p_heel_3 = [-l_heel_val; 0; 0; 1];
p_heel_0 = T_total_2 * p_heel_3;
fprintf("p_toe:\n");
disp(p_toe_0);
fprintf("p_heel:\n");
disp(p_heel_0);
fprintf("stride:\n");
disp(p_heel_0(2) - p_toe_0(2));
