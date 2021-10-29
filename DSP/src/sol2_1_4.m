% 构造函数 其f = 1Hz, T = 0.1s, delta = 0, length = 10
f = 1;
T = 0.1;
length = 10;
delta = 0;
n = 0:1:length-1;
xn = cos(2*pi*f.*n*T+delta);
% 绘图
myPlot(xn, length, '2_1_4');