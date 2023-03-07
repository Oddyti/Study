clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 10000;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
% tx_seq_mt = randi([0 1],L*k,1);     % 梅森扭转
load tx_seq_mt;
%% 信道传输
[sig_qam_mt,sig_sam_mt] = channel(tx_seq_mt,2);

%% 数据集拼接
mem_n = 20;
train_data_mt = modify_data(sig_sam_mt, sig_qam_mt, mem_n);

%% 划分数据集
% 训练集（k）与测试集占比
k = 0.8;
[x_train, y_train, x_test, y_test] = train_test_split(train_data_mt, k);

%% 训练集归一化
if norm_flag == 1
    [x_train, ~]= data_norm(x_train);
    [y_train, ~]= data_norm(y_train);
end
%% 训练NN
[net,tr] = nn_train(real(x_train), real(y_train));

%% 测试集归一化
x_test_temp = x_test;
y_test_temp = y_test;
if norm_flag == 1
    [x_test, ~]= data_norm(x_test);
    [y_test, test_norm_info]= data_norm(y_test);
end
%% NN均衡 
sim_real = sim(net, real(x_test));
sim_imag = sim(net, imag(x_test));
% 反归一化
if norm_flag == 1
    sim_real = sim_real * test_norm_info(2)+test_norm_info(1);
    sim_imag = sim_imag * test_norm_info(4)+test_norm_info(3);
end
sim_data = sim_real + sim_imag*1i;
data_eq = judge(sim_data);
rx_nn = qamdemod(data_eq', Ms,'bin','OutputType','bit');
tx_test = qamdemod(y_test_temp', Ms,'bin','OutputType','bit');
[ErrNum_nn, ErrRatio_nn] = symerr(tx_test, rx_nn);
%% 判决
data_noeq = judge(x_test_temp);
rx = qamdemod(data_noeq', Ms,'bin','OutputType','bit');
[ErrNum, ErrRatio] = symerr(tx_test, rx);
