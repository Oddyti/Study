% 构造函数 其a = 0.5, b = 0.8, length = 10
a = 0.5;
b = 0.8;
length = 10;
n = 0:1:length-1;
xn = ((a + j*b).^n).*(0 <= n & n <= (length-1));
% 绘图
myPlot(xn, length, '2_1_2');