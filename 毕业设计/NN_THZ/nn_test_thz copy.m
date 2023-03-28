%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
M = 16;
coding = 'bin';
% 导入训练集
Tx_seq_mix = importdata('E_tx_mix.mat');
Rx_seq_mix = importdata('E_rx_mix.mat');
Tx_seq_mt = importdata('E_tx_mt.mat');
Rx_seq_mt = importdata('E_rx_mt.mat');
Tx_seq_prbs = importdata('E_tx_prbs.mat');
Rx_seq_prbs = importdata('E_rx_prbs.mat');

% 数据集拼接
mem_n = 30; % 记忆深度
modify_data_mt = modify_data(Rx_seq_mt.', Tx_seq_mt.', mem_n);
modify_data_prbs = modify_data(Rx_seq_prbs.', Tx_seq_prbs.', mem_n);
modify_data_mix = modify_data(Rx_seq_mix.', Tx_seq_mix.', mem_n);
% 划分数据集，训练集（k）与测试集占比
k = 0.8;
[x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
[x_train_prbs, y_train_prbs, x_test_prbs, y_test_prbs] = train_test_split(modify_data_prbs, k);
[x_train_mix, y_train_mix, x_test_mix, y_test_mix] = train_test_split(modify_data_mix, k);

err_ratio_all = zeros(4,9);

for nn_mod = 1:9
        fprintf('nn_mod = %d\n',nn_mod);
        switch nn_mod
            case 1  % Train: mt, Test: mt
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test  = x_test_mt;
                y_test  = y_test_mt;
            case 2  % Train: mt, Test: prbs
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test  = x_test_prbs;
                y_test  = y_test_prbs;
            case 3  % Train: mt, Test: mix
                x_train = x_train_mt;
                y_train = y_train_mt;
                x_test  = x_test_mix;
                y_test  = y_test_mix;
            case 4  % Train: prbs, Test: mt
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test  = x_test_mt;
                y_test  = y_test_mt;
            case 5  % Train: prbs, Test: prbs
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test  = x_test_prbs;
                y_test  = y_test_prbs;
            case 6  % Train: prbs, Test: mix
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test  = x_test_mix;
                y_test  = y_test_mix;
            case 7  % Train: mix, Test: mt
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test  = x_test_mt;
                y_test  = y_test_mt;
            case 8  % Train: mix, Test: prbs
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test  = x_test_prbs;
                y_test  = y_test_prbs;
            case 9  % Train: mix, Test: mix
                x_train = x_train_mix;
                y_train = y_train_mix;
                x_test  = x_test_mix;
                y_test  = y_test_mix;
        end

    % NN网络设置
    hidden_n = mem_n - 5;
    net = newff(real(x_train), real(y_train), hidden_n , {'tansig' 'tansig'} , 'traingdx' );
    net.trainParam.show = 10;   %显示训练迭代过程，每10周期
    net.trainParam.epochs = 300;
    net.trainParam.goal = 0.0001;
    net.trainParam.lr = 0.01;
    net.trainParam.showWindow = false;

    % 训练20次后取误码率截尾平均值
    err_num_temp = [];
    err_ratio_temp = [];
    for i = 1:20
        fprintf('train times = %d\n',i);
        % 训练网络
        [net,tr]=train(net,real(x_train), real(y_train));

        % NN均衡 
        sim_real = sim(net, real(x_test));
        sim_imag = sim(net, imag(x_test));

        % NN误码率计算
        sim_data = sim_real + sim_imag*1i;
        b = y_test.';
        a = sim_data.';
        test_seq = qamdemod(y_test.',M,coding,'UnitAveragePower',true); 
        sim_seq = qamdemod(sim_data.',M,coding,'UnitAveragePower',true); 
        test_bit = de2bi(test_seq','left-msb'); 
        sim_bit = de2bi(sim_seq','left-msb'); 
        
        [num, ratio] = symerr(test_bit, sim_bit);
        err_num_temp = [err_num_temp, num];
        err_ratio_temp = [err_ratio_temp, ratio];
    end
    % 取训练20次后误码率截尾平均值
    err_ratio_all(1,nn_mod) = trimmean(err_num_temp,40);
    err_ratio_all(2,nn_mod) = trimmean(err_ratio_temp,40);
    test_seq = qamdemod(y_test.',M,coding,'UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
    train_seq = qamdemod(x_test(1,:).',M,coding,'UnitAveragePower',true); % QAM解调
    test_bit = de2bi(test_seq','left-msb'); % 十进制转换为二进制
    train_bit = de2bi(train_seq','left-msb'); % 十进制转换为二进制
    [num, ratio] = symerr(test_bit, train_bit);
    err_ratio_all(3,nn_mod) = num;
    err_ratio_all(4,nn_mod) = ratio;
end





