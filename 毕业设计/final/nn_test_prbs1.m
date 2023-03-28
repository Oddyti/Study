%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 2^15;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt = randi([0 1],L,1);     % 梅森扭转
tx_seq_prbs = prbs(5, L)';
tx_seq_audio = importdata('tx_bit_audio.mat');

err_ratio_all = zeros(4,13); % 记录每种模式不同SNR的误码率
for SNR = 0:12
    fprintf('SNR = %d\n',SNR);
    % 信号传输
    [sig_qam_mt,sig_sam_mt] = channel(tx_seq_mt,SNR);
    [sig_qam_prbs,sig_sam_prbs] = channel(tx_seq_prbs,SNR);
    [sig_qam_audio,sig_sam_audio] = channel(tx_seq_audio,SNR);
    % 数据集拼接
    mem_n = 22; % 记忆深度
    modify_data_mt = modify_data(sig_sam_mt, sig_qam_mt, mem_n);
    modify_data_prbs = modify_data(sig_sam_prbs, sig_qam_prbs, mem_n);
    modify_data_audio = modify_data(sig_sam_audio, sig_qam_audio, mem_n);
    % 划分数据集，训练集（k）与测试集占比
    k = 0.8;
    [x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
    [x_train_prbs, y_train_prbs, x_test_prbs, y_test_prbs] = train_test_split(modify_data_prbs, k);
    [x_train_audio, y_train_audio, x_test_audio, y_test_audio] = train_test_split(modify_data_audio, k);

    for nn_mod = 1:4
        fprintf('\t nn_mod = %d\n',nn_mod);
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
            case 3  % Train: prbs, Test: mt
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test  = x_test_mt;
                y_test  = y_test_mt;
            case 4  % Train: prbs, Test: prbs
                x_train = x_train_prbs;
                y_train = y_train_prbs;
                x_test  = x_test_prbs;
                y_test  = y_test_prbs;
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
        err_ratio_nn_temp = [];
        for i = 1:20
            fprintf('\t \t train times = %d\n',i);
            % 训练网络
            [net,tr]=train(net,real(x_train), real(y_train));

            % NN均衡 
            sim_real = sim(net, real(x_test));
            sim_imag = sim(net, imag(x_test));

            % NN误码率计算
            sim_data = sim_real + sim_imag*1i;
            data_eq = judge(sim_data);
            rx_nn = qamdemod(data_eq', Ms,'bin','OutputType','bit');
            tx_test = qamdemod(y_test', Ms,'bin','OutputType','bit');
            [~, ratio] = symerr(tx_test, rx_nn);
            err_ratio_nn_temp = [err_ratio_nn_temp, ratio];
        end
        % 取训练20次后误码率截尾平均值
        err_ratio_all(nn_mod,SNR+1) = trimmean(err_ratio_nn_temp,40);
    end
end
%% 画图
color1 = [142 207 201];
color2 = [255 190 122];
color3 = [250 127 111];
color4 = [130 176 210];
figure(1);
x = 0:12;
plot(x, err_ratio_all(1,:),'-o','color',color1/255,'linewidth',2);hold on;
plot(x, err_ratio_all(2,:),'-+','color',color2/255,'linewidth',2);hold on;
plot(x, err_ratio_all(3,:),'-*','color',color3/255,'linewidth',2);hold on;
plot(x, err_ratio_all(4,:),'-x','color',color4/255,'linewidth',2);hold on;
legend('mt-mt','mt-prbs','prbs-mt','prbs-prbs','Location','Northeast')
xlabel('SNR');
ylabel('误码率');

err_ratio_db = 10*log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db(1,:),'-o','color',color1/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(2,:),'-+','color',color2/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(3,:),'-*','color',color3/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(4,:),'-x','color',color4/255,'linewidth',2);hold on;
legend('mt-mt','mt-prbs','prbs-mt','prbs-prbs','Location','Northeast')
xlabel('SNR');
ylabel('误码率dB');








