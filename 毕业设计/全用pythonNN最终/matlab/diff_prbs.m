clear;
clc;
close all;
L = 2^16;
tx_seq_prbs4 = prbs(4, L)';
tx_seq_prbs5 = prbs(5, L)';
tx_seq_prbs6 = prbs(6, L)';
tx_seq_prbs7 = prbs(7, L)';
tx_seq_prbs8 = prbs(8, L)';
tx_seq_prbs9 = prbs(9, L)';
tx_seq_prbs10 = prbs(10, L)';
tx_seq_prbs11 = prbs(11, L)';
tx_seq_prbs12 = prbs(12, L)';
tx_seq_prbs13 = prbs(13, L)';
tx_seq_mt = randi([0 1], L, 1); % 梅森扭转\
SNR = 1;
[sig_y_mt, sig_x_mt] = channel(tx_seq_mt, SNR);
[sig_y_prbs4, sig_x_prbs4] = channel(tx_seq_prbs4, SNR);
[sig_y_prbs5, sig_x_prbs5] = channel(tx_seq_prbs5, SNR);
[sig_y_prbs6, sig_x_prbs6] = channel(tx_seq_prbs6, SNR);
[sig_y_prbs7, sig_x_prbs7] = channel(tx_seq_prbs7, SNR);
[sig_y_prbs8, sig_x_prbs8] = channel(tx_seq_prbs8, SNR);
[sig_y_prbs9, sig_x_prbs9] = channel(tx_seq_prbs9, SNR);
[sig_y_prbs10, sig_x_prbs10] = channel(tx_seq_prbs10, SNR);
[sig_y_prbs11, sig_x_prbs11] = channel(tx_seq_prbs11, SNR);
[sig_y_prbs12, sig_x_prbs12] = channel(tx_seq_prbs12, SNR);
[sig_y_prbs13, sig_x_prbs13] = channel(tx_seq_prbs13, SNR);
clear L
clear SNR
clear tx_seq_prbs4
clear tx_seq_prbs5
clear tx_seq_prbs6
clear tx_seq_prbs7
clear tx_seq_prbs8
clear tx_seq_prbs9
clear tx_seq_prbs10
clear tx_seq_prbs11
clear tx_seq_prbs12
clear tx_seq_prbs13
clear tx_seq_mt