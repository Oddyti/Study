clear;
clc;
load('E_eq_mt.mat');

data_eq = E_eq_mt_real + E_eq_mt_imag * 1i;
data_tx = E_tx_mt_real + E_tx_mt_imag * 1i;
data_rx = E_rx_mt_real + E_rx_mt_imag * 1i;

Ms = 16;
Tx_seq_nn = qamdemod(data_tx.',Ms,'bin','UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
Rx_seq_nn = qamdemod(data_eq.',Ms,'bin','UnitAveragePower',true); % QAM解调
Tx_seq = qamdemod(data_tx.',Ms,'bin','UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
Rx_seq = qamdemod(data_rx.',Ms,'bin','UnitAveragePower',true); % QAM解调

[~, ratio_nn] = symerr(Tx_seq_nn, Rx_seq_nn);
[~, ratio] = symerr(Tx_seq, Rx_seq);