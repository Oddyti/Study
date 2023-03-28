%% 训练
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
M = 16;
coding = 'bin';

Tx_seq_mt = importdata('E_tx_mt_train.mat');
Rx_seq_mt = importdata('E_rx_mt_train.mat');


% 数据集拼接
mem_n = 22;
train_data_mt = modify_data(Rx_seq_mt.', Tx_seq_mt.', mem_n);

input_data = real(train_data_mt(1:22,:));
target_data = real(train_data_mt(23,:));

nftool;
%%  划分数据集
Y_seq_mt = importdata('E_tx_mt.mat').';
X_seq_mt = importdata('E_rx_mt.mat').';

train_data_mt = modify_data(X_seq_mt, Y_seq_mt, mem_n);

X_seq_mt_new = real(train_data_mt(1:22,:));
% NN均衡 
sim_real = sim(net, real(X_seq_mt_new));
sim_imag = sim(net, imag(X_seq_mt_new));
      
% 计算误码率
sim_data = sim_real + sim_imag*1i;

test_seq = qamdemod(Y_seq_mt,M,coding,'UnitAveragePower',true); 
sim_seq = qamdemod(sim_data,M,coding,'UnitAveragePower',true); 
test_bit = de2bi(test_seq','left-msb'); 
sim_bit = de2bi(sim_seq','left-msb'); 

[~, ratio_nn] = symerr(test_bit, sim_bit);

test_seq = qamdemod(Y_seq_mt,M,coding,'UnitAveragePower',true);
train_seq = qamdemod(X_seq_mt,M,coding,'UnitAveragePower',true);
test_bit = de2bi(test_seq','left-msb');
train_bit = de2bi(train_seq','left-msb');
[~, ratio] = symerr(test_bit, train_bit);
