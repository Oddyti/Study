clear;
clc;
M = 16;
coding = 'bin';
E_tx = importdata('E_tx_mt.mat');
E_rx = importdata('E_rx_mt.mat');
n = length(E_tx);
mem_n = 30;
modify_data_mt = modify_data(E_rx.', E_tx.', mem_n);
k = 0.8;
[x_train_mt, y_train_mt, x_test_mt, y_test_mt] = train_test_split(modify_data_mt, k);
Tx_seq = qamdemod(y_test_mt.',M,coding,'UnitAveragePower',true); % QAM解调 %,'UnitAveragePower',true
Rx_seq = qamdemod(x_test_mt(1,:).',M,coding,'UnitAveragePower',true); % QAM解调

tx1 = [15;14];
tx2 = [12;13];
Rx_bit = de2bi(Tx_seq','left-msb'); % 十进制转换为二进制
Tx_bit = de2bi(Rx_seq','left-msb'); % 十进制转换为二进制

errorRate = comm.ErrorRate;
Sim_Result = errorRate(Tx_bit(:),Rx_bit(:));
[nb,rb] = biterr(Tx_bit,Rx_bit,4);
[n,r] = symerr(Tx_bit, Rx_bit)
