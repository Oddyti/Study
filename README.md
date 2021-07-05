### 前言
陆陆续续已经写了不少的实验报告和课程论文。

由于信电的实验大部分都需要写一些公式或者贴很多图和代码，所以很早我就接触到了$\LaTeX$这样一个排版工具。但是之前一直迷迷糊糊在使用，在不熟练的情况下其实$\LaTeX$的使用成本还是挺大的。但是之后找到了学长的$\LaTeX$实验报告模板，然后自己慢慢熟练了之后也在这个模板的基础上进行了许多的修改。这样的情况下用$\LaTeX$排版就快了不少。所以希望能对有需要的人提供一些帮助。

有些报告时比较水的，有些也不能保证正确。参考以下就好。
### 模板内容以及一些技巧更新（实验报告模板：Experiment）

+ 新增了角度命令可以打出°
    ```latex
    % 定义°为\degree 不需要$, \deg 需要$
    \def\deg{^{\circ}}
    \def\degree{${}^{\circ}$}
    ```
    使用实例：
    ```latex
    $90 \deg$   29.5\degree
    ```
    >90°    29.5°
    
+ 新增了代码插入，自定义了代码主题
    ```latex
    \lstset{
    basicstyle          =   \small\fontspec{Hack},          % 基本代码风格
    keywordstyle        =   \color[RGB]{1, 1, 194},          % 关键字风格
    commentstyle        =   \color{gray!40!black!60},  % 注释的风格，斜体
    stringstyle         =   \rmfamily\slshape\color[RGB]{0,139,139},  % 字符串风格
    framerule           =   2.5em,
		rulecolor           =   \color{gray!10},  
    flexiblecolumns     =   flase,                % 别问为什么，加上这个
    numbers             =   left,   % 行号的位置在左边
    showspaces          =   false,  % 是否显示空格，显示了有点乱，所以不现实了
    numberstyle         =   \footnotesize\fontspec{Hack},    % 行号的样式，小五号，tt等宽字体
    showstringspaces    =   false,
    captionpos          =   t,      % 这段代码的名字所呈现的位置，t指的是top上面
    frame               =   leftline,   % 显示边框
    tabsize             =   2,
    breaklines          =   true,   % 自动换行，建议不要写太长的行
    breakatwhitespace   =   false,       	% 设置自动中断是否只发生在空格处
    escapeinside        =   ``,     	% 在``里显示中文
    columns             =   flexible,  % 如果不加这一句，字间距就不固定，很丑，必须
    basewidth           =   0.5em,
    xleftmargin         =    1em,  
    xrightmargin        =    1em,     % 设定listing左右的空白
    }
    ```
    使用方法：

    + 直接插入代码
    ```latex
    \begin{lstlisting}[language = Verilog，title = {mcu顶层代码}]
        module synchro (
            clk,
            in,
            out
        );
            input clk, in;
            output out;
            reg q1,q2;
            //非阻塞赋值
            always @(posedge clk ) begin
                q1 <= in;
                q2 <= q1;
            end
            assign out = q1 && (~q2);
        endmodule
    \end{lstlisting}
    ```
    + 通过路径引用（推荐这个，这样每次更新代码后就不需要复制粘贴了）
    ```latex
    \lstinputlisting[
                language = Verilog,
                title = {mcu顶层代码}
    ]{src/synchro.v}
    ```

    ![image-20210705225841881](https://i.loli.net/2021/07/05/SqKw3WzHsAuknDd.png)

+ 如何自定义caption中编号和文本之间的分隔（用于只想让caption有一个编号时）
    ```latex
    %需要用到宏包caption
    \usepackage{caption}
    %最后一个{}里为自己想要更改的格式，这里我改为一个空格
    \DeclareCaptionLabelSeparator{captionspace}{\, }
    \captionsetup{labelsep = captionspace}
    ```
    修改前：

    <img src="https://i.loli.net/2021/07/05/oeAwtrOWkKRE3JL.png" alt="image-20210705231112574" style="zoom: 80%;" />

    修改后：
    
    <img src="https://i.loli.net/2021/07/05/Oo7GLCt3YkD8MEU.png" alt="image-20210705231045435" style="zoom:80%;" />
+ 重新开始标题/图片编号（用于几个实验报告合一起时，想要重新开始编号）
    ```latex
    %标题
    \setcounter{section}{0}
    %图片
    \setcounter{figure}{0}
    ```
    示例：
    ```latex
    \section{第一}
        \subsection{第一}
    
    \setcounter{section}{0}
    
    \section{第一}
        \subsection{第一}
    ```
    <img src="https://i.loli.net/2021/07/05/qmDJ9SUBu2rEOaA.png" alt="image-20210705231405831" style="zoom: 50%;" />
+ 按页面宽度缩放表格（解决表格行/列太多写不下问题）
    ```latex
    \resizebox{\textwidth}{!}{这里面放你的tabular}
    ```
    示例：
    ```latex
    \begin{table}[H]
            \caption{天线水平方向图测量数据}
            \centering
            \resizebox{\textwidth}{!}{
                \begin{tabular}{|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|c|}
                    \hline
                    天线水平方向转角(\degree) & -90      & -80      & -70   & -60   & -50   & -40   & -30   & -20   & -10   & 0     & 10    & 20    & 30    & 40    & 50    & 60    & 70    & 80    & 90       \\ \hline
                    实验测量值(dB)         & $\infty$ & $\infty$ & -80.0 & -73.8 & -74.0 & -66.8 & -57.8 & -49.8 & -43.0 & -40.0 & -44.2 & -52.6 & -61.0 & -63.4 & -66.8 & -70.5 & -77.5 & -74.4 & $\infty$ \\ \hline
                    相对归一化数值(dB)       & $\infty$ & $\infty$ & -40.0 & -33.8 & -34.0 & -26.8 & -17.8 & -9.8  & -3.0  & 0.0   & -4.2  & -12.6 & -21.0 & -23.4 & -26.8 & -30.5 & -37.5 & -34.4 & $\infty$ \\ \hline
                    相对归一化功率           & $\infty$ & $\infty$ & 0.01  & 0.02  & 0.02  & 0.05  & 0.13  & 0.32  & 0.71  & 1.00  & 0.62  & 0.23  & 0.09  & 0.07  & 0.05  & 0.03  & 0.01  & 0.02  & $\infty$ \\ \hline
                \end{tabular}}
    \end{table}
    ```

    ![image-20210705232100876](https://i.loli.net/2021/07/05/BFD28qArRvf9eWY.png)
