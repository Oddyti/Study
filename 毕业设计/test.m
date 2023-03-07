clc;
clear;
L = 10000;

Ms = 16;
k = log2(Ms);
txSeq = randi([0 1],L*k,1);
Y = qammod(txSeq, Ms,'bin','InputType','bit');
Snr = 12;
X = awgn(Y, Snr, 'measured');
dataX = real(X);
dataY = real(Y);


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

%% 网络设置
net = newff(XTrain', YTrain', [18 1] , { 'logsig' 'purelin' } , 'traingdx' );
net.trainParam.show = 50;   %显示训练迭代过程，每10周期
net.trainParam.epochs = 10000;
net.trainParam.goal = 0.0001;
net.trainParam.lr = 0.01;
[net,tr]=train(net,XTrain', YTrain');
plotperform(tr)

data_sim = sim(net, XTest');




