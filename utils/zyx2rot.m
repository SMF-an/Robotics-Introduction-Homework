function R_ = zyx2rot(yaw, pitch, roll)
% 输入欧拉角，输出旋转矩阵

   R_ = R('z', yaw) * R('y', pitch) * R('x', roll);
end
