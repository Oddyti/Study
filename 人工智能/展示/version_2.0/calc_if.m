function global_score = calc_if(board, x, y, who)

    %如果pc或者human下出这个空点
    board(x, y)  = who;
    
    [human_count, pc_count] = count_global_type(board);
    
    temp_human_score = calc_score(human_count, 1);
	temp_pc_score = calc_score(pc_count, 2);
    
    %返回此时的全局分数(正负相对于PC,即:若为正则对PC有利)
    global_score = temp_pc_score - temp_human_score;
    
end