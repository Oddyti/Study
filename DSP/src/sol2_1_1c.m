% 构造函数 其a = 0.9, length = 20
a = 0.9;
length = 20;
n = 0:1:length - 1;
xn = ((a).^n).*(0 <= n & n <= (length - 1));
% 绘图
myPlot(xn, length, '2_1_1c');