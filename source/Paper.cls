\ProvidesClass{zjureport}
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

% 自定义信息参数传递
	\newcommand\articletitle[1]{\def\@articletitle{#1}}		%标题
	\newcommand\major[1]{\def\@major{#1}}					%专业
	\newcommand\college[1]{\def\@college{#1}}				%学院
	\newcommand\name[1]{\def\@name{#1}}						%姓名
	\newcommand\stuid[1]{\def\@stuid{#1}}					%学号
	\renewcommand\date[1]{\def\@date{#1}}					%日期
	\newcommand\course[1]{\def\@course{#1}}					%课程
	\newcommand\instructor[1]{\def\@instructor{#1}} 		%导师
	\newcommand\Abstract[1]{\def\@Abstract{#1}} 			%摘要
	\newcommand\Keyword[1]{\def\@Keyword{#1}} 				%关键词
%

%自定义命令
	%脚注
	\newcommand{\Footnote}[1]{\footnote{\small\kaishu #1}}
%

%页面参数
	%主要字体 斜体+楷体 粗体=黑体
	\setCJKmainfont[ItalicFont={KaiTi},BoldFont={SimHei}]{SimSun}
	%页边距
	\geometry{top=1in,bottom=1in,left=1in,right=1in}
	%行距
	\linespread{1.5}
	%目录深度
	\setcounter{secnumdepth}{3}
%

%多级标题
	%多级标题命名格式
	\renewcommand\thesection{\CJKnumber{\arabic{section}}、}
	\renewcommand\thesubsection{\arabic{subsection}.}
	\renewcommand\thesubsubsection{\thesubsection\arabic{subsubsection}}
	%多级标题字体
	\titleformat*{\section}{\large\bfseries}
	\titleformat*{\subsection}{\normalsize\bfseries}
	\titleformat*{\subsubsection}{\normalsize}
	%多级标题间隔
	\titlespacing{\section}{0pt}{*1.5}{*1.5}
	\titlespacing{\subsection}{2em}{*1}{*1}
	\titlespacing{\subsubsection}{2em}{*1}{*1}
	%多级序号格式
	\setlist[enumerate,1]{label=(\arabic*)}
	\setlist[enumerate,2]{label=\alph*.}
%

%图片路径（实现多种文件夹都可以放图片
	\graphicspath{{figures/}{figure/}{pictures/}{picture/}{pic/}{pics/}{image/}{images/}}
%

% 页眉页码
	\pagestyle{fancy}
	\lhead{课程：\@course}
	\chead{姓名：\@name}
	\rhead{学号：\@stuid}
%

%代码块样式
	\lstset{
	language = Verilog,
	basicstyle=\small\fontspec{Hack},
		% basicstyle=\small\ttfamily,	% 基本样式
		keywordstyle=\color{blue}, % 关键词样式
		commentstyle=\color{gray!40!black!60},   	% 注释样式
		stringstyle=\rmfamily\slshape\color{red}, 	% 字符串样式
		backgroundcolor=\color{white},     % 代码块背景颜色
		frame=leftline,						% 代码框形状
		framerule=12pt,%
		rulecolor=\color{gray!10},      % 代码框颜色
		numbers=left,				% 左侧显示行号往左靠, 还可以为right ，或none，即不加行号
		numberstyle=\footnotesize\fontspec{Hack},	% 行号的样式
		firstnumber=1,
		stepnumber=1,                  	% 若设置为2，则显示行号为1,3,5
		numbersep=3pt,               	% 行号与代码之间的间距
		aboveskip=.25em, 			% 代码块边框
		showspaces=false,               	% 显示添加特定下划线的空格
		showstringspaces=false,         	% 不显示代码字符串中间的空格标记
		keepspaces=true, 					
		showtabs=false,                 	% 在字符串中显示制表符
		tabsize=2,                     		% 默认缩进2个字符
		captionpos=b,                   	% 将标题位置设置为底部
		flexiblecolumns=false, 			%?
		breaklines=false,                	% 设置自动断行
		breakatwhitespace=false,        	% 设置自动中断是否只发生在空格处
		breakautoindent=true,			%
		breakindent=1em, 			%
		title=\lstname,				%
		escapeinside=``,  			% 在``里显示中文
		xleftmargin=2em,  xrightmargin=1em,     % 设定listing左右的空白
		aboveskip=1ex, belowskip=1ex,
		framextopmargin=1pt, framexbottommargin=1pt,
			abovecaptionskip=-2pt,belowcaptionskip=3pt,
		% 设定中文冲突，断行，列模式，数学环境输入，listing数字的样式
		extendedchars=false, columns=flexible, mathescape=true,
		texcl=true,
		fontadjust
	}
%

% 头部
	\newcommand{\makeheader}{
		%标题
		\begin{center}
			\bfseries\huge{\@articletitle}
		\end{center}
		%间距0.6cm
		\vspace{0.6cm}
		%个人信息
		{\noindent\normalsize\kaishu{\@name；\@stuid；\@college；\@major}} \par
		%摘要
		{\noindent\normalsize\heiti{摘要：}}
		{\normalsize\kaishu{\@Abstract}} \par
		%关键词
		{\noindent\normalsize\heiti{关键词：}}
		{\normalsize\kaishu{\@Keyword}}
	}
%
