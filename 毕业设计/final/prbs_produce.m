clear;
clc;

Ms = 16;
L = 2^15-1;
k = log2(Ms);
tx_seq_mt_train = randi([0 1],L,1);     % 梅森扭转
tx_seq_prbs_train = prbs(15, L)';
tx_seq_mix_train = mix_prbs(15, L);
save tx_seq_mt_train tx_seq_mt_train;
save tx_seq_prbs_train tx_seq_prbs_train;
save tx_seq_mix_train tx_seq_mix_train;