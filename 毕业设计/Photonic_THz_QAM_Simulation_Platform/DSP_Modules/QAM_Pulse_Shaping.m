function tx_waveform_awg = QAM_Pulse_Shaping(tx_sig,Nss,PulseShaping,txrolloff,Nsym,Fs_awg,Fs,draw)
%> @QAM脉冲成型函数

%> @tx_sig,生成的QAM信号
%> @Nss,QAM信号的原始采样频率下的过采样率
%> @PulseShaping,'No_Shaping'|'Rcos' |'RRC'脉冲成型的方法
%> @txrolloff,脉冲成型的滚降系数，取值0~1之间，决定频宽和陡峭程度
%> @Nsym,脉冲成型截断的符号范围
%> @Fs_awg,AWG仪器的采样率
%> @Fs,QAM信号的原始采样频率

%> @tx_waveform_awg, AWG输出波形

% uiwait(msgbox('进入发送端DSP(QAM脉冲成型)','提示','help'));
close all;scnsize = get(0,'ScreenSize');
fprintf(1,[' #   QAM脉冲成型计算中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

tx_up = upsample(tx_sig,Nss); % 上采样（作图用）
tx_wfm = filter(ones(Nss,1),1,tx_up); % 滤波（作图用）
switch PulseShaping
    case 'No_Shaping' % 直接按照矩形窗成型
        tx_up = upsample(tx_sig,Nss); % 上采样
        tx_wfm = filter(ones(Nss,1),1,tx_up); % 滤波
        tx_wfm_Nf = tx_wfm;
    case 'Rcos' % 按照升余弦滤波成型，最为常用
        Hd = rcosdesign(txrolloff,Nsym,Nss,'normal'); % 滤波器设计
        tx_wfm_Nf = upfirdn(tx_sig, Hd, Nss); % 上采样
        tx_wfm_Nf = circshift(tx_wfm_Nf,-(Nsym*Nss)/2); % 循环移位，确保对齐
        tx_wfm_Nf = tx_wfm_Nf(1:end-(Nsym*Nss-Nss+1));  % 去除无效数据
    case 'RRC' % 按照均方根升余弦滤波成型，最为常用
        Hd = rcosdesign(txrolloff,Nsym,Nss,'sqrt'); % 滤波器设计
        tx_wfm_Nf = upfirdn(tx_sig, Hd, Nss); % 上采样
        tx_wfm_Nf = circshift(tx_wfm_Nf,-(Nsym*Nss)/2); % 循环移位，确保对齐
        tx_wfm_Nf = tx_wfm_Nf(1:end-(Nsym*Nss-Nss+1));  % 去除无效数据
end
if Fs ~= Fs_awg % 重采样至AWG的采样率
    tx_waveform_awg = resample(tx_wfm_Nf,Fs_awg,Fs); % 重采样至AWG的采样率
else
    tx_waveform_awg = tx_wfm_Nf;
end
if draw
    figure;
    % 时域符号作图
    subplot(3,2,1);
    plot(real(tx_wfm(1:300)),'LineWidth',1);
    title('无脉冲成型(300个样品点)','FontSize',12);
    xlabel('时域点');
    ylabel('幅度');
    
    subplot(3,2,3);
    plot(real(tx_wfm_Nf(1:300)),'r','LineWidth',1);
    title('脉冲成型(300个样品点)','FontSize',12);
    xlabel('时域点');
    ylabel('幅度');
    
    subplot(3,2,5);
    plot(real(tx_waveform_awg(1:300)),'m','LineWidth',1);
    title('脉冲成型+重采样(300个样品点)(AWG)','FontSize',12);
    xlabel('时域点');
    ylabel('幅度');
    
    % 频谱作图
    data1 = double(tx_wfm);
    data2 = double(tx_wfm_Nf);
    data3 = double(tx_waveform_awg);
    
    Ex_spec1 = data1;
    Npoints1 = length(Ex_spec1);
    FFT_Ex_1 = fftshift(fft(Ex_spec1));
    FFT_Ex1 = abs(FFT_Ex_1)./(length(Ex_spec1));
    Frek1 = (Fs*(-(Npoints1)/2:((Npoints1/2)-1)))/Npoints1;
    
    Ex_spec2 = data2;
    Npoints2 = length(Ex_spec2);
    FFT_Ex_2 = fftshift(fft(Ex_spec2));
    FFT_Ex2 = abs(FFT_Ex_2)./(length(Ex_spec2));
    Frek2 = (Fs*(-(Npoints2)/2:((Npoints2/2)-1)))/Npoints2;
    
    Ex_spec3 = data3;
    Npoints3 = length(Ex_spec3);
    FFT_Ex_3 = fftshift(fft(Ex_spec3));
    FFT_Ex3 = abs(FFT_Ex_3)./(length(Ex_spec3));
    Frek3 = (Fs_awg*(-(Npoints3)/2:((Npoints3/2)-1)))/Npoints3;
    
    subplot(3,2,2);
    plot(Frek1./1e9,10*log10(FFT_Ex1.^2),'.');
    xlabel('频率（GHz)');
    ylim([-150,0]);
    title('无脉冲成型','FontSize',12);
    
    subplot(3,2,4);
    plot(Frek2./1e9,10*log10(FFT_Ex2.^2),'r');
    xlabel('频率（GHz)');
    ylim([-150,0]);
    title('脉冲成型','FontSize',12);
    
    subplot(3,2,6);
    plot(Frek3./1e9,10*log10(FFT_Ex3.^2),'m');
    xlabel('频率（GHz)');
    ylim([-150,0]);
    title('脉冲成型+重采样(AWG)','FontSize',12);
    
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/2,scnsize(4)/6-10,scnsize(4),scnsize(4)*2/3]); % 绘图区位置
end

% uiwait(msgbox('进入发送端光调制(激光器)','提示','help'));
close all;

end

