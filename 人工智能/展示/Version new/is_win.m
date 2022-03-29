function symbol = is_win(board)
global FIVE;
    [human_count, pc_count] = count_global_type(board);
    symbol = 0;
    
    if human_count(FIVE) > 0
        symbol = 1;
    elseif pc_count(FIVE) > 0
        symbol = 2;
    end
    
end