function y = myPlot(x, N, Name)
    n = 0:1:N-1;
    k = 0:1:N-1;
    % 绘制实部、虚部、模、相角图
    h1 = figure(1);
    set(gcf,'outerposition',get(0,'screensize'));
    % 实部
    subplot(2, 4, 1);
    stem(n, real(x), 'filled');
    title('实部','FontSize',20);
    xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 1);
    % 虚部
    subplot(2, 4, 2);
    stem(n, imag(x), 'filled');
    title('虚部','FontSize',20);
    xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 2);
    % 模
    subplot(2, 4, 3);
    stem(n, abs(x), 'filled');
    title('模','FontSize',20);
    xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 3);
    % 相角
    subplot(2, 4, 4);
    stem(n, (180/pi)*angle(x), 'filled');
    title('相角','FontSize',20);
    xlabel('n');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 1, 4);
    % 绘制幅度谱、频谱实部、频谱虚部图
    % 求DFT
    % Xk = myDFT(x, N);
    Xk = fft(x);
    % 幅度谱
    subplot(2, 4, 5);
    stem(k, abs(Xk), 'filled');
    title('幅度谱','FontSize',20);
    xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 1);
    % 频谱实部
    subplot(2, 4, 6);
    stem(k, real(Xk), 'filled');
    title('频谱实部','FontSize',20);
    xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 2);
    % 频谱虚部
    subplot(2, 4, 7);
    stem(k, imag(Xk), 'filled');
    title('频谱虚部','FontSize',20);
    xlabel('k');
    set(gca,'FontSize',16);
    RemoveSubplotWhiteArea(gca, 2, 4, 2, 3);
    saveas(h1, Name,'png');
end