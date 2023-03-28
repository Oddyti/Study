function E_THz = Photodetector(E_sig_n,E_LO_laser,P_dBm,kB,qelementary,RL,T,R,Fs_awg,F_THz,draw)
%> @光电探测器函数

%> @E_sig_n, 光放大器→滤波器后输出的光信号
%> @E_LO_laser, 本振激光器光场
%> @P_dBm, 激光器功率(单位dBm)
%> @R, PD 响应度
%> @kB, 波尔兹曼常数
%> @qelementary, 电子电荷
%> @RL, 匹配阻抗
%> @T, 绝对温度
%> @Fs_awg, AWG采样率
%> @F_THz, 太赫兹载波频率

%> @E_THz, 输出太赫兹信号

% uiwait(msgbox('进入太赫兹射频收发','提示','help'));
close all;
fprintf(1,[' #   光电探测器建模中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

E_THz_1 = 2*R*(E_LO_laser).*conj(E_sig_n); % PD产生的太赫兹信号场

shot_noise_tx = 2*qelementary*R*(10^(P_dBm/10)*0.001)*Fs_awg/2; % 散粒噪声
thermal_noise_tx = ((4*kB*T)/RL)*Fs_awg/2; % 热噪声
N = length(E_THz_1);
E_N1 = wgn(N,1,shot_noise_tx,'linear')';
E_N2 = wgn(N,1,thermal_noise_tx,'linear')';

E_THz = E_THz_1+E_N1+E_N2; %加入PD噪声的太赫兹信号

if draw
    % 太赫兹信号电谱(归一化)
    figure;
    Sig_draw = E_THz;
    datalen = length(Sig_draw);
    fplot = linspace(F_THz-Fs_awg/2,F_THz+Fs_awg/2,datalen);
    FFT_Ex_1 = fft(Sig_draw);
    FFT_Ex = abs(FFT_Ex_1)/(length(Sig_draw));
    FFT_Ex_dB = 10*log10(FFT_Ex.^2);    
    plot( fplot./1e9, FFT_Ex_dB,'color',[0.4940 0.1840 0.5560]);
    title('太赫兹信号电谱(归一化)','FontSize',12);
    xlim([F_THz-Fs_awg/2 F_THz+Fs_awg/2]/1e9);
    xlabel('频率（GHz）');
    ylabel('功率（dB）');    
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)*3/4,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置 
end

end

