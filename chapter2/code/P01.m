fprintf('问题1\n');
disp(zyx2rot(deg2rad(15), deg2rad(30), deg2rad(10)));
fprintf('问题2\n');
disp(zyx2rot(deg2rad(25), deg2rad(90), deg2rad(-45)));

fprintf('验证第二问的答案\n');
fprintf('问题1\n');
disp(zyx2rot(deg2rad(195), deg2rad(150), deg2rad(190)));
fprintf('问题2\n');
disp(zyx2rot(deg2rad(0), deg2rad(90), deg2rad(290)));

fprintf("Corke MATLAB Robotics\n");
fprintf('问题1\n');
disp(rotz(deg2rad(15)) * roty(deg2rad(30)) * rotx(deg2rad(10)));
fprintf('问题2\n');
disp(rotz(deg2rad(25)) * roty(deg2rad(90)) * rotx(deg2rad(-45)));
