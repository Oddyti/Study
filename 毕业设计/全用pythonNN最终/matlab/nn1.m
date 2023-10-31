%%%%%%%%%%%%%% 验证PRBS序列
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 6000;
SNR = 1;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt = randi([0 1], L, 1); % 梅森扭转\
tx_seq_prbs4 = prbs(4, L)';
tx_seq_prbs5 = prbs(5, L)';
tx_seq_prbs6 = prbs(6, L)';
tx_seq_prbs7 = prbs(7, L)';
tx_seq_prbs8 = prbs(8, L)';
tx_seq_prbs9 = prbs(9, L)';
tx_seq_prbs10 = prbs(10, L)';
tx_seq_prbs11 = prbs(11, L)';
tx_seq_prbs12 = prbs(12, L)';
tx_seq_prbs13 = prbs(13, L)';


% 信号传输
[sig_qam_mt, sig_sam_mt] = channel(tx_seq_mt, SNR);
[sig_qam_prbs4, sig_sam_prbs4] = channel(tx_seq_prbs4, SNR);
[sig_qam_prbs5, sig_sam_prbs5] = channel(tx_seq_prbs5, SNR);
[sig_qam_prbs6, sig_sam_prbs6] = channel(tx_seq_prbs6, SNR);
[sig_qam_prbs7, sig_sam_prbs7] = channel(tx_seq_prbs7, SNR);
[sig_qam_prbs8, sig_sam_prbs8] = channel(tx_seq_prbs8, SNR);
[sig_qam_prbs9, sig_sam_prbs9] = channel(tx_seq_prbs9, SNR);
[sig_qam_prbs10, sig_sam_prbs10] = channel(tx_seq_prbs10, SNR);
[sig_qam_prbs11, sig_sam_prbs11] = channel(tx_seq_prbs11, SNR);
[sig_qam_prbs12, sig_sam_prbs12] = channel(tx_seq_prbs12, SNR);
[sig_qam_prbs13, sig_sam_prbs13] = channel(tx_seq_prbs13, SNR);

% 数据集拼接
mem_n = 20; % 记忆深度
modify_data_mt = modify_data(sig_sam_mt, sig_qam_mt, mem_n);
modify_data_prbs4 = modify_data(sig_sam_prbs4, sig_qam_prbs4, mem_n);
modify_data_prbs5 = modify_data(sig_sam_prbs5, sig_qam_prbs5, mem_n);
modify_data_prbs6 = modify_data(sig_sam_prbs6, sig_qam_prbs6, mem_n);
modify_data_prbs7 = modify_data(sig_sam_prbs7, sig_qam_prbs7, mem_n);
modify_data_prbs8 = modify_data(sig_sam_prbs8, sig_qam_prbs8, mem_n);
modify_data_prbs9 = modify_data(sig_sam_prbs9, sig_qam_prbs9, mem_n);
modify_data_prbs10 = modify_data(sig_sam_prbs10, sig_qam_prbs10, mem_n);
modify_data_prbs11 = modify_data(sig_sam_prbs11, sig_qam_prbs11, mem_n);
modify_data_prbs12 = modify_data(sig_sam_prbs12, sig_qam_prbs12, mem_n);
modify_data_prbs13 = modify_data(sig_sam_prbs13, sig_qam_prbs13, mem_n);

% 划分数据集，训练集（k）与测试集占比

% 训练20次后取误码率截尾平均值
err_ratio_times = [];

for i = 1:16
    fprintf('times = %d\n', i);
    k = 0.8;
    [x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
    [x_train_prbs4, y_train_prbs4, x_test_prbs4, y_test_prbs4] = train_test_split(modify_data_prbs4, k);
    [x_train_prbs5, y_train_prbs5, x_test_prbs5, y_test_prbs5] = train_test_split(modify_data_prbs5, k);
    [x_train_prbs6, y_train_prbs6, x_test_prbs6, y_test_prbs6] = train_test_split(modify_data_prbs6, k);
    [x_train_prbs7, y_train_prbs7, x_test_prbs7, y_test_prbs7] = train_test_split(modify_data_prbs7, k);
    [x_train_prbs8, y_train_prbs8, x_test_prbs8, y_test_prbs8] = train_test_split(modify_data_prbs8, k);
    [x_train_prbs9, y_train_prbs9, x_test_prbs9, y_test_prbs9] = train_test_split(modify_data_prbs9, k);
    [x_train_prbs10, y_train_prbs10, x_test_prbs10, y_test_prbs10] = train_test_split(modify_data_prbs10, k);
    [x_train_prbs11, y_train_prbs11, x_test_prbs11, y_test_prbs11] = train_test_split(modify_data_prbs11, k);
    [x_train_prbs12, y_train_prbs12, x_test_prbs12, y_test_prbs12] = train_test_split(modify_data_prbs12, k);
    [x_train_prbs13, y_train_prbs13, x_test_prbs13, y_test_prbs13] = train_test_split(modify_data_prbs13, k);
    err_ratio_mod = [];

    for nn_mod = 1:11
        fprintf(' \t NN_MOD = %d\n', nn_mod);

        switch nn_mod
            case 1 % Train: mt, Test: mt
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test = x_test_mt;
                y_test = y_test_mt;
            case 2 % Train: prbs4, Test: prbs4
                x_train = x_train_prbs4;
                y_train = y_train_prbs4;
                x_test = x_test_prbs4;
                y_test = y_test_prbs4;
            case 3 % Train: prbs5, Test: prbs5
                x_train = x_train_prbs5;
                y_train = y_train_prbs5;
                x_test = x_test_prbs5;
                y_test = y_test_prbs5;
            case 4 % Train: prbs6, Test: prbs6
                x_train = x_train_prbs6;
                y_train = y_train_prbs6;
                x_test = x_test_prbs6;
                y_test = y_test_prbs6;
            case 5 % Train: prbs7, Test: prbs7
                x_train = x_train_prbs7;
                y_train = y_train_prbs7;
                x_test = x_test_prbs7;
                y_test = y_test_prbs7;
            case 6 % Train: prbs8, Test: prbs8
                x_train = x_train_prbs8;
                y_train = y_train_prbs8;
                x_test = x_test_prbs8;
                y_test = y_test_prbs8;
            case 7 % Train: prbs9, Test: prbs9
                x_train = x_train_prbs9;
                y_train = y_train_prbs9;
                x_test = x_test_prbs9;
                y_test = y_test_prbs9;
            case 8 % Train: prbs10, Test: prbs10
                x_train = x_train_prbs10;
                y_train = y_train_prbs10;
                x_test = x_test_prbs10;
                y_test = y_test_prbs10;
            case 9 % Train: prbs1, Test: prbs11
                x_train = x_train_prbs11;
                y_train = y_train_prbs11;
                x_test = x_test_prbs11;
                y_test = y_test_prbs11;
            case 10 % Train: prbs12, Test: prbs12
                x_train = x_train_prbs12;
                y_train = y_train_prbs12;
                x_test = x_test_prbs12;
                y_test = y_test_prbs12;
            case 11 % Train: prbs13, Test: prbs13
                x_train = x_train_prbs13;
                y_train = y_train_prbs13;
                x_test = x_test_prbs13;
                y_test = y_test_prbs13;
        end

        % NN网络设置
        hidden_n = mem_n - 2;
        net = newff(real(x_train), real(y_train), [hidden_n, hidden_n], {'tansig' 'trainrp'}, 'trainlm');
        % net = fitnet(25);
        net.trainParam.show = 10; %显示训练迭代过程，每10周期
        net.trainParam.epochs = 300;
        net.trainParam.goal = 0.0001;
        net.trainParam.lr = 0.01;
        net.trainParam.showWindow = false;

        % 训练网络
        [net1, ~] = train(net, real(x_train), real(y_train));
        [net2, ~] = train(net, imag(x_train), imag(y_train));
        % NN均�
        sim_real = sim(net1, real(x_test));
        sim_imag = sim(net2, imag(x_test));

        % NN误码率计算
        sim_data = sim_real + sim_imag * 1i;
        data_eq = judge(sim_data);
        rx_nn = qamdemod(data_eq.', Ms, 'bin', 'OutputType', 'bit');
        tx_test = qamdemod(y_test.', Ms, 'bin', 'OutputType', 'bit');
        [~, ratio] = symerr(tx_test, rx_nn);
        err_ratio_mod = [err_ratio_mod; ratio];
    end

    err_ratio_times = [err_ratio_times, err_ratio_mod];
end

err_ratio_all = zeros(2, 10);

for i = 1:10
    err_ratio_all(1, i) = err_ratio_times(1);
end

err_ratio_all(2, :) = trimmean(err_ratio_times(2:end,:), 20, 2)';

%% 画图1
close all;
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 4:13;
plot(x, err_ratio_all(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(2, :), '-+', 'color', color2 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'prbsN-prbsN', 'Location', 'Southeast')
xlabel('PRBS阶数');
ylabel('BER');

err_ratio_db = 10 * log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(2, :), '-+', 'color', color2 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'prbsN-prbsN', 'Location', 'Southeast')
xlabel('PRBS阶数');
ylabel('BER(dB)');
