%% 说明
% 此版本为尝试滤波改进版
% 增加滤波
clear;
clc;
close all;

%% 基础参数
lamda1 = 1550.18e-9;
lamda2 = 1547.38e-9;
c = 3e8;
fc_1 = c / lamda1;
fc_2 = c / lamda2;
fc = abs(fc_1 - fc_2);
Ts = 1e-15;
fs = 1 / Ts;
t = (1:100000) * Ts;
E1 = 0.002;
E2 = 0.002;
phy_1 = 0;
phy_2 = 0;
Et_1 = E1 * exp(1i * 2 * pi * fc_1 * t + phy_1);
Et_2 = E2 * exp(1i * 2 * pi * fc_2 * t + phy_2);
drawfft(Et_1, fs, 1);
%% 数据导入
data = load_data('data/tx_bit_seq.mat', 'mt');

%% 串并转换
[seq_I, seq_Q] = qam_data(data(1:20000));

%% MZM调制
V_pi = 3.5; % 半波电压
V_bias = 3.5; % 偏置电压
T_last = 20; % 码元宽度
[E_out_I, ut_I] = MZM(Et_1, seq_I, V_pi, V_bias, T_last);
[E_out_Q, ut_Q] = MZM(Et_1, seq_Q, V_pi, V_bias, T_last);
drawfft(E_out_I, fs, 2);
%% UTC-PD产生太赫兹波
% 这里看频谱图有问题，理论上需要提高码元宽度
R = 0.5; % UTC_PD的响应度
E_thz_I = UTC_PD(E1, E2, fc_1, fc_2, phy_1, phy_2, ut_I, R, Ts);
E_thz_Q = UTC_PD(E1, E2, fc_1, fc_2, phy_1, phy_2, ut_Q, R, Ts);
drawfft(E_thz_I, fs, 3);

%% 添加噪声
Ip = R * E1 ^ 2 * E2 ^ 2;
q = 1.6e-19; % 电荷常量
B = 1e9; % 带宽
Kb = 1.38e-23; % 玻尔兹曼常量
T = 300; % 温度23摄氏度
RL = 50; % 负载50欧姆
Fn = 1; % 噪声系数
n_s = 2 * q * Ip * B; % 量子噪声功率
n_k = 4 * Kb * T * Fn * B / RL; % 热噪声功率
noise = randn(1, length(E_thz_I)) .* sqrt(n_s + n_k); % 构造高斯噪声
E_thz_I = E_thz_I + noise; % 带噪声的信号
E_thz_Q = E_thz_Q + noise; % 带噪声的信号
ut_I = ut_I + noise;

%% 下变频
fLO = 12e9; % 本振信号频率
phy_LO = 0; % 本振信号初相位
G = 24; % 倍频
fLO_G = fLO * G; % 倍频后的频率
f_IF = abs(fc_1 - fc_2) - fLO_G; % 产生信号的中频
E3 = 0.002;
% 第一次变频后的信号为
E_LO = E3 * cos(2 * pi * fLO_G * t + phy_LO);
% EIF_I = E_thz_I .* E_LO; 理论上滤波前
phy_IF = 0;
EIF_I = R * E1 * E2 * E3 * ut_I * cos(2 * pi * f_IF + phy_IF); % 这里直接略去滤过过程得到结果
drawfft(EIF_I, fs, 4);
% 第二次变频，得到ut
ERx_I = 1/2 * R * E1 * E2 * E3 * ut_I * exp(-1i * phy_IF); % 同样直接得到结果
ut_I_rx = ERx_I / (1/2 * R * E1 * E2 * E3);
drawfft(ERx_I, fs, 5);

%% 数据恢复
seq_I_rx = acos(ut_I_rx) * 2 * V_pi / pi - V_bias;
drawfft(ERx_I, fs, 6);
