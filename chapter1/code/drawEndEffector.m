%% 绘制一个小圆锥作为末端执行器
function drawEndEffector(ax, position, color)   
    [X, Y, Z] = cylinder([0.07, 0.02], 10);  
    Z = Z * 0.1 - 0.05;  
    
    rot_mat = [0   0  -1;
               0   1   0;
               1   0   0]; 
    
    % 遍历所有点进行旋转
    for i = 1:size(X,1)
        for j = 1:size(X,2)
            point = [X(i,j); Y(i,j); Z(i,j)];
            rotated_point = rot_mat * point;
            X(i,j) = rotated_point(1);
            Y(i,j) = rotated_point(2);
            Z(i,j) = rotated_point(3);
        end
    end
    
    % 将圆锥平移到目标位置
    X = X + position(1);
    Y = Y + position(2);  
    Z = Z + position(3);  
    
    % 绘制圆锥
    surf(ax, X, Y, Z, 'FaceColor', color, 'EdgeColor', 'none', 'FaceAlpha', 0.9);
    hold(ax, 'on');
end
