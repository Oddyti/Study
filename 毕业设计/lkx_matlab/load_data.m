function data = load_data(data_path, data_type)

    tx_bit_seq = load(data_path);

    switch data_type
        case 'mt'
            data = tx_bit_seq.tx_bit_mt;
        case 'prbs'
            data = tx_bit_seq.tx_bit_prbs;
        case 'mix'
            data = tx_bit_seq.tx_bit_mix;
    end

end
