% pc根据全局的count和score生成较优下棋点有序列表moves = (score, x, y)
% 若为pc则返回对pc最有益的顺序，若为human则返回对human最有益的顺序
% 对剪枝做出预排序，理论上可加快剪枝速度
function moves = get_moves(board, who)
    global AI_MOVE_NUM_PRE;
    moves = [ ];
    radius = 1;

    for x = 1 : 1 : 15
        for y = 1 : 1 : 15
            if board(x,y) == 0 && has_neighbor(board, x, y, radius)
                global_score = calc_if(board, x, y, who);
                point = [global_score, x, y];
                moves = [moves ; point];
            end
        end
    end
    
    if who == 2
        moves = sortrows(moves, 1, 'descend');
    elseif who == 1
        moves = sortrows(moves, 1);
    end
    
    if length(moves) > AI_MOVE_NUM_PRE
        moves = moves(1:AI_MOVE_NUM_PRE , :);
    end

end
