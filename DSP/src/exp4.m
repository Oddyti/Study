% 参数
wc = 0.5 * pi;
N1 = 31         % 滤波器1，2
n1 = 0:1:N1-1;
N2 = 200;       % 输入序列
n2 = 0:1:N2-1;
N3 = 127;       % 滤波器3
n3 = 0:1:N3-1;
% 输入函数
x = rand(1,200) - 0.5;
[X, w] = freqz(x);
% 滤波器设计
h1 = fir1(N1-1, wc/pi, boxcar(N1));
[H1, w1] = freqz(h1);
h2 = fir1(N1-1, wc/pi);
[H2, w2] = freqz(h2);
h3 = fir1(N3-1, wc/pi, boxcar(N3));
[H3, w3] = freqz(h3);
% 滤波结果
y1 = filter(h1, 1, x);
[Y1, yw1] = freqz(y1);
y2 = filter(h2, 1, x);
[Y2, yw2] = freqz(y2);
y3 = filter(h3, 1, x);
[Y3, yw3] = freqz(y3);
% 绘图

% h1(n), h2(n)
f = figure(1);
set(gcf,'outerposition',get(0,'screensize'));
subplot(1, 2, 1);
    stem(n1, h1, 'filled');
    xlabel('n', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('矩形窗滤波器h_1(n)', 'Fontsize', 16);
subplot(1, 2, 2);
    stem(n1, h2, 'filled');
    axis([0 30 -0.2 0.6]);
    xlabel('n', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('汉明窗滤波器h_2(n)', 'Fontsize', 16);
saveas(f, 'exp4-5-2-1', 'png');

% H1(k), H2(k), X(k)

f = figure(1);
set(gcf,'outerposition',get(0,'screensize'));
subplot(3, 1, 1);
    plot(w1/pi, abs(H1));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|H_1(k)|', 'Fontsize', 16);
subplot(3, 1, 2);
    plot(w2/pi, abs(H2));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|H_2(k)|', 'Fontsize', 16);
subplot(3, 1, 3);
    plot(w/pi, abs(X));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|X(k)|', 'Fontsize', 16);
saveas(f, 'exp4-5-2-2', 'png');

% Y1(k), Y2(k), Y3(k)
f = figure(1);
set(gcf,'outerposition',get(0,'screensize'));
subplot(3, 1, 1);
    plot(yw1/pi, abs(Y1));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|Y_1(k)|', 'Fontsize', 16);
subplot(3, 1, 2);
    plot(yw2/pi, abs(Y2));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|Y_2(k)|', 'Fontsize', 16);
subplot(3, 1, 3);
    plot(yw3/pi, abs(Y3));
    grid on;
    xlabel('\omega / \pi', 'Fontsize', 16);
    set(gca,'FontSize',15);
    title('|Y_3(k)|', 'Fontsize', 16);
saveas(f, 'exp4-5-2-3', 'png');

