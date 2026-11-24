%% 绘制两点之间的圆柱体
function drawCylinderBetweenPoints(ax, p1, p2, radius, color)
    % 计算两点之间的向量和长度
    v = p2 - p1;
    length = norm(v);
    
    if length < 1e-10
        return; % 避免除以零
    end
    
    % 计算中点
    center = (p1 + p2) / 2;
    
    % 创建圆柱体
    [X, Y, Z] = cylinder(20);
    X = X * radius;
    Y = Y * radius;
    Z = Z * length - length/2;
    
    % 计算旋转矩阵，使圆柱体指向正确方向
    z_axis = [0, 0, 1];
    v_norm = v / length;
    
    if abs(dot(z_axis, v_norm)) > 0.99
        % 如果向量几乎平行于Z轴，不需要旋转
        R = eye(3);
    else
        % 计算旋转轴和角度
        rot_axis = cross(z_axis, v_norm);
        rot_axis = rot_axis / norm(rot_axis);
        rot_angle = acos(dot(z_axis, v_norm));
        
        % 创建旋转矩阵
        R = axang2rotm([rot_axis, rot_angle]);
    end
    
    % 应用旋转
    for i = 1:size(X, 1)
        for j = 1:size(X, 2)
            point = [X(i,j); Y(i,j); Z(i,j)];
            rotated_point = R * point;
            X(i,j) = rotated_point(1);
            Y(i,j) = rotated_point(2);
            Z(i,j) = rotated_point(3);
        end
    end
    
    % 平移圆柱体到中点
    X = X + center(1);
    Y = Y + center(2);
    Z = Z + center(3);
    
    % 绘制圆柱体
    surf(ax, X, Y, Z, 'FaceColor', color, 'EdgeColor', 'none', 'FaceAlpha', 0.8);
end
