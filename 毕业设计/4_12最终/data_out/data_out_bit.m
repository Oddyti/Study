clear;
clc;
load('E_eq_mt_bit.mat');

data_rx = x_test_real + x_test_imag * 1i;
Ms = 16;
Rx_seq = qamdemod(data_rx.',Ms,'bin','UnitAveragePower',true); % QAM解调
Rx_bit = de2bi(Rx_seq','left-msb'); % 十进制转换为二进制
Tx_bit = [y_test_real, y_test_imag];
Tx_bit = double(Tx_bit);
Eq_bit = [y_pred_real, y_pred_imag];
Eq_bit = double(Eq_bit);
errorRate = comm.ErrorRate;
Sim_Result1 = errorRate(Tx_bit(:),Rx_bit(:));
Sim_Result2 = errorRate(Tx_bit(:),Eq_bit(:));