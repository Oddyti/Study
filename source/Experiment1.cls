\ProvidesClass{../source/Experiment1}
\LoadClass{ctexart}

%宏包
\RequirePackage{xeCJK}
\RequirePackage{CJKnumb}
\RequirePackage{graphicx}
\RequirePackage{geometry}
\RequirePackage{titlesec}
\RequirePackage{fancyhdr}
\RequirePackage{enumitem}
\RequirePackage{listings}
\RequirePackage{xcolor}
\RequirePackage{array}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage{indentfirst}
\RequirePackage{zhnumber}
\RequirePackage{multirow}
\RequirePackage{subfigure}
\RequirePackage{listings}
\RequirePackage{lmodern}
\RequirePackage{amssymb}

% 宏定义命令
  % 定义°为\degree 不需要$, \deg 需要$
  \def\deg{^{\circ}}
  \def\degree{${}^{\circ}$}
  % 下划线定义
  \def\zjuu[#1]#2{\underline{\hbox to #1{\hfil#2\hfil}}}


% 自定义信息参数传递
  \newcommand\major[1]{\def\@major{#1}}
  \newcommand\name[1]{\def\@name{#1}}
  \newcommand\stuid[1]{\def\@stuid{#1}}
  \newcommand\college[1]{\def\@college{#1}}
  \newcommand\department[1]{\def\@department{#1}}

  \renewcommand\date[1]{\def\@date{#1}}
  \newcommand\lab[1]{\def\@lab{#1}}
  \newcommand\course[1]{\def\@course{#1}}
  \newcommand\instructor[1]{\def\@instructor{#1}}
  \newcommand\grades[1]{\def\@grades{#1}}
  \newcommand\expname[1]{\def\@expname{#1}}
  \newcommand\exptype[1]{\def\@exptype{#1}}
  \newcommand\partner[1]{\def\@partner{#1}}
%

% 页面参数
  % 行距
  \linespread{1.2}
  % 页边距
  \geometry{top=1in,bottom=1in,left=1in,right=1in}
  % 目录深度
  \setcounter{secnumdepth}{3}
% 

% 多级标题
  % 命名格式
  \renewcommand\thesection{\CJKnumber{\arabic{section}}、}
  \renewcommand\thesubsection{\arabic{subsection}.}
  \renewcommand\thesubsubsection{\thesubsection\arabic{subsubsection}}
  % 序号格式
  \setlist[enumerate,1]{label=(\arabic*)}
  \setlist[enumerate,2]{label=\alph*.}
  % 字体
  \titleformat*{\section}{\large\bfseries}
  \titleformat*{\subsection}{\normalsize\bfseries}
  \titleformat*{\subsubsection}{\normalsize}
  % 间隔
  \titlespacing{\subsection}{1em}{*4}{*1.5}
  \titlespacing{\subsubsection}{1em}{*4}{*1.5}
%

% 图片路径（实现多种文件夹都可以放图片
  \graphicspath{{figures/}{figure/}{pictures/}{picture/}{pic/}{pics/}{image/}{images/}}
%

% 代码块样式
% 	\lstset{
% 	language = Verilog,
% 	basicstyle=\small\fontspec{Hack},
% 		% basicstyle=\small\ttfamily,	% 基本样式
% 		keywordstyle=\color{blue}, % 关键词样式
% 		commentstyle=\color{gray!40!black!60},   	% 注释样式
% 		stringstyle=\rmfamily\slshape\color{red}, 	% 字符串样式
% 		backgroundcolor=\color{white},     % 代码块背景颜色
% 		frame=leftline,						% 代码框形状
% 		framerule=12pt,%
% 		rulecolor=\color{gray!10},      % 代码框颜色
% 		numbers=left,				% 左侧显示行号往左靠, 还可以为right ，或none，即不加行号
% 		numberstyle=\footnotesize\fontspec{Hack},	% 行号的样式
% 		firstnumber=1,
% 		stepnumber=1,                  	% 若设置为2，则显示行号为1,3,5
% 		numbersep=3pt,               	% 行号与代码之间的间距
% 		aboveskip=.25em, 			% 代码块边框
% 		showspaces=false,               	% 显示添加特定下划线的空格
% 		showstringspaces=false,         	% 不显示代码字符串中间的空格标记
% 		keepspaces=true, 					
% 		showtabs=false,                 	% 在字符串中显示制表符
% 		tabsize=2,                     		% 默认缩进2个字符
% 		captionpos=b,                   	% 将标题位置设置为底部
% 		flexiblecolumns=false, 			%?
% 		breaklines=false,                	% 设置自动断行
% 		breakatwhitespace=false,        	% 设置自动中断是否只发生在空格处
% 		breakautoindent=true,			%
% 		breakindent=1em, 			%
% 		title=\lstname,				%
% 		escapeinside=``,  			% 在``里显示中文
% 		xleftmargin=2em,  xrightmargin=1em,     % 设定listing左右的空白
% 		aboveskip=1ex, belowskip=1ex,
% 		framextopmargin=1pt, framexbottommargin=1pt,
% 			abovecaptionskip=-2pt,belowcaptionskip=3pt,
% 		% 设定中文冲突，断行，列模式，数学环境输入，listing数字的样式
% 		extendedchars=false, columns=flexible, mathescape=true,
% 		texcl=true,
% 		fontadjust
% 	}
% %


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

% 页眉
  \pagestyle{empty}
% 

% 首页头部
  \newcommand{\makeheader}{
    \begin{figure}[h]
      \begin{minipage}{0.7\linewidth}
        \centerline{\includegraphics[width=\linewidth]{../source/logo/head.jpg}}
      \end{minipage}
      \hfill
      \begin{minipage}{.3\linewidth}
        \raggedleft
        \begin{tabular*}{.8\linewidth}{ll}
          专业： & \zjuu[70pt]\@major   \\
          姓名： & \zjuu[70pt]\@name    \\
          学号： & \zjuu[70pt]\@stuid   \\
          日期： & \zjuu[70pt]\@date \\
          地点： & \zjuu[70pt]\@lab
        \end{tabular*}
      \end{minipage}
    \end{figure}

    \thispagestyle{empty}
  }
% 

% 封面
  \newcommand{\makecover}{
    \begin{center}
      \begin{center}
        \includegraphics[width=0.8\linewidth]{../source/logo/cover.png}
      \end{center}
      \vspace{1cm}
      \bfseries\huge{本科实验报告}\\
      \vspace{0.5cm}
      \vspace{2cm}
      \begin{center}
        \Large
        \linespread{2}
        \centering
        \renewcommand\arraystretch{1.6}
        \begin{tabular}{p{3cm}c}
          \bfseries{课程名称：} & \@course \\ \cline{2-2}
          \bfseries{姓\hphantom{两格}名：}     & \@name   \\ \cline{2-2}
          \bfseries{学\hphantom{两格}院：}     & \@college \\ \cline{2-2}
          \bfseries{\hphantom{三格的}系：}     &\@department   \\ \cline{2-2}
          \bfseries{专\hphantom{两格}业：}     & \@major  \\ \cline{2-2}
          \bfseries{学\hphantom{两格}号：}     & \@stuid  \\ \cline{2-2}
          \bfseries{指导老师：} & \@instructor  \\ \cline{2-2}
        \end{tabular}
      \end{center}
      \vspace{1.5cm}
      \Large{\@date}
    \end{center}
    \thispagestyle{empty}
    \newpage
  }
% 