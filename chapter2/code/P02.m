R1 = [0.8365, -0.171, 0.5206;
      0.2241, 0.9737, -0.0403;
      -0.5, 0.1504, 0.8529];
R2 = [0, -0.9397, 0.342;
      0, 0.342, 0.9397;
      -1, 0, 0];
T1 = [0.8365, -0.171, 0.5206, 0;
      0.2241, 0.9737, -0.0403, 0;
      -0.5, 0.1504, 0.8529, 0;
      0, 0, 0, 1];
T2 = [0, -0.9397, 0.342, 0;
      0, 0.342, 0.9397, 0;
      -1, 0, 0, 0;
      0, 0, 0, 1];

fprintf('问题1\n');
[alpha1, beta1, gamma1] = rot2zyx(R1);
fprintf('第一组解：alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha1), rad2deg(beta1), rad2deg(gamma1));
[alpha1_, beta1_, gamma1_] = rot2zyx_(R1);
fprintf('第二组解：alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha1_), rad2deg(beta1_), rad2deg(gamma1_));

fprintf('问题2\n');
[alpha2, beta2, gamma2] = rot2zyx(R2);
fprintf('第一组解：alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha2), rad2deg(beta2), rad2deg(gamma2));
[alpha2_, beta2_, gamma2_] = rot2zyx_(R2);
fprintf('第二组解：alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha2_), rad2deg(beta2_), rad2deg(gamma2_));

fprintf("Corke MATLAB Robotics\n");
fprintf('问题1\n');
rpy1 = tr2rpy(T1);
fprintf('alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(rpy1(3)), rad2deg(rpy1(2)), rad2deg(rpy1(1)));

fprintf('问题2\n');
rpy2 = tr2rpy(T2);
fprintf('alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(rpy2(3)), rad2deg(rpy2(2)), rad2deg(rpy2(1)));

