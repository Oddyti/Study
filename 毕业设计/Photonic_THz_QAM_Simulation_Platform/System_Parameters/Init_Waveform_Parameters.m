%% 系统参数（调制波形）

% 发送端调制波形

M = 16; % QAM调制阶数，可为4、16、32、64等
bits_per_sym = log2(M); % QAM信号每符号比特数
coding = 'bin'; % QAM调制结构体，可选映射类型为'gray'、'bin'
PRBS = importdata('Data_Traces/tx_seq_mix_train.mat'); % 加载伪随机序列作为信号源，本仿真采用PRBS15作为pattern，长度为2^15-1=32767
PRBS = [PRBS;0]; % 加0补全为偶数长度

Fb = 25e9;  % QAM信号的波特率
Tb = 1/Fb;  % QAM信号一个符号的时间周期
Fs = Fb*2; % QAM信号的原始采样频率
Ts = 1/Fs; % QAM信号的原始采样频率下的一个符号的时间周期
num_symb = 2^17; % QAM信号的符号数
Nss = Fs/Fb; % QAM信号的原始采样频率下的过采样率

PulseShaping = 'RRC'; % 'No_Shaping'|'Rcos' |'RRC'脉冲成型的方法
txrolloff = 0.15; % 脉冲成型的滚降系数，取值0~1之间，决定频宽和陡峭程度
Nsym = 40; % 脉冲成型截断的符号范围
