function E_Laser = CW_Laser(Lamda,P_dBm,Phase,LW,Npoints,delta_t,C_Light,LO_Index,draw)
%> @连续波激光器函数

%> @Lamda, 激光器波长
%> @P_dBm, 激光器功率(单位dBm)
%> @Phase, 激光器初始相位
%> @LW, 激光器线宽
%> @Npoints, 调制信号长度
%> @delta_t, 一个符号的时间周期
%> @C_Light, 光速（单位m/s）
%> @LO_Index, 为1则为本振，为0则为基带激光器

%> @E_laser, 激光器光场

fprintf(1,[' #   激光器建模中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

%% 激光器相位噪声
x2 = zeros(1,Npoints);

for qa = 1:Npoints
    x2(qa+1) = x2(qa)+ sqrt(LW*delta_t)*randn(1); % 激光器相位噪声维纳过程
end

laser_phase_noise = x2(1:end-1); %截去最后一个点

if draw
    figure;    
    plot(laser_phase_noise);xlabel('时间');ylabel('相位(rad)');
    if LO_Index
        title('本振激光器相位噪声','FontSize',12);
        scnsize = get(0,'ScreenSize');
        set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置
    else
        title('基带调制激光器相位噪声','FontSize',12);
        scnsize = get(0,'ScreenSize');
        set(gcf,'position',[scnsize(3)/2+1,scnsize(4)/4,scnsize(4)/2,scnsize(4)/3]); % 绘图区位置
    end
end

%% 激光器输出
Power_Laser = 10^(P_dBm/10)*0.001; % 激光器输出功率(单位W)
Omega_Laser = 2*pi*1/(Lamda/C_Light); % 激光器角频率
E_Laser=sqrt(Power_Laser)*exp(1i*(Omega_Laser*(1:Npoints)*delta_t+Phase)+1i*laser_phase_noise);

end

