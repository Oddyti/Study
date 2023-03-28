clear;
clc;
close all;
L = 2^15;
tx_bit_mt = randi([0 1],L,1); 
tx_bit_prbs = prbs(15, L)';
tx_bit_mix = mix_prbs(15, L);

save data/tx_bit_seq.mat