## 机器人学导论课程作业

本仓库用于整理《机器人学导论》课程作业，包括LaTeX 报告、 MATLAB 代码、仿真结果及相关资料。

### 目录结构

- `chapter1/`：机器人类型与工作空间
- `chapter2/`：坐标变换与齐次变换
- `chapter3/`–`chapter7/`：各章节课程作业
- `midterm/`：期中作业
- `utils/`：机器人学计算与坐标变换公共函数

各章节目录通常包含：

- `code/`：MATLAB 程序
- `figs/` 或 `figure/`：绘图与实验结果
- `main.tex`：LaTeX 报告源码
- `homework.cls`、`hwcmd.sty`、`hwlst.sty`、`hwsymb.sty`：LaTeX 文档类与宏包文件

### 使用方法

1. 使用 MATLAB 打开对应章节的 `code/` 目录，并将 `utils/` 添加到 MATLAB 路径。
2. 运行相应的 `.m` 文件查看计算结果或机器人模型仿真。
3. 如需重新生成报告，在对应章节目录使用 `xelatex` 编译 `main.tex`。

运行 MATLAB 程序或编译 LaTeX 报告前，请确认本地已安装相应环境及依赖。

> **注意：** 本仓库仅供学习和交流使用，请勿直接抄袭或将其中内容作为自己的作业提交。