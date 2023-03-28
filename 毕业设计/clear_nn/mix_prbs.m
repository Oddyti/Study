function bit_seq = mix_prbs(seed_order,seq_length)
    seed_length = 2^seed_order-1;
    seed = randi([0 1], 3, seed_order);
    index = prbs(seed_order, seed_length, seed(1,:));
    s1 = prbs(seed_order, seed_length, seed(2,:));
    s2 = prbs(seed_order, seed_length, seed(3,:));
    num = ceil(seq_length/seed_length);

    index_new = [];
    s1_new = [];
    s2_new = [];
    for i = 1:num
    index_new = [index_new,index];
    s1_new = [s1_new,s1];
    s2_new = [s2_new,s2];
    end

    bit_seq = zeros(seq_length,1);
    index_s1 = 1;
    index_s2 = 1;
    for i = 1:1:seq_length
        if index_new(i) == 0
            bit_seq(i) = s1_new(index_s1);
            index_s1 = index_s1 + 1;
        else
            bit_seq(i) = s2_new(index_s2);
            index_s2 = index_s2 + 1;
        end
    end
    
end