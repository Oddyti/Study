% 构造函数 其f1 = 1Hz, f2 = 3Hz, T = 0.1s, delta = 0.5, phi = 90, length = 10
f1 = 1;
f2 = 3;
T = 0.1;
delta = 0.5;
phi = 90;
length = 10;
n = 0:1:length-1;
xn = sin(2*pi*f1.*n*T) + delta * sin(2*pi*f2.*n*T + phi/180*pi);
% 绘图
myPlot(xn,length, '2_1_5b');