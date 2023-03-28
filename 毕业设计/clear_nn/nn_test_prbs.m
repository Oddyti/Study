%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 10000;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt = randi([0 1], L * k, 1); % 梅森扭转
tx_seq_prbs = prbs(5, L * k)';
tx_seq_mix = mix_prbs(5, L * k);

err_ratio_all = zeros(9, 13); % 记录每种模式不同SNR的误码率

for SNR = 0:12
    fprintf('SNR = %d\n', SNR);
    % 信号传输
    [sig_qam_mt, sig_sam_mt] = channel(tx_seq_mt, SNR);
    [sig_qam_prbs, sig_sam_prbs] = channel(tx_seq_prbs, SNR);
    [sig_qam_mix, sig_sam_mix] = channel(tx_seq_mix, SNR);
    % 数据集拼接
    mem_n = 22; % 记忆深度
    modify_data_mt = modify_data(sig_sam_mt, sig_qam_mt, mem_n);
    modify_data_prbs = modify_data(sig_sam_prbs, sig_qam_prbs, mem_n);
    modify_data_mix = modify_data(sig_sam_mix, sig_qam_mix, mem_n);
    % 划分数据集，训练集（k）与测试集占比
    k = 0.8;
    [x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
    [x_train_prbs, y_train_prbs, x_test_prbs, y_test_prbs] = train_test_split(modify_data_prbs, k);
    [x_train_mix, y_train_mix, x_test_mix, y_test_mix] = train_test_split(modify_data_mix, k);

    for nn_mod = 1:9
        fprintf('\t nn_mod = %d\n', nn_mod);

        switch nn_mod
            case 1 % Train: mt, Test: mt
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test = x_test_mt;
                y_test = y_test_mt;
            case 2 % Train: mt, Test: prbs
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test = x_test_prbs;
                y_test = y_test_prbs;
            case 3 % Train: mt, Test: mix
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test = x_test_mix;
                y_test = y_test_mix;
            case 4 % Train: prbs, Test: mt
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test = x_test_mt;
                y_test = y_test_mt;
            case 5 % Train: prbs, Test: prbs
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test = x_test_prbs;
                y_test = y_test_prbs;
            case 6 % Train: prbs, Test: mix
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test = x_test_mix;
                y_test = y_test_mix;
            case 7 % Train: mix, Test: mt
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test = x_test_mt;
                y_test = y_test_mt;
            case 8 % Train: mix, Test: prbs
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test = x_test_prbs;
                y_test = y_test_prbs;
            case 9 % Train: mix, Test: mix
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test = x_test_mix;
                y_test = y_test_mix;
        end

        % NN网络设置
        hidden_n = mem_n - 4;
        net = newff(real(x_train), real(y_train), hidden_n, {'tansig' 'tansig'}, 'traingdx');
        % net = fitnet(20);
        net.trainParam.show = 10; %显示训练迭代过程，每10周期
        net.trainParam.epochs = 300;
        net.trainParam.goal = 0.0001;
        net.trainParam.lr = 0.01;
        net.trainParam.showWindow = false;

        % 训练20次后取误码率截尾平均值
        err_ratio_nn_temp = [];

        for i = 1:20
            fprintf('\t \t train times = %d\n', i);
            % 训练网络
            [net, tr] = train(net, real(x_train), real(y_train));

            % NN均�
            sim_real = sim(net, real(x_test));
            sim_imag = sim(net, imag(x_test));

            % NN误码率计算
            sim_data = sim_real + sim_imag * 1i;
            data_eq = judge(sim_data);
            rx_nn = qamdemod(data_eq.', Ms, 'bin', 'OutputType', 'bit');
            tx_test = qamdemod(y_test.', Ms, 'bin', 'OutputType', 'bit');
            [~, ratio] = symerr(tx_test, rx_nn);
            err_ratio_nn_temp = [err_ratio_nn_temp, ratio];
        end

        % 取训练20次后误码率截尾平均值
        err_ratio_all(nn_mod, SNR + 1) = trimmean(err_ratio_nn_temp, 40);
    end

end

%% 画图
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 0:12;
plot(x, err_ratio_all(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(2, :), '-+', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(3, :), '-*', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(4, :), '-x', 'color', color2 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(5, :), '-s', 'color', color2 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(6, :), '-d', 'color', color2 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(7, :), '-^', 'color', color3 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(8, :), '-p', 'color', color3 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(9, :), '-h', 'color', color3 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'mt-prbs', 'mt-mix', 'prbs-mt', 'prbs-prbs', 'prbs-mix', 'mix-mt', 'mix-prbs', 'mix-mix', 'Location', 'Northeast')
xlabel('SNR');
ylabel('误码率');

err_ratio_db = 10 * log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(2, :), '-+', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(3, :), '-*', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(4, :), '-x', 'color', color2 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(5, :), '-s', 'color', color2 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(6, :), '-d', 'color', color2 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(7, :), '-^', 'color', color3 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(8, :), '-p', 'color', color3 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(9, :), '-h', 'color', color3 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'mt-prbs', 'mt-mix', 'prbs-mt', 'prbs-prbs', 'prbs-mix', 'mix-mt', 'mix-prbs', 'mix-mix', 'Location', 'Northeast')
xlabel('SNR');
ylabel('误码率dB');
