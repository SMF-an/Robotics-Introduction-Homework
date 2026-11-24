R_ = [0.53, -0.84, 0.13;
      0, 0.15, 0.99;
      -0.85, -0.52, 0.081];

if iforth(R_) 
    fprintf('R 是旋转矩阵。\n');
else
    fprintf('R 不是旋转矩阵。\n');
end

% (b) 求欧拉角
[alpha, beta, gamma] = rot2zyx(R_);
fprintf('alpha = %.4f, beta = %.4f, gamma = %.4f\n', rad2deg(alpha), rad2deg(beta), rad2deg(gamma));

% (c) 求RPY角
[yaw, pitch, roll] = rot2zyx(R_);
fprintf('yaw = %.4f, pitch = %.4f, roll = %.4f\n', rad2deg(yaw), rad2deg(pitch), rad2deg(roll));
