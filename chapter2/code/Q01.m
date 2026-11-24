syms theta phi

Rz = R('z', theta);
Ry = R('y', phi);

R = Rz * Ry;
disp(R)