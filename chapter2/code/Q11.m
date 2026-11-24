R_ = [1, 0, 0;
     0, 0, 1;
     0, -1, 0];

[alpha, beta, gamma] = rot2zyz(R_);
fprintf('alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha), rad2deg(beta), rad2deg(gamma));