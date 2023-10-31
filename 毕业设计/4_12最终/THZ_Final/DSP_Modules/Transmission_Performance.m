%> @传输性能评估函数

% E_tx = modnorm(tx_sig(:), 'avpow', 1)* tx_sig;
% E_rx = modnorm(E_final(:), 'avpow', 1)* E_final;
E_tx = tx_sig;
E_rx = E_final;
Tx_seq = qamdemod(E_tx(:),M,coding,'UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
Rx_seq = qamdemod(E_rx(:),M,coding,'UnitAveragePower',true); % QAM解调
[a,b] = xcorr(Tx_seq,Rx_seq);
loc = find(a==max(a));
Tx_seq = Tx_seq(b(loc)+1:b(loc)+length(Rx_seq));
[n,r] = symerr(Tx_seq, Rx_seq);
E_tx = E_tx(b(loc)+1:b(loc)+length(Rx_seq));
Tx_bit = de2bi(Tx_seq','left-msb'); % 十进制转换为二进制
Rx_bit = de2bi(Rx_seq','left-msb'); % 十进制转换为二进制
save Data_out/E_tx_mt.mat E_tx;
save Data_out/E_rx_mt.mat E_rx;
save Data_out/Tx_bit_mt.mat Tx_bit;
errorRate = comm.ErrorRate;
Sim_Result = errorRate(Tx_bit(:),Rx_bit(:));

figure;
stem(abs(Tx_bit(:)-Rx_bit(:)),'Linewidth',0.2,'MarkerSize',1);title('误码分布');xlabel('比特');ylabel('误码');
scnsize = get(0,'ScreenSize');
set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)/16,scnsize(4)+2,scnsize(4)/4-10]); % 绘图区位置

uiwait(msgbox({[' * 系统传输误码率为:',num2str(Sim_Result(1)/(1E-3)),'E-3'];...
   [' * 系统误比特数为:',num2str(Sim_Result(2)),'比特'];...
   [' * 系统总比特数为:',num2str(Sim_Result(3)),'比特']},'光电太赫兹系统','help'));
clc; close all; 

Result.Performance = Sim_Result;
Result.E_tx = E_tx;
Result.E_rx = E_rx;

save Sim_Results/Result Result;

fprintf(1,' # 光电太赫兹系统仪器与器件主要参数\n');
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
fprintf(1,[' * 调制波形为: ',num2str(M),'QAM\n']);
fprintf(1,[' * 信号波特率为: ',num2str(Fb/1e9),'Gbaud\n']);
fprintf(1,[' * 发射符号数为: ','2^',num2str(log2(num_symb)),'样本点\n']);
fprintf(1,[' * 脉冲成型方法为: ',strcat(PulseShaping,'\n')]);
fprintf(1,[' ---------------------------\n']);

fprintf(1,[' # 接收DSP主要参数\n']);
fprintf(1,[' * 线性均衡器为: ',strcat(Eq_type,'\n')]);
fprintf(1,[' * 线性均衡迭代次数为: ',num2str(Eq_iter),'次\n']);
fprintf(1,[' * 线性均衡抽头数为: ',num2str(Eq_taps),'个\n']);
fprintf(1,[' * 相位估计粒度为: ','pi/',strcat(num2str(2*BPS_PAR),'\n')]);
fprintf(1,[' * 相位估计块大小为: ',strcat(num2str(BPS_N),'\n')]);
fprintf(1,[' ---------------------------\n']);

fprintf(1,[' # 系统传输性能\n']);
fprintf(1,[' * 系统传输误码率为:',num2str(r),'\n']);
fprintf(1,[' * 系统传输误码率为:',num2str(Sim_Result(1)/(1E-3)),'E-3\n']);
fprintf(1,[' * 系统误比特数为:',num2str(Sim_Result(2)),'比特\n']);
fprintf(1,[' * 系统总比特数为:',num2str(Sim_Result(3)),'比特\n']);

if Sim_Result(1)>0.1
    uiwait(msgbox({'@系统性能需要优化!';'@---关注OSNR、线宽等指标---';'@---调节QAM阶数等指标---'},'光电太赫兹系统','warn'));
end