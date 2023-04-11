function rx_seq = mydeqam(seq)
    E_rx = modnorm(seq(:), 'avpow', 1)* seq;
    rx_seq = qamdemod(E_rx(:),M,coding,'UnitAveragePower',true); % QAM解调
end