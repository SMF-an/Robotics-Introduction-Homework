%% 绘制球体
function drawSphere(ax, center, radius, color)
    [X, Y, Z] = sphere(20);
    X = X * radius + center(1);
    Y = Y * radius + center(2);
    Z = Z * radius + center(3);
    surf(ax, X, Y, Z, 'FaceColor', color, 'EdgeColor', 'none', 'FaceAlpha', 0.9);
end
