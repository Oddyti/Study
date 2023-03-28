function E_IF = Mixer_Rec(E_THz,R,P_THz_LO_dBm,F_THz,F_THz_LO,SNR_Mixer,delta_t,Phase,LW,draw)
%> @太赫兹混频器函数

%> @E_THz, 太赫兹信号电场
%> @R, 太赫兹混频器转换效率
%> @P_THz_LO_dBm, 本振激光器输出功率（单位dBm）
%> @F_THz, 太赫兹载波频率(单位Hz)
%> @F_THz_LO, 太赫兹本振频率(单位Hz)
%> @SNR_Mixer, 太赫兹混频器信噪比（单位dB）
%> @delta_t, 一个符号的时间周期
%> @Phase, 太赫兹本振初始相位
%> @LW, 太赫兹本振线宽

%> @E_IF, 中频信号电场

fprintf(1,[' #   太赫兹混频器建模中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

Npoints = length(E_THz);
x2 = zeros(1,Npoints);

for qa = 1:Npoints
    x2(qa+1) = x2(qa)+ sqrt(LW*delta_t)*randn(1); % 激光器相位噪声维纳过程
end

LO_phase_noise = x2(1:end-1); %截去最后一个点

if draw
    figure;
    plot(LO_phase_noise);xlabel('时间');ylabel('相位(rad)');
    title('太赫兹本振相位噪声','FontSize',12);
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/4+2,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置   
end

Power_LO = 10^(P_THz_LO_dBm/10)*0.001; % 太赫兹混频器本振输出功率(单位W)
Omega_LO = 2*pi*F_THz_LO; % 太赫兹混频器本振角频率
E_THz_LO = sqrt(Power_LO)*exp(1i*(Omega_LO*(1:Npoints)*delta_t+Phase)+1i*LO_phase_noise);

E_IF_1 = 2*R*conj(E_THz_LO).*(E_THz); % 下变频后的中频信号场

E_IF=awgn(E_IF_1,SNR_Mixer,'measured'); % 加入混频器噪声

if draw
    % 下变频后中频信号电谱(归一化)
    figure;
    Sig_draw = E_IF;
    datalen = length(Sig_draw);
    fplot = linspace(abs(F_THz-F_THz_LO)-1/delta_t/2,abs(F_THz-F_THz_LO)+1/delta_t/2,datalen);
    FFT_Ex_1 = fft(Sig_draw);
    FFT_Ex = abs(FFT_Ex_1)/(length(Sig_draw));
    FFT_Ex_dB = 10*log10(FFT_Ex.^2);    
    plot( fplot./1e9, FFT_Ex_dB,'b');
    title('下变频后中频信号电谱(归一化)','FontSize',12);
    xlim([abs(F_THz-F_THz_LO)-1/delta_t/2 abs(F_THz-F_THz_LO)+1/delta_t/2]/1e9);
    xlabel('频率（GHz）');
    ylabel('功率（dB）');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2+scnsize(4)/4+4,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置  
end

end

