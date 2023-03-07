clc;
clear;
close all;
%% 设置参数 %%
L_Dseq = 100000;
Fb = 10e3;
Fs = 400e3;
fc = 100e3;
EbN0 = 12;

%%  生成码元序列、转换 %%
Ms = 16;
k = log2(Ms);
Dseq = randi([0 1],L_Dseq*k, 1);
%% 星座映射 %%
SigBase = qammod(Dseq, Ms,'bin','InputType','bit');
SigBaseI = real(SigBase);
SigBaseQ = imag(SigBase);

figure(1);
    subplot(1, 2, 1);
    plot(SigBaseI, SigBaseQ, '*');
    grid on;
    xlabel('实部');
    ylabel('虚部');
    title('发送端星座图');
    axis([-4 4 -4 4]);

%% 脉冲成形 %%
span = 20;
Nsam = Fs / Fb;
R = 0.5;
hsqrt = rcosdesign(R, span, Nsam, 'sqrt');
SigBaseInterpI = upsample(SigBaseI, Nsam);
SigBaseInterpQ = upsample(SigBaseQ, Nsam);
SigI = conv(SigBaseInterpI, hsqrt, 'same');
SigQ = conv(SigBaseInterpQ, hsqrt, 'same');
figure(2);
    subplot(421);
        plot(SigI(1:Nsam * 10));
        grid on;
        title('I基带信号形成波形');
    subplot(423);
        plot(SigQ(1:Nsam * 10));
        grid on;
        title('Q基带信号形成波形');
    subplot(422);
        pf1 = pwelch(SigI, [], [], []);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('I基带信号功率谱');
    subplot(424);
        pf1 = pwelch(SigQ, [], [], []);
        plot(10 * log10(pf1), '.-'); 
        grid on;
        title('Q基带信号功率谱');

%% 调制 %%
SigPassBandI = SigI .* cos(2 * pi * fc * (0:length(SigI) - 1) / Fs)';
SigPassBandQ = SigQ .* (-sin(2 * pi * fc * (0:length(SigQ) - 1) / Fs))';
SigPassBand = SigPassBandI + SigPassBandQ;
figure(3);
    subplot(421);
        plot(SigPassBandI(1:Nsam * 10));
        grid on;
        title('I带通信号波形');
    subplot(423);
        plot(SigPassBandQ(1:Nsam * 10));
        grid on;
        title('Q带通信号波形');
    subplot(422);
        pf1 = pwelch(SigPassBandI, [], [], []);
        plot(10 * log10(pf1), '.- ');
        grid on;
        title('I带通信号功率谱');
    subplot(424);
        pf1 = pwelch(SigPassBandQ, [], [], []);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('Q带通信号功率谱');
    subplot(425);
        plot(SigPassBand(1:Nsam * 10), '-');
        grid on;
        title('带通信号波形');
    subplot(426);
        pf1 = pwelch(SigPassBand, [], [], []);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('带通信号功率谱');

%% AWGN信道% %(I、Q信号相加之后加噪声)
Snr = EbN0 - 10 * log10(Nsam / 2) + 10 * log10(log2(Ms)); %比特信噪比换算
SigPassBand = awgn(SigPassBand, Snr, 'measured'); %加入高斯白噪声

subplot(427);
    plot(SigPassBand(1:Nsam * 10), '-');
    grid on;
    title('加噪带通信号波形');
subplot(428);
    pf1 = pwelch(SigPassBand, [], [], []);
    plot(10 * log10(pf1), '.-');
    grid on;
    title('加噪带通信号功率谱');

%% 解调〈下变频〉(乘以2的作用是使得解调后信号与原始基带信号幅度相同,即使得判决电平与映射电平相—致) %%
SigBaseDownI = 2 * SigPassBand .* cos(2 * pi * fc * (0:length(SigPassBand) - 1) / Fs)';
SigBaseDownQ = 2 * SigPassBand .* (-sin(2 * pi * fc * (0:length(SigPassBand) - 1) / Fs))';

%% 接收滤波〈匹配滤波〉%%(接收滤波器也是低通滤波器,所以代码中可以省去带通滤波器和解调器的低通滤波器)

SigBaseDownI = conv(SigBaseDownI', hsqrt, 'same'); %匹配滤波接收
SigBaseDownQ = conv(SigBaseDownQ', hsqrt, 'same');
figure(2)
    subplot(425);
        plot(SigBaseDownI(1:Nsam * 10), '-');
        grid on;
        title('I解调输出波形');
    subplot(426);
        pf1 = pwelch(SigBaseDownI, [], [], []);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('I解调输出信号功率谱');
    subplot(427);
        plot(SigBaseDownQ(1:Nsam * 10), '-');
        grid on;
        title('Q解调输出波形');
    %画出解调基带信号波形
    subplot(428);
        pf1 = pwelch(SigBaseDownQ, [], [], []);
        plot(10 * log10(pf1), '.-');
        grid on;
        title('Q解调输出信号功率谱');
        eyediagram(SigBaseDownI(1,1:1000), 1 * Nsam);
        title('I接收端眼图');
        %画出接收滤波后眼图(一个码元周期)
        eyediagram(SigBaseDownQ(1,1:1000), 1 * Nsam);
        title('Q接收端眼图');
        %画出接收滤波后眼图(一个码元周期)

%% 抽祥 %%
SigBaseEstI = downsample(SigBaseDownI, Nsam);
%最佳采样点抽样(下采样downsample)
SigBaseEstQ = downsample(SigBaseDownQ, Nsam);
%画出接收端星座图
figure(1);
    subplot(122);
        plot(SigBaseEstI, SigBaseEstQ, '*');
        grid on;
        xlabel('实部');
        ylabel('虚部');
        title('接收端星座图');
        axis([-5 5 -5 5]);
%% 判决 %%
SigBaseEst = SigBaseEstI + SigBaseEstQ * 1i; %复包络
Sig_dn = Dseq(1:end);
%发送符号序列
Sig_xn = SigBaseEst(1:end);
Sig_xn = qamdemod(Sig_xn, Ms, 'gray'); %判决，输出复包络的判决符号序列
%% 并串转换 误码率统计%%
[SymErrNum, Ser_est] = symerr(Sig_dn, Sig_xn); %误码率统计值
[BitErrNum, Ber_est] = biterr(Sig_dn, Sig_xn, log2(Ms)); %误信率统计值
[BER, SER] = berawgn(EbN0, 'qam', Ms); %由berawgn函数计算误码车理论值
