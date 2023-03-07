function [net, tr] = nn_train(data, lable)
    %% 网络设置
    [mem_n, ~] = size(data);
    hidden_n = mem_n - 4;
    net = newff(data, lable, hidden_n , {'logsig' 'purelin'} , 'traingdx' );
    net.trainParam.show = 10;   %显示训练迭代过程，每10周期
    net.trainParam.epochs = 1000;
    net.trainParam.goal = 0.0001;
    net.trainParam.lr = 0.01;
    
    %% 训练网络
    [net,tr]=train(net,data, lable);
end
