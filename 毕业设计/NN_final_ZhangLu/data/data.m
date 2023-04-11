clear;
clc;

mt_x = importdata('E_rx_mt.mat');
mt_y = importdata('E_tx_mt.mat');
mix_x = importdata('E_rx_mix.mat');
mix_y = importdata('E_tx_mix.mat');
prbs_x = importdata('E_rx_prbs.mat');
prbs_y = importdata('E_tx_prbs.mat');

save data.mat;

