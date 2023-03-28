function [E_Base] = Digital_Mixer(F_THz,F_THz_LO,E_IF,delta_t,Fb,draw)
%> @数字下变频函数

%> @E_IF, 中频信号电场
%> @F_THz, 太赫兹载波频率(单位Hz)
%> @F_THz_LO, 太赫兹本振频率(单位Hz)
%> @delta_t, 一个符号的时间周期
%> @Fb, QAM信号的波特率

%> @E_Base, 基带信号电场

% uiwait(msgbox('进入接收端DSP(数字下变频)','提示','help'));
close all;
fprintf(1,[' #   数字下变频计算中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

%% 数字下变频
Npoints = length(E_IF);
F_IF = abs(F_THz_LO-F_THz); % 中频信号频率
E_Base_1 = conj(exp(1i*(2*pi*F_IF*(1:Npoints)*delta_t))).*(E_IF); % 数字下变频后的基带信号场

if draw
    % 基带信号电谱(归一化)
    figure;
    Sig_draw = E_Base_1;
    datalen = length(Sig_draw);
    fplot = linspace(-1/delta_t/2,1/delta_t/2,datalen);
    FFT_Ex_1 = fftshift(fft(Sig_draw));
    FFT_Ex = abs(FFT_Ex_1)/(length(Sig_draw));
    FFT_Ex_dB = 10*log10(FFT_Ex.^2);    
    plot( fplot./1e9, FFT_Ex_dB,'b');
    title('基带信号电谱(归一化)','FontSize',12);
    xlim([-1/delta_t/2 1/delta_t/2]/1e9);
    xlabel('频率（GHz）');
    ylabel('功率（dB）');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置
end

%% DC Block函数
E_Base_1_Ser = [real(E_Base_1) imag(E_Base_1)];
E_Base_1_Temp1 = bsxfun(@minus,E_Base_1_Ser,mean(E_Base_1_Ser));
E_Base_1_DCB = E_Base_1_Temp1(1:end/2) + 1i*E_Base_1_Temp1(end/2+1:end);

%% 低通滤波函数

lpFilt = designfilt('lowpassiir', ...
    'PassbandFrequency',Fb, ...
    'StopbandFrequency',1.05*Fb,...
    'PassbandRipple',0.05, ...
    'SampleRate',1/delta_t,...
    'StopbandAttenuation',40,...
    'DesignMethod','butter'); % IIR滤波器设计

E_Base = filter(lpFilt,E_Base_1_DCB);

if draw
    % 滤波后基带信号电谱(归一化)
    figure;
    Sig_draw = E_Base;
    datalen = length(Sig_draw);
    fplot = linspace(-1/delta_t/2,1/delta_t/2,datalen);
    FFT_Ex_1 = fftshift(fft(Sig_draw));
    FFT_Ex = abs(FFT_Ex_1)/(length(Sig_draw));
    FFT_Ex_dB = 10*log10(FFT_Ex.^2);    
    plot( fplot./1e9, FFT_Ex_dB,'m');
    title('滤波后基带信号电谱(归一化)','FontSize',12);
    xlim([-1/delta_t/2 1/delta_t/2]/1e9);
    xlabel('频率（GHz）');
    ylabel('功率（dB）');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2+1,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置
end

end

%% Backup
% if draw
%     h=fvtool(lpFilt);  suptitle('滤波器响应');
% end
