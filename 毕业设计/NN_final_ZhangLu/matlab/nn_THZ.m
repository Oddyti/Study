%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 10000;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt_train = importdata('data/E_tx_mt_train.mat');
tx_seq_prbs_train = importdata('data/E_tx_prbs_train.mat');
tx_seq_mix_train = importdata('data/E_tx_mix_train.mat');
tx_seq_mt = importdata('data/E_tx_mt.mat');
tx_seq_prbs = importdata('data/E_tx_prbs.mat');
tx_seq_mix = importdata('data/E_tx_mix.mat');

rx_seq_mt_train = importdata('data/E_rx_mt_train.mat');
rx_seq_prbs_train = importdata('data/E_rx_prbs_train.mat');
rx_seq_mix_train = importdata('data/E_rx_mix_train.mat');
rx_seq_mt = importdata('data/E_rx_mt.mat');
rx_seq_prbs = importdata('data/E_rx_prbs.mat');
rx_seq_mix = importdata('data/E_rx_mix.mat');

Tx_seq = qamdemod(y_test.',Ms,'bin','UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
Rx_seq = qamdemod(x_test(1,:).',Ms,'bin','UnitAveragePower',true); % QAM解调

%% 数据处理（根据记忆深度补零）
mem_n = 30; % 记忆深度

% 数据拼接
modify_data_mt = modify_data(rx_seq_mt, tx_seq_mt, mem_n);
modify_data_prbs = modify_data(rx_seq_prbs, tx_seq_prbs, mem_n);
modify_data_mix = modify_data(rx_seq_mix, tx_seq_mix, mem_n);

modify_data_mt_train = modify_data(rx_seq_mt_train, tx_seq_mt_train, mem_n);
modify_data_prbs_train = modify_data(rx_seq_prbs_train, tx_seq_prbs_train, mem_n);
modify_data_mix_train = modify_data(rx_seq_mix_train, tx_seq_mix_train, mem_n);
% 划分数据集，训练集（k）与测试集占比

%% NN
err_ratio_all = []; % 记录每种模式不同SNR的误码率
% 训练20次后取误码率截尾平均值
err_ratio_times = [];

for i = 1:20
    fprintf('\t \t times = %d\n', i);
    k = 1;
    [x_train_mt, y_train_mt, ~, ~] = train_test_split(modify_data_mt_train, k);
    [x_train_prbs, y_train_prbs, ~, ~] = train_test_split(modify_data_prbs_train, k);
    [x_train_mix, y_train_mix, ~, ~] = train_test_split(modify_data_mix_train, k);
    k = 0;
    [~, ~, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
    [~, ~, x_test_prbs, y_test_prbs] = train_test_split(modify_data_prbs, k);
    [~, ~, x_test_mix, y_test_mix] = train_test_split(modify_data_mix, k);

    err_ratio_mod = [];

    for nn_mod = 1:9
        fprintf('\t NN_MOD = %d\n', nn_mod);

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
        hidden_n = mem_n - 5;
        net = newff(real(x_train), real(y_train), hidden_n, {'tansig' 'tansig'}, 'trainrp');
        % net = fitnet(25);
        net.trainParam.show = 10; %显示训练迭代过程，每10周期
        net.trainParam.epochs = 300;
        net.trainParam.goal = 0.0001;
        net.trainParam.lr = 0.01;
        net.trainParam.showWindow = false;

        % 训练网络
        [net1, ~] = train(net, real(x_train), real(y_train));
        [net2, ~] = train(net, imag(x_train), imag(y_train));
        % NN均衡
        sim_real = sim(net1, real(x_test));
        sim_imag = sim(net2, imag(x_test));

        % NN误码率计算
        sim_data = sim_real + sim_imag * 1i;
        Tx_seq_nn = qamdemod(y_test.',Ms,'bin','UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
        Rx_seq_nn = qamdemod(sim_data.',Ms,'bin','UnitAveragePower',true); % QAM解调
        
        Tx_seq = qamdemod(y_test.',Ms,'bin','UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
        Rx_seq = qamdemod(x_test(1,:).',Ms,'bin','UnitAveragePower',true); % QAM解调

        [~, ratio_nn] = symerr(Tx_seq_nn, Rx_seq_nn);
        [~, ratio] = symerr(Tx_seq, Rx_seq);
        err_ratio_mod = [err_ratio_mod; ratio];
    end

    % 取训练20次后误码率截尾平均值
    err_ratio_times = [err_ratio_times, err_ratio_mod];
end

err_ratio_all = [err_ratio_all, trimmean(err_ratio_times, 20, 2)];

%% 画图1
close all;
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 0:SNR_num;
plot(x, err_ratio_all(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(2, :), '-+', 'color', color1 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(4, :), '-x', 'color', color2 / 255, 'linewidth', 2); hold on;
plot(x, err_ratio_all(5, :), '-s', 'color', color2 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'mt-prbs', 'prbs-mt', 'prbs-prbs', 'Location', 'Northeast')
xlabel('SNR');
ylabel('BER');

err_ratio_db = 10 * log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db(1, :), '-o', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(2, :), '-+', 'color', color1 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(4, :), '-x', 'color', color2 / 255, 'linewidth', 2); hold on;
semilogy(x, err_ratio_db(5, :), '-s', 'color', color2 / 255, 'linewidth', 2); hold on;
legend('mt-mt', 'mt-prbs', 'prbs-mt', 'prbs-prbs', 'Location', 'Northeast')
xlabel('SNR');
ylabel('BER(dB)');

%% 画图2
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 0:SNR_num;
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
xlabel('SNR(dB)');
ylabel('BER(dB)');

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
xlabel('SNR(dB)');
ylabel('BER(dB)');
