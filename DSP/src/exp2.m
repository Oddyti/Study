f = 50;
T = 0.000625;
N = 32;
t = 0:0.001:0.05;
n = 0:1:N-1;
xt = sin(2*pi*f*t);
xn = sin(2*pi*f*T*n);
myPlot2(xt, xn, t, n, 'exp2');