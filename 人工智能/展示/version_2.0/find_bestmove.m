function [best_score_pc, best_x, best_y] = find_bestmove(board)
global AI_SEARCH_DEPTH;
global SCORE_MAX;
global SCORE_MIN;
        % 贪心算法下的moves排序
        moves = get_moves(board, 2)

        % 我们将电脑视为MAX选手，所以直接开始max_search  
        [best_score_pc,best_x,best_y] = max_search(board,AI_SEARCH_DEPTH,SCORE_MIN,SCORE_MAX);        
        fprintf('best_score_pc = %d', best_score_pc);
        disp(' ');
        fprintf('best_x = %d',best_x);
        disp(' ');
        fprintf('best_y = %d',best_y);
        disp(' ');
        
end