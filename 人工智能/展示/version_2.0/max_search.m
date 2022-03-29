function [this_alpha,max_x,max_y] = max_search(board, depth, alpha, beta)
    
this_alpha = alpha;
    
    if depth == 0
        [human_count, pc_count] = count_global_type(board);
        temp_human_score = calc_score(human_count, 1);
        temp_pc_score = calc_score(pc_count, 2);
        global_score = temp_pc_score - temp_human_score;
        
        this_alpha = global_score;
        fprintf("%d ",this_alpha);
        return 
    end
    
    if depth>0
        % 轮到电脑下棋
        new_moves = get_moves(board, 2);
        
        for i = 1 : 1 : length(new_moves)
            copy_board = board;
            
            move_x = new_moves(i,2);
            move_y = new_moves(i,3);
            copy_board(move_x, move_y) = 2;
            
            child_node_val = min_search(copy_board, depth - 1, this_alpha, beta);
            
            % MAX节点的alpha值取子节点的最大值
            if child_node_val > this_alpha
                this_alpha = child_node_val;
                max_x = move_x;
                max_y = move_y;
            end
            
              if this_alpha >= beta
                  disp('cut max');
                  break;
              end
            
        end
    end

end