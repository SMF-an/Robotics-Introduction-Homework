syms theta1 d l1 Ixx Iyy Izz m1 m2 g theta1_dot d_dot

dh_table = [0, 0, l1, theta1;
            0, -pi/2, d, 0];

T_0_1 = dh2T(dh_table(1,1), dh_table(1,2), dh_table(1,3), dh_table(1,4));
T_1_2 = dh2T(dh_table(2,1), dh_table(2,2), dh_table(2,3), dh_table(2,4));

T_0_2 = T_0_1 * T_1_2;

fprintf("T_0_1:\n");
disp(T_0_1);
fprintf("T_1_2:\n");
disp(T_1_2);

fprintf("T_0_2:\n");
disp(T_0_2);

T_0_1_d1 = diff(T_0_1, theta1);
T_0_1_d1d1 = diff(T_0_1_d1, theta1);

T_0_2_d1 = diff(T_0_2, theta1);
T_0_2_d1d1 = diff(T_0_2_d1, theta1);
T_0_2_d1d2 = diff(T_0_2_d1, d);

T_0_2_d2 = diff(T_0_2, d);
T_0_2_d2d2 = diff(T_0_2_d2, d);

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

I_1 = [(-Ixx+Iyy+Izz)/2, 0, 0, 0;
       0, (Ixx-Iyy+Izz)/2, 0, 0;
       0, 0, (Ixx+Iyy-Izz)/2, 0;
       0, 0, 0, m1];

I_2 = [0, 0, 0, 0;
       0, 0, 0, 0;
       0, 0, 0, 0;
       0, 0, 0, m2];

r1 = [0; 0; 0; 1];
r2 = [0; 0; 0; 1];
gg = [0; 0; -g; 0];

D_11 = trace(T_0_1_d1 * I_1 * T_0_1_d1.') + trace(T_0_2_d1 * I_2 * T_0_2_d1.');
D_12 = trace(T_0_2_d1 * I_2 * T_0_2_d2.');
D_22 = trace(T_0_2_d2 * I_2 * T_0_2_d2.');

H_111 = trace(T_0_1_d1 * I_1 * T_0_1_d1d1.') + trace(T_0_2_d1 * I_2 * T_0_2_d1d1.');
H_112 = trace(T_0_2_d1 * I_2 * T_0_2_d1d2.');
H_122 = trace(T_0_2_d1 * I_2 * T_0_2_d2d2.');
H_211 = trace(T_0_2_d2 * I_2 * T_0_2_d1d1.');
H_212 = trace(T_0_2_d2 * I_2 * T_0_2_d1d2.');
H_222 = trace(T_0_2_d2 * I_2 * T_0_2_d2d2.');

G_1 = -m1 * gg.' * T_0_1_d1 * r1 - m2 * gg.' * T_0_2_d1 * r2;
G_2 = -m2 * gg.' * T_0_2_d2 * r2;

fprintf("D_11:\n");
disp(simplify(D_11));
fprintf("D_12:\n");
disp(D_12);
fprintf("D_22:\n");
disp(simplify(D_22));

fprintf("H_111:\n");
disp(H_111);
fprintf("H_112:\n");
disp(simplify(H_112));
fprintf("H_122:\n");
disp(H_122);
fprintf("H_211:\n");
disp(simplify(H_211));
fprintf("H_212:\n");
disp(H_212);
fprintf("H_222:\n");
disp(H_222);

fprintf("G_1:\n");
disp(G_1);
fprintf("G_2:\n");
disp(G_2);

D = [D_11, D_12;
     D_12, D_22];

H = [2 * m2 * d * theta1_dot * d_dot;
     -m2 * d * theta1_dot * theta1_dot];

G = [G_1;
     G_2];

q = [theta1; d];
J_ = simplify(J(T_0_2, q));
J_ = J_(1:2, :);
J_inv = simplify(inv(J_));
J_dot = [d * theta1_dot * sin(theta1) - d_dot * cos(theta1), -theta1_dot * cos(theta1);
         -d * theta1_dot * cos(theta1) - d_dot * sin(theta1), -theta1_dot * sin(theta1)];
q_dot = [theta1_dot; d_dot];

V = J_inv.' * D * J_inv;
u = J_inv.' * H - V * J_dot * q_dot;
p = J_inv.' * G;

fprintf("J:\n");
disp(J_);
fprintf("J_inv:\n");
disp(J_inv);
fprintf("V:\n");
disp(simplify(V));
fprintf("u:\n");
disp(simplify(u));
fprintf("p:\n");
disp(simplify(p));
