%%%%%%%%%% 测试不同激活函数
clear;
clc;
close all;
norm_flag = 0; % 是否归一化
L = 10000;
% 激活函数集
ac_fun = ["logsig","logsig";"logsig","tansig";"logsig","purelin";
          "tansig","logsig";"tansig","tansig";"tansig","purelin";
          "purelin","logsig";"purelin","tansig";"logsig","purelin"];
%% 生成码元序列
Ms = 16;
k = log2(Ms);
tx_seq_mt = randi([0 1],L*k,1);     % 梅森扭转
% load tx_seq_mt;
%% 信道传输
[sig_qam_mt,sig_sam_mt] = channel(tx_seq_mt,2);

err_ratio = [];
err_ratio_nn = [];
x = [];
%% 测试网络参数
% 训练10次，取平均误差
for temp = 1:9
    err_ratio_temp = [];
    err_ratio_nn_temp = [];
    for num = 1:20
        % 数据集拼接
            mem_n = 20;
            train_data_mt = modify_data(sig_sam_mt, sig_qam_mt, mem_n);
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
            hidden_n = mem_n - 5;
            net = newff(real(x_train), real(y_train), hidden_n , {char(ac_fun(temp,1)), char(ac_fun(temp,2))} , 'traingdx' );
            net.trainParam.show = 10;   %显示训练迭代过程，每10周期
            net.trainParam.epochs = 300;
            net.trainParam.goal = 0.0001;
            net.trainParam.lr = 0.01;
            net.trainParam.showWindow = false;

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
            data_eq = judge(sim_data);
            rx_nn = qamdemod(data_eq', Ms,'bin','OutputType','bit');
            tx_test = qamdemod(y_test_temp', Ms,'bin','OutputType','bit');
            [~, ratio] = symerr(tx_test, rx_nn);
            err_ratio_nn_temp = [err_ratio_nn_temp, ratio];
            %% 判决
            data_noeq = judge(x_test_temp);
            rx = qamdemod(data_noeq', Ms,'bin','OutputType','bit');
            [~, ratio_1] = symerr(tx_test, rx);
            err_ratio_temp = [err_ratio_temp, ratio_1];
    end
    % 取训练20次后误码率截尾平均值
    err_ratio = [err_ratio,trimmean(err_ratio_temp,40)];
    err_ratio_nn = [err_ratio_nn,trimmean(err_ratio_nn_temp,40)];
end
%% 画图
figure(1);
x = 1:9;
plot(x,err_ratio,'-o','MarkerIndices',1:1:length(err_ratio),'LineWidth',2,'MarkerEdgeColor','b','MarkerFaceColor','b')
hold on;
plot(x,err_ratio_nn,'-*','MarkerIndices',1:1:length(err_ratio_nn),'LineWidth',2,'MarkerEdgeColor','r','MarkerFaceColor','r')
legend('无nn误码率','nn均衡后误码率','Location','Northeast');
xlabel('激活函数组合');
ylabel('误码率');
title('不同激活函数误码率');
