function [human_count, pc_count] = count_global_type(board)
    
    human_count = zeros(1,7);
    pc_count = zeros(1,7);
    
    % 横向
    for i = 1:1:15
        line = board(i,:);
        str_line = arr2str(line);
        [temp_human_count, temp_pc_count] = count_line_type(str_line);
        human_count = human_count + temp_human_count;
        pc_count = pc_count + temp_pc_count;
    end
    
    % 纵向
    for i = 1:1:15
        line = board(:,i);
        str_line = arr2str(line);
        [temp_human_count, temp_pc_count] = count_line_type(str_line);
        human_count = human_count + temp_human_count;
        pc_count = pc_count + temp_pc_count;
    end
    
    % 左上到右下
    for i = -10 : 1 : 10
        line = diag(board,i);
        str_line = arr2str(line);
        [temp_human_count, temp_pc_count] = count_line_type(str_line);
        human_count = human_count + temp_human_count;
        pc_count = pc_count + temp_pc_count;
    end
    
     % 右上到左下
     lr_board = fliplr(board);
     for i = -10 : 1 : 10
        line = diag(lr_board,i);
        str_line = arr2str(line);
        [temp_human_count, temp_pc_count] = count_line_type(str_line);
        human_count = human_count + temp_human_count;
        pc_count = pc_count + temp_pc_count;
     end
     
end