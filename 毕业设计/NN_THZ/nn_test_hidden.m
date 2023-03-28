%%%%%%%%%%%%%% 测试不同隐藏层的节点数
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
M = 16;
coding = 'bin';

Tx_seq_mt = importdata('E_tx_mt.mat');
Rx_seq_mt = importdata('E_rx_mt.mat');

err_nn_ratio = [];
err_ratio = [];
x = [];
%% 测试网络参数
% 训练20次，取平均误差
for temp = 1:1:20
    % fprintf('hidden = %d\n',temp);
    err_num_temp = [];
    err_ratio_temp = [];
    
    % 数据集拼接
    mem_n = 20;
    train_data_mt = modify_data(Rx_seq_mt.', Tx_seq_mt.', mem_n);
    % 划分数据集
        % 训练集（k）与测试集占比
        k = 0.8;
        [x_train, y_train, x_test, y_test] = train_test_split(train_data_mt, k);
    % 训练集归一化
    if norm_flag == 1
        [x_train, ~]= data_norm(x_train);
        [y_train, ~]= data_norm(y_train);
    end
    % 网络设置
    hidden_n = mem_n - 10 + temp;
    fprintf('hidden = %d\n',hidden_n);
    net = newff(real(x_train), real(y_train), hidden_n , {'tansig' 'tansig'} , 'traingdx' );
    net.trainParam.show = 10;   %显示训练迭代过程，每10周期
    net.trainParam.epochs = 300;
    net.trainParam.goal = 0.0001;
    net.trainParam.lr = 0.01;
    net.trainParam.showWindow = false;

    for num = 1:20
        fprintf('train times = %d\n',num);
        % 训练网络
        [net,tr]=train(net,real(x_train), real(y_train));
        % 测试集归一化
        x_test_temp = x_test;
        y_test_temp = y_test;
        if norm_flag == 1
            [x_test, ~]= data_norm(x_test);
            [y_test, test_norm_info]= data_norm(y_test);
        end
        % NN均衡 
        sim_real = sim(net, real(x_test));
        sim_imag = sim(net, imag(x_test));
        % 反归一化
        if norm_flag == 1
            sim_real = sim_real * test_norm_info(2)+test_norm_info(1);
            sim_imag = sim_imag * test_norm_info(4)+test_norm_info(3);
        end
        % 计算误码率
        sim_data = sim_real + sim_imag*1i;

        b = y_test.';
        a = sim_data.';
        test_seq = qamdemod(y_test.',M,coding,'UnitAveragePower',true); 
        sim_seq = qamdemod(sim_data.',M,coding,'UnitAveragePower',true); 
        test_bit = de2bi(test_seq','left-msb'); 
        sim_bit = de2bi(sim_seq','left-msb'); 

        [~, ratio] = symerr(test_bit, sim_bit);
        err_ratio_temp = [err_ratio_temp, ratio];

    end
    % 取训练20次后误码率截尾平均值
    err_nn_ratio = [err_nn_ratio,trimmean(err_ratio_temp,40)];

    test_seq = qamdemod(y_test.',M,coding,'UnitAveragePower',true);
    train_seq = qamdemod(x_test(1,:).',M,coding,'UnitAveragePower',true);
    test_bit = de2bi(test_seq','left-msb');
    train_bit = de2bi(train_seq','left-msb');
    [~, ratio] = symerr(test_bit, train_bit);
    err_ratio= [err_ratio, ratio];
    x = [x, hidden_n];
end
%% 画图
figure(1);
plot(x, err_ratio, 'b','linewidth',2);
hold on;
plot(x, err_nn_ratio, 'r', 'linewidth',2);
legend('无nn误码率','nn均衡后误码率','Location','Northeast');
xlabel('输出长度');
ylabel('误码率');
title('不同输入长度误码率');
