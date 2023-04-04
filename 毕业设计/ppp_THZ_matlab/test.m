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
R = 0.5;
E_thz = 2 * R * E1 * E2 * 1 .* cos(2 * pi * abs(fc_1 - fc_2) * t + abs(phy_1 - phy_2));
drawfft(E_thz,fs,1);