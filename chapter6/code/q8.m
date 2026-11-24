syms theta1 theta2 theta3 l1 l2 l3 m1 m2 m3 Ixx1 Iyy1 Izz1 Ixx2 Iyy2 Izz2 Ixx3 Iyy3 Izz3 c1 c2 c3 g theta1_dot theta2_dot theta3_dot

dh_table = [0, 0, 0, theta1;
            0, pi/2, -l1, theta2;
            l2, 0, 0, theta3;
            0, pi/2, l3, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));
T_2_3 = dh2T(dh_table(3,1), dh_table(3,2), dh_table(3,3), dh_table(3,4));
T_3_4 = dh2T(dh_table(4,1), dh_table(4,2), dh_table(4,3), dh_table(4,4));

T_0_2 = T_0_1 * T_1_2;
T_0_3 = T_0_2 * T_2_3;
T_0_4 = T_0_3 * T_3_4;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);
fprintf("T_2_3:\n");
disp(T_2_3);

fprintf("T_0_2:\n");
disp(mylatex(T_0_2));
fprintf("T_0_3:\n");
disp(mylatex(T_0_3));

T_0_1_d1 = diff(T_0_1, theta1);
T_0_1_d1d1 = diff(T_0_1_d1, theta1);

T_0_2_d1 = diff(T_0_2, theta1);
T_0_2_d1d1 = diff(T_0_2_d1, theta1);
T_0_2_d1d2 = diff(T_0_2_d1, theta2);
T_0_2_d2 = diff(T_0_2, theta2);
T_0_2_d2d2 = diff(T_0_2_d2, theta2);

T_0_3_d1 = diff(T_0_3, theta1);
T_0_3_d1d1 = diff(T_0_3_d1, theta1);
T_0_3_d1d2 = diff(T_0_3_d1, theta2);
T_0_3_d1d3 = diff(T_0_3_d1, theta3);
T_0_3_d2 = diff(T_0_3, theta2);
T_0_3_d2d2 = diff(T_0_3_d2, theta2);
T_0_3_d2d3 = diff(T_0_3_d2, theta3);
T_0_3_d3 = diff(T_0_3, theta3);
T_0_3_d3d3 = diff(T_0_3_d3, theta3);

fprintf("T_0_1_d1:\n");
disp(T_0_1_d1);
fprintf("T_0_1_d1d1:\n");
disp(T_0_1_d1d1);

fprintf("T_0_2_d1:\n");
disp(T_0_2_d1);
fprintf("T_0_2_d1d1:\n");
disp(T_0_2_d1d1);
fprintf("T_0_2_d1d2:\n");
disp(T_0_2_d1d2);
fprintf("T_0_2_d2:\n");
disp(T_0_2_d2);
fprintf("T_0_2_d2d2:\n");
disp(T_0_2_d2d2);

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

I_1 = [(-Ixx1+Iyy1+Izz1)/2, 0, 0, 0;
       0, (Ixx1-Iyy1+Izz1)/2, 0, 0;
       0, 0, (Ixx1+Iyy1-Izz1)/2, 0;
       0, 0, 0, m1];

I_2 = [(-Ixx2+Iyy2+Izz2)/2, 0, 0, 0;
       0, (Ixx2-Iyy2+Izz2)/2, 0, 0;
       0, 0, (Ixx2+Iyy2-Izz2)/2, 0;
       0, 0, 0, m2];

I_3 = [(-Ixx3+Iyy3+Izz3)/2, 0, 0, 0;
       0, (Ixx3-Iyy3+Izz3)/2, 0, 0;
       0, 0, (Ixx3+Iyy3-Izz3)/2, 0;
       0, 0, 0, m3];

D_11 = trace(T_0_1_d1 * I_1 * T_0_1_d1.') + trace(T_0_2_d1 * I_2 * T_0_2_d1.') + trace(T_0_3_d1 * I_3 * T_0_3_d1.');
D_12 = trace(T_0_2_d1 * I_2 * T_0_2_d2.') + trace(T_0_3_d1 * I_3 * T_0_3_d2.');
D_13 = trace(T_0_3_d1 * I_3 * T_0_3_d3.');
D_22 = trace(T_0_2_d2 * I_2 * T_0_2_d2.') + trace(T_0_3_d2 * I_3 * T_0_3_d2.');
D_23 = trace(T_0_3_d2 * I_3 * T_0_3_d3.');
D_33 = trace(T_0_3_d3 * I_3 * T_0_3_d3.');

fprintf("D_11:\n");
disp(simplify(D_11));
fprintf("D_12:\n");
disp(simplify(D_12));
fprintf("D_13:\n");
disp(simplify(D_13));
fprintf("D_22:\n");
disp(simplify(D_22));
fprintf("D_23:\n");
disp(simplify(D_23));
fprintf("D_33:\n");
disp(simplify(D_33));

H_111 = trace(T_0_1_d1 * I_1 * T_0_1_d1d1.') + trace(T_0_2_d1 * I_2 * T_0_2_d1d1.') + trace(T_0_3_d1 * I_3 * T_0_3_d1d1.');
H_112 = trace(T_0_2_d1 * I_2 * T_0_2_d1d2.') + trace(T_0_3_d1 * I_3 * T_0_3_d1d2.');
H_113 = trace(T_0_3_d1 * I_3 * T_0_3_d1d3.');
H_122 = trace(T_0_2_d1 * I_2 * T_0_2_d2d2.') + trace(T_0_3_d1 * I_3 * T_0_3_d2d2.');
H_123 = trace(T_0_3_d1 * I_3 * T_0_3_d2d3.');
H_133 = trace(T_0_3_d1 * I_3 * T_0_3_d3d3.');

fprintf("H_111:\n");
disp(simplify(H_111));
fprintf("H_112:\n");
disp(simplify(H_112));
fprintf("H_113:\n");
disp(simplify(H_113));
fprintf("H_122:\n");
disp(simplify(H_122));
fprintf("H_123:\n");
disp(simplify(H_123));
fprintf("H_133:\n");
disp(simplify(H_133));

H_211 = trace(T_0_2_d2 * I_2 * T_0_2_d1d1.') + trace(T_0_3_d2 * I_3 * T_0_3_d1d1.');
H_212 = trace(T_0_2_d2 * I_2 * T_0_2_d1d2.') + trace(T_0_3_d2 * I_3 * T_0_3_d1d2.');
H_213 = trace(T_0_3_d2 * I_3 * T_0_3_d1d3.');
H_222 = trace(T_0_2_d2 * I_2 * T_0_2_d2d2.') + trace(T_0_3_d2 * I_3 * T_0_3_d2d2.');
H_223 = trace(T_0_3_d2 * I_3 * T_0_3_d2d3.');
H_233 = trace(T_0_3_d2 * I_3 * T_0_3_d3d3.');

fprintf("H_211:\n");
disp(simplify(H_211));
fprintf("H_212:\n");
disp(simplify(H_212));
fprintf("H_213:\n");
disp(simplify(H_213));
fprintf("H_222:\n");
disp(simplify(H_222));
fprintf("H_223:\n");
disp(simplify(H_223));
fprintf("H_233:\n");
disp(simplify(H_233));

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

r1 = [0; l1-c1; 0; 1];
r2 = [c2; 0; 0; 1];
r3 = [0; -c3; 0; 1];
gg = [0; 0; -g; 0];

G_1 = -m1 * gg.' * T_0_1_d1 * r1 - m2 * gg.' * T_0_2_d1 * r2 - m3 * gg.' * T_0_3_d1 * r3;
G_2 = -m2 * gg.' * T_0_2_d2 * r2 - m3 * gg.' * T_0_3_d2 * r3;
G_3 = - m3 * gg.' * T_0_3_d3 * r3;

fprintf("G_1:\n");
disp(G_1);
fprintf("G_2:\n");
disp(simplify(G_2));
fprintf("G_3:\n");
disp(simplify(G_3));

D = [D_11, D_12, D_13;
     D_12, D_22, D_23;
     D_13, D_23, D_33;];

G = [G_1;
     G_2;
     G_3];

q = [theta1; theta2; theta3];
J_ = simplify(J(T_0_4, q));
J_ = J_(1:3, :);
J_inv = simplify(inv(J_));
J_dot = diff(J_, theta1) * theta1_dot + diff(J_, theta2) * theta2_dot + diff(J_, theta3) * theta3_dot;

V = J_inv.' * D * J_inv;
p = J_inv.' * G;

fprintf("J:\n");
disp(mylatex(J_));
fprintf("J_inv:\n");
disp(mylatex(J_inv));
fprintf("J_dot:\n");
disp(simplify(J_dot));
fprintf("V:\n");
disp(mylatex(V));
fprintf("p:\n");
disp(mylatex(p));
