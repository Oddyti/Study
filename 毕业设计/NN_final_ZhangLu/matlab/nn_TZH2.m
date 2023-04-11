%%%%%%%%%%%%%% 这个版本是进行测试的快速版本
%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 10000;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt_train = importdata('E_tx_mt2.mat');

rx_seq_mt_train = importdata('E_rx_mt2.mat');


%% 数据处理（根据记忆深度补零）
mem_n = 30; % 记忆深度

% 数据拼接
modify_data_mt_train = modify_data(rx_seq_mt_train, tx_seq_mt_train, mem_n);
% 划分数据集，训练集（k）与测试集占比

%% NN

k = 0.6;
[x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt_train, k);


x_train = x_train_mt;
y_train = y_train_mt;
x_test = x_test_mt;
y_test = y_test_mt;

% NN网络设置
hidden_n = mem_n - 5;
% net = newff(real(x_train), real(y_train), hidden_n, {'tansig' 'tansig'}, 'trainrp');
net = fitnet(25);
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

Tx_seq_nn = qamdemod(y_test.', Ms, 'bin', 'UnitAveragePower', true); % QAM解调 %,'UnitAveragePower', true
Rx_seq_nn = qamdemod(sim_data.', Ms, 'bin', 'UnitAveragePower', true); % QAM解调

Tx_seq = qamdemod(y_test.', Ms, 'bin', 'UnitAveragePower', true); % QAM解调 %,'UnitAveragePower', true
Rx_seq = qamdemod(x_test(1, :).', Ms, 'bin', 'UnitAveragePower', true); % QAM解调

[~, ratio_nn] = symerr(Tx_seq_nn, Rx_seq_nn);
[~, ratio] = symerr(Tx_seq, Rx_seq);
