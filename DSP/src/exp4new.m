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
    % 2-1
    f1 = figure(1);
    set(gcf,'outerposition',get(0,'screensize'));
    subplot(2, 2, [1,2]);
        stem(n1, h1, 'filled', 'Linewidth', 1.2);
        hold on;
        stem(n1, h2, 'filled', 'Linewidth', 1.2);
        title('', 'Fontsize', 16);
        axis([0 30 -0.2 0.6]);
        xlabel('n', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('矩形窗滤波器h_1(n)与汉明窗滤波器h_2(n)', 'Fontsize', 16);
        legend('h_1(n)','h_2(n)');
    subplot(2, 2, 3);
        plot(w1/pi, abs(H1), 'Linewidth', 1.2);
        hold on;
        plot(w2/pi, abs(H2), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|H_1(k)|与|H_2(k)|比较', 'Fontsize', 16);
        legend('|H_1(k)|','|H_2(k)|');
    subplot(2, 2, 4);
        plot(w1/pi, 20*log10(abs(H1)), 'Linewidth', 1.2);
        hold on;
        plot(w2/pi, 20*log10(abs(H2)), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('20lg|H_1(k)|与20lg|H_2(k)|比较', 'Fontsize', 16);
        legend('20lg|H_1(k)|','20lg|H_2(k)|');
    saveas(f1, 'exp4-2-1', 'png');

    % 2-2
    f2 = figure(2);
    set(gcf,'outerposition',get(0,'screensize'));
    subplot(2, 1, 1);
        stem(n2, x, 'filled', 'Linewidth', 1.2);
        xlabel('n', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('随机信号序列x(n)', 'Fontsize', 16);
    subplot(2, 1, 2);
        plot(w/pi, abs(X), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|X(k)|', 'Fontsize', 16);
    saveas(f2, 'exp4-2-2', 'png');

    % 2-3
    f3 = figure(3);
    set(gcf,'outerposition',get(0,'screensize'));
        plot(w/pi, abs(X), 'Linewidth', 1.2);
        hold on;
        plot(yw1/pi, abs(Y1), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|X(k)|和|Y_1(k)|比较', 'Fontsize', 16);
        legend('|X(k)|','|Y_1(k)|');
    saveas(f3, 'exp4-2-3-1', 'png');

    f4 = figure(4);
    set(gcf,'outerposition',get(0,'screensize'));
    subplot(2,2,1);
        plot(w1/pi, abs(H1), 'Linewidth', 1.2);
        hold on;
        plot(w2/pi, abs(H2), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|H_1(k)|与|H_2(k)|比较', 'Fontsize', 16);
        legend('|H_1(k)|','|H_2(k)|');
    subplot(2,2,2);
        plot(w1/pi, 20*log10(abs(H1)), 'Linewidth', 1.2);
        hold on;
        plot(w2/pi, 20*log10(abs(H2)), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('20lg|H_1(k)|与20lg|H_2(k)|比较', 'Fontsize', 16);
        legend('20lg|H_1(k)|','20lg|H_2(k)|');
    subplot(2,2,[3,4]);
        plot(yw1/pi, abs(Y1), 'Linewidth', 1.2);
        hold on;
        plot(yw2/pi, abs(Y2), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|Y_1(k)|和|Y_2(k)|比较', 'Fontsize', 16);
        legend('|Y_1(k)|','|Y_2(k)|');
    saveas(f4, 'exp4-2-3-2', 'png');

    % 2-4
    f5 = figure(5);
    set(gcf,'outerposition',get(0,'screensize'));
    subplot(2,2,1);
        plot(w1/pi, abs(H1), 'Linewidth', 1.2);
        hold on;
        plot(w3/pi, abs(H3), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|H_1(k)|与|H_3(k)|比较', 'Fontsize', 16);
        legend('|H_1(k)|','|H_3(k)|');
    subplot(2,2,2);
        plot(w1/pi, 20*log10(abs(H1)), 'Linewidth', 1.2);
        hold on;
        plot(w3/pi, 20*log10(abs(H3)), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('20lg|H_1(k)|与20lg|H_3(k)|比较', 'Fontsize', 16);
        legend('20lg|H_1(k)|','20lg|H_3(k)|');
    subplot(2,2,[3,4]);
        plot(yw1/pi, abs(Y1), 'Linewidth', 1.2);
        hold on;
        plot(yw3/pi, abs(Y3), 'Linewidth', 1.2);
        grid on;
        xlabel('\omega / \pi', 'Fontsize', 16);
        set(gca,'FontSize',15);
        title('|Y_1(k)|和|Y_3(k)|比较', 'Fontsize', 16);
        legend('|Y_1(k)|','|Y_3(k)|');
    saveas(f5, 'exp4-2-4', 'png');
    
    % 5-2
        % h1(n), h2(n)
        f6 = figure(6);
        set(gcf,'outerposition',get(0,'screensize'));
        subplot(1, 2, 1);
            stem(n1, h1, 'filled', 'Linewidth', 1.2);
            xlabel('n', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('矩形窗滤波器h_1(n)', 'Fontsize', 16);
        subplot(1, 2, 2);
            stem(n1, h2, 'filled', 'Linewidth', 1.2);
            axis([0 30 -0.2 0.6]);
            xlabel('n', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('汉明窗滤波器h_2(n)', 'Fontsize', 16);
        saveas(f6, 'exp4-5-2-1', 'png');

        % H1(k), H2(k), X(k)
        f7 = figure(7);
        set(gcf,'outerposition',get(0,'screensize'));
        subplot(3, 1, 1);
            plot(w1/pi, abs(H1), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|H_1(k)|', 'Fontsize', 16);
        subplot(3, 1, 2);
            plot(w2/pi, abs(H2), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|H_2(k)|', 'Fontsize', 16);
        subplot(3, 1, 3);
            plot(w/pi, abs(X), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|X(k)|', 'Fontsize', 16);
        saveas(f7, 'exp4-5-2-2', 'png');

        % Y1(k), Y2(k), Y3(k)
        f8 = figure(8);
        set(gcf,'outerposition',get(0,'screensize'));
        subplot(3, 1, 1);
            plot(yw1/pi, abs(Y1), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|Y_1(k)|', 'Fontsize', 16);
        subplot(3, 1, 2);
            plot(yw2/pi, abs(Y2), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|Y_2(k)|', 'Fontsize', 16);
        subplot(3, 1, 3);
            plot(yw3/pi, abs(Y3), 'Linewidth', 1.2);
            grid on;
            xlabel('\omega / \pi', 'Fontsize', 16);
            set(gca,'FontSize',15);
            title('|Y_3(k)|', 'Fontsize', 16);
        saveas(f8, 'exp4-5-2-3', 'png');

