clear;clc;echo off;close all;
%% -------------训练神经网络均衡器-------------------------------
N=1000;                             %指定信号序列长度
info=randsrc(1,N,[-1 1;.5 .5]);      %产生二进制信号序列
SNR_in_dB = 3;

for j=1:length(SNR_in_dB)
    y=channel(info,SNR_in_dB(j));        %通过信道
    NNLen=30;
    N=length(info);
    P=[];
    for i=1:(N-NNLen)
        P=[P y(i:i+NNLen-1)'];
        T(i)=info(i);
    end
    net=newff(minmax(P),[10,1],{'tansig','tansig','purelin'},'trainlm');
    net.trainParam.show = 10;
    net.trainParam.epochs=100;%迭代次数
    net.trainParam.goal=0.0001;
    net.trainParam.lr=0.01;%学习率
    [net,tr]=train(net,P,T);
    plotperform(tr)
end

%% -------------训练完成，开始均衡-------------------------------
SNR_in_dB=8:1:18; 

N=10000;                             %指定信号序列长度
for j=1:length(SNR_in_dB)
    %----- 抽头延迟线，准备进入均衡的数据--------
    info=randsrc(1,N,[-1 1;.5 .5]);      %产生二进制信号序列
    y=channel(info,SNR_in_dB(j));        %通过信道
    N=length(info);
    P=[];
    for i=1:(N-NNLen)
        P=[P y(i:i+NNLen-1)'];
    end
    
    
    a=sim(net,P);   %----- 神经网络均衡 ----------
    
    %----- 神经网络误码率--------
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
    Pe1_NN(j)=numoferr_NN/N;                   % 经自适应均衡器均衡后，得到的误码率

    %----- 无均衡的误码率--------
    numoferr = 0;                       %初始误码统计数
    for i=1:N                  %从第len个码元开始为真实信号码元
        if (y(i)<0),                    %判决译码
            decis=-1;
        else
            decis=1;
        end;
        if (decis~=info(i)),             %判断是否误码，统计误码码元个数
            numoferr=numoferr+1;
        end;
    end;
    Pe(j)=numoferr/N;                   % 未经均衡器均衡，得到的误码率
end

%% --------------------------------------------
figure
semilogy(SNR_in_dB,Pe1_NN, '--+');        %自适应均衡器均衡之后，误码率结果图
hold on;
semilogy(SNR_in_dB,Pe,'blue--d');           %未经均衡器，误码率结果图
hold on;

xlabel('SNR in dB');
ylabel('Pe');
legend('经自适应均衡器均衡','未经均衡器均衡');