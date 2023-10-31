%% 系统参数（信号处理）

% 接收端信号处理

Eq_type = 'MMA'; % 'MMA'为>4阶QAM，'CMA'为QPSK
Eq_iter = 3; % 均衡迭代次数
Eq_CMA_Delay = 0; % CMA 时延，可调范围为0到Nss-1
Eq_taps = 60;  % 滤波器抽头
Eq_mu = 8e-5;  % CMA的mu值
Eq_Adaptive_mu = 0; % CMA自适应更新mu值
Eq_conv = 1e3; % CMA均衡器预设值长度

BPS_PAR = 2^6; % 相位估计粒度
BPS_N = 22; % 块大小
