function latex_str = mylatex(expr, varargin)
    % MYLATEX 将符号表达式转换为LaTeX代码
    %   latex_str = MYLATEX(expr) 对符号表达式expr执行以下操作：
    %       1. 展开表达式 (expand)
    %       2. 替换 pi/180 为 1 (角度转弧度系数处理)
    %       3. 化简表达式 (simplify)
    %       4. 转换为LaTeX代码
    %
    %   输入参数：
    %       expr - 符号表达式、向量或矩阵 (sym类型)
    %       varargin - 可选参数，支持键值对：
    %           'ReplacePairs' - 替换规则，默认为 {pi/180, 1}
    %           'SimplifySteps' - 化简步数，默认为 50
    %
    %   输出参数：
    %       latex_str - 生成的LaTeX代码字符串
    %
    %   示例：
    %       syms x theta
    %       f = sin(x*pi/180) + (theta + 1)^2;
    %       latex_str = mylatex(f);
    %       disp(latex_str);

    % 输入验证
    if ~isa(expr, 'sym')
        error('输入必须是符号表达式（sym类型）');
    end

    % 默认参数设置
    replace_pairs = {pi/180, 1};  % 默认替换规则
    simplify_steps = 50;          % 默认化简步数

    % 解析可选参数
    for i = 1:2:length(varargin)
        switch varargin{i}
            case 'ReplacePairs'
                replace_pairs = varargin{i+1};
            case 'SimplifySteps'
                simplify_steps = varargin{i+1};
            otherwise
                warning('未知参数: %s', varargin{i});
        end
    end

    % 处理流程
    expr_substituted = subs(expr, replace_pairs{:});  % 执行替换
    expr_simplified = simplify(expr_substituted, 'Steps', simplify_steps);  % 化简
    expr_collected = collect(expr_simplified);
    latex_str = latex(expr_collected);         % 转换为LaTeX

end
