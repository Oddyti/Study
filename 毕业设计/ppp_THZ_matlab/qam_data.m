function [seq_I, seq_Q] = qam_data(bit_seq)

    if mod(bit_seq, 2) == 1
        bit_seq = [bit_seq; 0];
    end

    seq = qammod(bit_seq, 16, 'bin', 'InputType', 'bit');
    seq_I = real(seq)';
    seq_Q = imag(seq)';

end
