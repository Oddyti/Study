%%%%%%%%%%%%%% 最终测试
clear;
clc;
close all;

L = 10000;
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt = randi([0 1],L*k,1);     % 梅森扭转
tx_seq_prbs = prbs(5, L*k)';

err_ratio_all = zeros(1,9); % 记录每种模式不同SNR的误码率
for SNR = 0:8
    fprintf('SNR = %d\n',SNR);
    % 信号传输
    [sig_qam,sig_sam] = channel(tx_seq_prbs,SNR);
    % 数据集拼接
    mem_n = 30; % 记忆深度
    data_modify = modify_data(sig_sam, sig_qam, mem_n);
    
    err_ratio_nn_temp = [];
    for i = 1:16
        % 划分数据集，训练集（k）与测试集占比
        k = 0.8;
        [x_train, y_train, x_test, y_test] = train_test_split(data_modify, k);

    	a = x_train(1,:).';
        a = [a,y_train.'];
        
        % NN网络设置
        hidden_n = mem_n - 5;
        % net = newff(real(x_train), real(y_train), hidden_n , {'tansig' 'tansig'} , 'traingdx' );
        net = fitnet(25);
        net.trainParam.show = 10;   %显示训练迭代过程，每10周期
        net.trainParam.epochs = 300;
        net.trainParam.goal = 0.0001;
        net.trainParam.lr = 0.01;
        net.trainParam.showWindow = true;

        % 训练20次后取误码率截尾平均值

        fprintf('\t \t train times = %d\n',i);
        % 训练网络
        [net,tr]=train(net,real(x_train), real(y_train));

        % NN均衡 
        sim_real = sim(net, real(x_test));
        sim_imag = sim(net, imag(x_test));

        % NN误码率计算
        sim_data = sim_real + sim_imag*1i;
        data_eq = judge(sim_data);
        b = data_eq.';
        b = [b, y_test.'];
        rx_nn = qamdemod(data_eq.', Ms,'bin','OutputType','bit');
        tx_test = qamdemod(y_test.', Ms,'bin','OutputType','bit');
        [~, ratio] = symerr(tx_test, rx_nn);
        err_ratio_nn_temp = [err_ratio_nn_temp, ratio];
    end
    % 取训练20次后误码率截尾平均值
    err_ratio_all(1,SNR+1) = trimmean(err_ratio_nn_temp,40);
end
%% 画图
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 1:9;
plot(x, err_ratio_all,'-o','color',color1/255,'linewidth',2);hold on;
legend('mt-mt','Location','Northeast')
xlabel('SNR');
ylabel('误码率');

err_ratio_db = 10*log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db,'-o','color',color1/255,'linewidth',2);hold on;
legend('mt-mt','Location','Northeast')
xlabel('SNR');
ylabel('误码率dB');








