% 原始序列
xn = [3,1,9,0,1,0,5,5,9,7,0,0,0,0,0,0];
n = 1:16;

% 绘制原始序列
f1 = figure(1);
    set(gcf,'outerposition',get(0,'screensize'));
    stem(n, real(xn), 'filled');
    title('原序列');
    set(gca,'FontSize',16);
    axis([0 17 -1 10]);
    saveas(f1, 'exp3_1','png');
% 基4 DFT
N = 16;
W = exp(-1j*2*pi/N);
W4 = dftmtx(4);

% 第一级蝶形运算
X1 = W4*[xn(1); xn(5); xn(9); xn(13)];
X2 = W4*[xn(2); xn(6); xn(10); xn(14)];
X3 = W4*[xn(3); xn(7); xn(11); xn(15)];
X4 = W4*[xn(4); xn(8); xn(12); xn(16)];

% 第二级蝶形运算
Xk = zeros(1, 16);
for k = 0:3
    temp = W4*[
        X1(k + 1);
        X2(k + 1)*(W^k);
        X3(k + 1)*(W^(2*k));
        X4(k + 1)*(W^(3*k))];
    Xk(k + 1) = temp(1);
    Xk(k + 5) = temp(2);
    Xk(k + 9) = temp(3);
    Xk(k + 13) = temp(4);
end

f2 = figure(2);
set(gcf,'outerposition',get(0,'screensize'));
    stem(n, real(Xk), 'filled');
    title('基4-FFT算法输出频谱实部');
    set(gca,'FontSize',16);
    axis([0 17 -16 43]);
    saveas(f2, 'exp3_2','png');

f3 = figure(3);
set(gcf,'outerposition',get(0,'screensize'));
    stem(n, imag(Xk), 'filled');
    title('基4-FFT算法输出频谱虚部');
    set(gca,'FontSize',16);
    saveas(f3, 'exp3_3','png');

% 对比直接调用FFT函数结果
Xk2 = fft(xn);
f4 = figure(4);
set(gcf,'outerposition',get(0,'screensize'));
    stem(n, real(Xk2), 'filled');
    title('直接调用FFT函数频谱实部');
    set(gca,'FontSize',16);
    axis([0 17 -16 43]);
    saveas(f4, 'exp3_4','png');
