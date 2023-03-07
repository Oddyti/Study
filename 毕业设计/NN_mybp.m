function dataY = NN(dataX, dataY)
    L = length(dataX);
    MemN = 20;
    datai = zeros(L + MemN-1,1); %#ok<PREALL>
    datai = [dataX; dataX(1:MemN-1)];
    datanew =[];
    for i = 1:L
        datanew =[datanew, datai(i:i+MemN-1)];
    end
    data = [datanew', dataY];
    size(data);
    %% 划分训练集与测试集
    k = 0.8;     % 训练集（k）与测试集占比
    idx = randperm(length(data));
    XTrain= data(idx(1:floor(L*k)),1:MemN);
    YTrain= data(idx(1:floor(L*k)),MemN+1);
    XTest= data(idx(floor(L*k)+1:end),1:MemN);
    YTest= data(idx(floor(L*k)+1:end),MemN+1);
    
    %% 网络参数
    HidN = 18;
    Vij = 2*rand(HidN, MemN)-1;     % 输入层到隐藏层权重
    ThetaH = 2*rand(HidN,1)-1;      % 输入层到隐藏层阈值
    Wj = 2*rand(1, HidN)-1;         % 隐藏层到输出层权重
    ThetaY = 2*rand(1, 1)-1;        % 隐藏层到输出层阈值
    LearnRate = 0.0001;
    MaxEpochs = 50000;
    ErrorRate = 0.1;

    %% 训练网络
    Epoch = 0;
    while Epoch < MaxEpochs
        Epoch = Epoch + 1;
        


end
