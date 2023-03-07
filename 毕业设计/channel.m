clc;
clear;
close all;
%% 参数设置
Seq_L = 10000;
Fb = 10e3;
Fs = 400e3;
fc = 100e3;

%% 生成码元序列
Ms = 16;
k = log2(Ms);
txSeq = randi([0 1],Seq_L*k,1);

%% 串并转换
SigQam = qammod(txSeq, Ms,'bin','InputType','bit');
SigQamI = real(SigQam);
SigQamQ = imag(SigQam);

%% 脉冲成形
R = 0.5;            % 滚降系数
span = 20;          % 滤波器包含符号数
sps = 40;            % 每个符号所含采样点数
Filter = rcosdesign(R,span,sps,'sqrt');
SigInterpI = upsample(SigQamI, sps);
SigInterpQ = upsample(SigQamQ, sps);
modSigI = conv(SigInterpI, Filter, 'same');
modSigQ = conv(SigInterpQ, Filter, 'same');

%% 调制
txSigI = modSigI .* cos(2 * pi * fc * (0:length(modSigI) - 1) / Fs)';
txSigQ = modSigQ .* (-sin(2 * pi * fc * (0:length(modSigQ) - 1) / Fs))';
txSig = txSigI + txSigQ;

%% AWGN信道传输
% EbNo = 8;
% Snr = EbNo + 10*log10(k) - 10*log10(sps);
Snr = 2;
rxSig = awgn(txSig, Snr, 'measured');

%% 解调
demodSeqI = 2 * rxSig .* cos(2 * pi * fc * (0:length(rxSig) - 1) / Fs)';
demodSeqQ = 2 * rxSig .* (-sin(2 * pi * fc * (0:length(rxSig) - 1) / Fs))';

%% 匹配滤波
SigI = conv(demodSeqI', Filter, 'same');
SigQ = conv(demodSeqQ', Filter, 'same');

%% 抽样
SigSamI = downsample(SigI, sps);
SigSamQ = downsample(SigQ, sps);
SigSam = SigSamI + SigSamQ*1i;

SigQam = SigQam';
save SigSam.mat SigSam;
save SigQam.mat SigQam;
%% NN均衡
% SigEq = NN(SigSam', SigQam);

%% 判决
SigSam = SigSamI + SigSamQ*1i;
SigJudge = zeros(numel(SigSam),1);
Constellation =[3+3j 3+1j 1+3j 1+1j 3-3j 3-1j 1-3j 1-1j -3+3j -3+1j -1+3j -1+1j -3-3j -3-1j -1-3j -1-1j];
for i = 1:length(SigSam)
    [~,j]=min(abs(Constellation - SigSam(i)));
        SigJudge(i) = Constellation(j); 
end
rxSeq = qamdemod(SigJudge, Ms,'bin','OutputType','bit');

%% 误码率
[ErrNum, ErrRatio] = symerr(txSeq, rxSeq);   % 误符号率

%% 绘图
figure(1);
    subplot(121);
        plot(SigQamI, SigQamQ, '*');
        grid on;
        xlabel('实部');
        ylabel('虚部');
        title('发送端星座图');
        axis([-4,4,-4,4]);
    subplot(122);
        plot(SigSamI, SigSamQ, '*');
        grid on;
        xlabel('实部');
        ylabel('虚部');
        title('接收端星座图');
        axis([-5 5 -5 5]);

figure(2);
    subplot(421);
        plot(modSigI(1:sps * 10));
        grid on;
        title('I基带信号波形');
    subplot(423);
        plot(modSigQ(1:sps * 10));
        grid on;
        title('Q基带信号波形');
    subplot(422);
        pf1 = pwelch(modSigI);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('I基带信号功率谱');
    subplot(424);
        pf1 = pwelch(modSigQ);
        plot(10 * log10(pf1), '.-'); 
        grid on;
        title('Q基带信号功率谱');
    subplot(425);
        plot(SigI(1:sps * 10), '-');
        grid on;
        title('I解调输出波形');
    subplot(426);
        pf1 = pwelch(SigI);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('I解调输出信号功率谱');
    subplot(427);
        plot(SigQ(1:sps * 10), '-');
        grid on;
        title('Q解调输出波形');
    subplot(428);
        pf1 = pwelch(SigQ);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('Q解调输出信号功率谱');
eyediagram(SigI(1:length(SigI)/40), 1 * sps);
    title('I接收端眼图');
eyediagram(SigQ(1:length(SigQ)/40), 1 * sps);
    title('Q接收端眼图');