% 测试最佳NN参数
load SigQam.mat;
load SigSam.mat;
dataX = real(SigSam);
dataY = real(SigQam);

L = length(dataX);
MemN = 20;
datai = zeros(1,L + MemN-1); %#ok<PREALL>
datai = [dataX,dataX(1:MemN-1)];
datanew =[];
for i = 1:L
    datanew =[datanew,datai(i:i+MemN-1)'];
end
data = [datanew;dataY];
size(data);
%% 划分训练集与测试集
k = 0.8;     % 训练集（k）与测试集占比
idx = randperm(length(data));
XTrain= data(1:MemN,idx(1:floor(L*k)));
YTrain= data(MemN+1,idx(1:floor(L*k)));
XTest= data(1:MemN,idx(floor(L*k)+1:end));
YTest= data(MemN+1,idx(floor(L*k)+1:end));

%% 网络设置
net = newff(XTrain, YTrain, [16] , {'logsig' 'purelin'} , 'traingdx' );
net.trainParam.show = 10;   %显示训练迭代过程，每10周期
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.0001;
net.trainParam.lr = 0.01;

%% 训练网络
[net,tr]=train(net,XTrain, YTrain);
plotperform(tr);

%% 测试
data_sim = sim(net, XTest);
numoferr_NN=0;           %错误的码元个数
for i=1:length(a),
    if (a(i)<0),
        decis=-1;
    else
        decis=1;
    end;
    if (decis~=info(i)),
        numoferr_NN=numoferr_NN+1;
    end;
end;
