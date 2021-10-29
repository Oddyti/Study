function y = myPlot(xt, xn, t, n, Name)
    h1 = figure(1);
    set(gcf,'outerposition',get(0,'screensize'));
        subplot(2, 1, 1);
            plot(t, xt);
                title('原序列','FontSize',20);
                xlabel('t');
                set(gca,'FontSize',16);
        subplot(2, 1, 2);
            stem(n, xn, 'filled');
                title('采样','FontSize',20);
                xlabel('n');
                set(gca,'FontSize',16);
    saveas(h1, [Name,'_1'],'png');
    % 绘制实部、虚部、模、相角图
    h2 = figure(2);
    set(gcf,'outerposition',get(0,'screensize'));
    % 实部
    subplot(2, 4, 1);
        stem(n, real(xn), 'filled');
        title('实部','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 1);
    % 虚部
    subplot(2, 4, 2);
        stem(n, imag(xn), 'filled');
        title('虚部','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 2);
    % 模
    subplot(2, 4, 3);
        stem(n, abs(xn), 'filled');
        title('模','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 3);
    % 相角
    subplot(2, 4, 4);
        stem(n, (180/pi)*angle(xn), 'filled');
        title('相角','FontSize',20);
        xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 4);
    % 绘制幅度谱、频谱实部、频谱虚部图
    % 求DFT
    % Xk = myDFT(x, N);
    Xk = fft(xn);
    % 幅度谱
    subplot(2, 4, 5);
        stem(n, abs(Xk), 'filled');
        title('幅度谱','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 1);
    % 频谱实部
    subplot(2, 4, 6);
        stem(n, real(Xk), 'filled');
        title('频谱实部','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 2);
    % 频谱虚部
    subplot(2, 4, 7);
        stem(n, imag(Xk), 'filled');
        title('频谱虚部','FontSize',20);
        xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 3);
    saveas(h2, [Name,'_2'],'png');
end