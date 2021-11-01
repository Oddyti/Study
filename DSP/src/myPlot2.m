% 生成序列并绘图
function y = myPlot2(T, N, Name)
    f = 50;
    t = 0:0.001:0.1;
    n = 0:1:N-1;
    xt = sin(2*pi*f*t);
    xn = sin(2*pi*f*T*n);
    h1 = figure(1);
    set(gcf,'outerposition',get(0,'screensize'));
        subplot(2, 1, 1);
            plot(t, xt);
                title('原序列','FontSize',20);
                xlabel('t');
                set(gca,'FontSize',16);
        subplot(2, 1, 2);
            stem(n, xn, 'filled');
                title('采样后的序列','FontSize',20);
                xlabel('n');
                set(gca,'FontSize',16);
    saveas(h1, [Name,'_1'],'png');
    % 绘制实部、虚部、模、相角图
    h2 = figure(2);
    set(gcf,'outerposition',get(0,'screensize'));
    % 实部
    subplot(2, 2, 1);
        stem(n, real(xn), 'filled');
        title('实部','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    % 虚部
    subplot(2, 2, 2);
        stem(n, imag(xn), 'filled');
        title('虚部','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    % 模
    subplot(2, 2, 3);
        stem(n, abs(xn), 'filled');
        title('模','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    % 相角
    subplot(2, 2, 4);
        stem(n, (180/pi)*angle(xn), 'filled');
        title('相角','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    saveas(h2, [Name,'_2'],'png');
    % 绘制幅度谱、频谱实部、频谱虚部图
    % 求DFT
    % Xk = myDFT(x, N);
    Xk = fft(xn);
    h3 = figure(3);
    set(gcf,'outerposition',get(0,'screensize'));
    % 幅度谱
    subplot(3, 1, 1);
        stem(n, abs(Xk), 'filled');
        title('DFT幅度谱','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    % 频谱实部
    subplot(3, 1, 2);
        stem(n, real(Xk), 'filled');
        title('DFT实部','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    % 频谱虚部
    subplot(3, 1, 3);
        stem(n, imag(Xk), 'filled');
        title('DFT虚部','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    saveas(h3, [Name,'_3'],'png');
end