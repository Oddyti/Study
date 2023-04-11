%% 程序初始化
% 程序初始化
Program_Init;

% 全局变量定义
Init_Waveform_Parameters; % 信号与波形参数
Init_DSP_Parameters; % DSP处理参数
Init_System_Parameters; % 系统仪器设备以及器件模块参数

%% QAM调制
[tx_data, tx_sig] = QAM_Modulator(PRBS, num_symb, bits_per_sym, coding, draw);

%% QAM信号脉冲成型（含AWG脉冲成型）
tx_waveform_awg = QAM_Pulse_Shaping(tx_sig, Nss, PulseShaping, txrolloff, Nsym, Fs_awg, Fs, draw);

%% 连续波激光器
% 基带调制激光器
E_sig_laser = CW_Laser(Lamda_sig, P_sig_dBm, Phase_sig, Linewidth_sig, length(tx_waveform_awg), 1 / Fs_awg, C_Light, 0, draw);

% 本振激光器
E_LO_laser = CW_Laser(Lamda_LO, P_LO_dBm, Phase_LO, Linewidth_LO, length(tx_waveform_awg), 1 / Fs_awg, C_Light, 1, draw);

%% IQ光调制器
E_sig = IQ_Optical_Modulator(tx_waveform_awg, Clipping, Vac, Vpi, Phi_off, E_sig_laser, Fs_awg, Lamda_sig, E_LO_laser, F_THz, C_Light, draw);

%% 光放大器及滤波器
E_sig_n = Optical_Amplifier(E_sig, OSNR_dB, Noise_BW, Fs_awg, Lamda_sig, C_Light, E_LO_laser, F_THz, draw);

%% 光电探测器
E_THz = Photodetector(E_sig_n, E_LO_laser, P_sig_dBm, kB, qelementary, RL, T, R, Fs_awg, F_THz, draw);

%% 混频器
E_IF = Mixer_Rec(E_THz, R_THz_Mixer, P_THz_LO_dBm, F_THz, F_THz_LO, SNR_Mixer, 1 / Fs_awg, THz_LO_Phase, Linewidth_THz_LO, draw);

%% 数字下变频及滤波
E_Base = Digital_Mixer(F_THz, F_THz_LO, E_IF, 1 / Fs_awg, Fb, draw);

%% IQ失衡补偿
E_Base_IQC = IQ_Imbalance_Comp(E_Base);

%% 时钟同步与恢复
E_Dec = Time_Recovery(E_Base_IQC, Fs_awg, Fs, Fb, Nsym, txrolloff, Nss, draw);

%% 线性均衡
[E_est, ~] = Linear_Equalizer(E_Dec, Eq_type, Eq_iter, Eq_CMA_Delay, Eq_taps, Eq_mu, Eq_Adaptive_mu, Eq_conv, M, draw);

%% 频偏补偿以及相噪补偿
[E_CPR, ~] = Carrier_Recovery(E_est, BPS_PAR, BPS_N, M, Fb, draw);

%% 线性均衡
[E_final, ~] = Linear_Equalizer(E_CPR, Eq_type, Eq_iter, Eq_CMA_Delay, Eq_taps, Eq_mu, Eq_Adaptive_mu, Eq_conv, M, draw);

%% 传输性能评估
Transmission_Performance; 
