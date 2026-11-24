function R = R(axis, angle, varargin)
% 生成绕指定轴旋转的旋转矩阵
% 输入:
%   axis - 旋转轴: 'x', 'y', 'z', 'k' (任意轴)
%   angle - 旋转角度(弧度) 
%   varargin - 当axis='k'时：旋转轴向量
% 输出:
%   R - 3x3旋转矩阵

    switch lower(axis)
        case 'x'
            R = [1, 0, 0;
                 0, cos(angle), -sin(angle);
                 0, sin(angle), cos(angle)];
            
        case 'y'
            R = [cos(angle), 0, sin(angle);
                 0, 1, 0;
                 -sin(angle), 0, cos(angle)];
            
        case 'z'
            R = [cos(angle), -sin(angle), 0;
                 sin(angle), cos(angle), 0;
                 0, 0, 1];
            
        case 'k'
            % 绕任意轴旋转
            if nargin < 3 || isempty(varargin) || numel(varargin{1}) ~= 3
                error('当axis=''k''时，需要提供3维旋转轴向量作为第三个参数');
            end
            
            k = varargin{1}(:); % 确保是列向量
            k = k / norm(k);    % 单位化
            
            % 罗德里格斯旋转公式
            kx = k(1); ky = k(2); kz = k(3);
            c = cos(angle);
            s = sin(angle);
            v = 1 - c;
            
            R = [kx*kx*v + c,      kx*ky*v - kz*s,  kx*kz*v + ky*s;
                 kx*ky*v + kz*s,   ky*ky*v + c,     ky*kz*v - kx*s;
                 kx*kz*v - ky*s,   ky*kz*v + kx*s,  kz*kz*v + c];
            
        otherwise
            error('轴必须是 ''x'', ''y'', ''z'', ''k'' ');
    end
end