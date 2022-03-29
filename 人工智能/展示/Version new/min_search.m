function [this_beta,min_x,min_y] = min_search(board, depth, alpha, beta)
    this_beta = beta;
    
    if depth == 0
        [human_count, pc_count] = count_global_type(board);
        temp_human_score = calc_score(human_count, 1);
        temp_pc_score = calc_score(pc_count, 2);
        global_score = temp_pc_score - temp_human_score;
        
        this_beta = global_score;
        fprintf("%d ",this_beta);
        return
    end
    
    if depth>0
        
        % 轮到玩家下棋
        new_moves = get_moves(board, 1);
        
        for i = 1 : 1 : length(new_moves)
            copy_board = board;
            
            move_x = new_moves(i,2);
            move_y = new_moves(i,3);
            copy_board(move_x,move_y) = 1;
            
            child_node_val = max_search(copy_board, depth - 1, alpha, this_beta);
            
            % MIN节点的beta值取子节点的最小值
            if child_node_val < this_beta
                this_beta = child_node_val;
                min_x = move_x;
                min_y = move_y;
            end
            
            % alpha-beta剪枝
              if  this_beta <= alpha
                   disp('cut min');
                   break;
              end
            
        end   
    end
end