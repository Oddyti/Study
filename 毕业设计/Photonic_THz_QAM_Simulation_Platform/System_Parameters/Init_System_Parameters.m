%% 系统参数（光电器件）

%% 射频与仪器
Fs_awg = 64e9; % AWG仪器的采样率(单位Sa/s)
F_THz = 160e9; % 太赫兹载波频率(单位Hz)
Clipping = 0.8; % 基带放大器饱和裁剪比例

%% 激光器
C_Light = 3e8;   % 光速（单位m/s）
P_sig_dBm = 15; % 基带调制激光器输出功率（单位dBm）
P_LO_dBm = 14; % 本振激光器输出功率（单位dBm）
Lamda_sig = 1550E-9; % 基带调制激光器波长（单位m）
Lamda_LO = 1/(1/(Lamda_sig/C_Light)+F_THz)*C_Light; % 本振激光器波长（单位m）;波长=时间*光速; 频率=1/时间
Phase_sig = 0*pi; % 基带调制激光器初始相位
Phase_LO = 0*pi; % 本振激光器初始相位
Linewidth_sig = 2*pi*500e3; % 基带调制激光器线宽, 单位Hz
Linewidth_LO = 2*pi*500e3; % 本振激光器线宽, 单位Hz

%% 光MZM调制器
Vpi = 3.5;  % MZM调制器Vpi值
Vac = 1; % Vpp峰峰值大小（归一化）
Phi_off = pi/45; % IQ失衡度数

%% 光放大器
Noise_BW = Fb; % 噪声带宽
OSNR_dB = 18; % 光信噪比（单位dB）

%% 光电探测器
R = 0.003;  % PD 响应度
kB = 1.3806503e-23; % 波尔兹曼常数
qelementary = 1.6021e-19; % 电子电荷
RL = 50; % 匹配阻抗
T = 290; % 绝对温度

%% 混频器
P_THz_LO_dBm = 3; % 本振激光器输出功率（单位dBm）
F_THz_LO = 132e9; % 太赫兹本振频率(单位Hz)
SNR_Mixer = 18; % 太赫兹混频器信噪比（单位dB）
THz_LO_Phase = 0*pi; % 太赫兹本振初始相位
Linewidth_THz_LO = 2*pi*100e3; % 太赫兹本振线宽
R_THz_Mixer = 0.3; % 太赫兹混频器转换效率

%% 参数显示

% uiwait(msgbox({[' # 光电太赫兹系统仪器与器件主要参数:'];...
%     [' # ','在Init_System_Parameters文件定义'];...
%     [' * 太赫兹信号频率为: ',num2str(F_THz/1e9),'GHz'];...
%     [' * AWG采样率为: ',num2str(Fs_awg/1e9),'GSa/s'];...
%     [' * 基带调制激光器波长为: ',num2str(Lamda_sig*1e9),'nm'];...
%     [' * 基带调制激光器线宽为: ',num2str(Linewidth_sig/2/pi/1e3),'kHz'];...
%     [' * 本振激光器线宽为: ',num2str(Linewidth_LO/2/pi/1e3),'kHz'];...
%     [' * IQ失衡度数为: ','pi/',num2str(pi/Phi_off)];...
%     [' * 光信噪比为: ',num2str(OSNR_dB),'dB'];...
%     [' * 太赫兹本振频率为: ',num2str(F_THz_LO/1e9),'GHz'];...
%     [' * 太赫兹混频器信噪比为: ',num2str(SNR_Mixer),'dB'];...
%     [' * 太赫兹本振线宽为: ',num2str(Linewidth_THz_LO/2/pi/1e3),'kHz'];...
%     [' ---------------------------'];...
    
%     [' # 调制波形主要参数:'];...
%     [' # ','在Init_Waveform_Parameters文件定义'];...
%     [' * 调制波形为: ',num2str(M),'QAM'];...
%     [' * 信号波特率为: ',num2str(Fb/1e9),'Gbaud'];...
%     [' * 发射符号数为: ','2^',num2str(log2(num_symb)),'样本点'];...
%     [' * 脉冲成型方法为: ',PulseShaping];...
%     [' ---------------------------'];...
    
%     [' # 接收DSP主要参数:'];...
%     [' # ','在Init_DSP_Parameters文件定义'];...
%     [' * 线性均衡器为: ',Eq_type];...
%     [' * 线性均衡迭代次数为: ',num2str(Eq_iter),'次'];...
%     [' * 线性均衡抽头数为: ',num2str(Eq_taps),'个'];...
%     [' * 相位估计粒度为: ','pi/',num2str(2*BPS_PAR)];...
%     [' * 相位估计块大小为: ',num2str(BPS_N)]},'光电太赫兹系统','help'));

fprintf(1,' # 光电太赫兹系统仪器与器件主要参数\n');
fprintf(1,' # 在Init_System_Parameters文件定义\n');
fprintf(1,[' * 太赫兹信号频率为: ',num2str(F_THz/1e9),'GHz\n']);
fprintf(1,[' * AWG采样率为: ',num2str(Fs_awg/1e9),'GSa/s\n']);
fprintf(1,[' * 基带调制激光器波长为: ',num2str(Lamda_sig*1e9),'nm\n']);
fprintf(1,[' * 基带调制激光器线宽为: ',num2str(Linewidth_sig/2/pi/1e3),'kHz\n']);
fprintf(1,[' * 本振激光器线宽为: ',num2str(Linewidth_LO/2/pi/1e3),'kHz\n']);
fprintf(1,[' * IQ失衡度数为: ','pi/',strcat(num2str(pi/Phi_off),'\n')]);
fprintf(1,[' * 光信噪比为: ',num2str(OSNR_dB),'dB\n']);
fprintf(1,[' * 太赫兹本振频率为: ',num2str(F_THz_LO/1e9),'GHz\n']);
fprintf(1,[' * 太赫兹混频器信噪比为: ',num2str(SNR_Mixer),'dB\n']);
fprintf(1,[' * 太赫兹本振线宽为: ',num2str(Linewidth_THz_LO/2/pi/1e3),'kHz\n']);
fprintf(1,[' ---------------------------\n']);

fprintf(1,[' # 调制波形主要参数\n']);
fprintf(1,[' # ','在Init_Waveform_Parameters文件定义\n']);
fprintf(1,[' * 调制波形为: ',num2str(M),'QAM\n']);
fprintf(1,[' * 信号波特率为: ',num2str(Fb/1e9),'Gbaud\n']);
fprintf(1,[' * 发射符号数为: ','2^',num2str(log2(num_symb)),'样本点\n']);
fprintf(1,[' * 脉冲成型方法为: ',strcat(PulseShaping,'\n')]);
fprintf(1,[' ---------------------------\n']);

fprintf(1,[' # 接收DSP主要参数\n']);
fprintf(1,[' # ','在Init_DSP_Parameters文件定义\n']);
fprintf(1,[' * 线性均衡器为: ',strcat(Eq_type,'\n')]);
fprintf(1,[' * 线性均衡迭代次数为: ',num2str(Eq_iter),'次\n']);
fprintf(1,[' * 线性均衡抽头数为: ',num2str(Eq_taps),'个\n']);
fprintf(1,[' * 相位估计粒度为: ','pi/',strcat(num2str(2*BPS_PAR),'\n')]);
fprintf(1,[' * 相位估计块大小为: ',strcat(num2str(BPS_N),'\n')]);
fprintf(1,[' ---------------------------\n']);
