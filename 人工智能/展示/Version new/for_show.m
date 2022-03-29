function board_big = for_show(board)
    row = [1:15];
    col = [1:15]';
    board_big = zeros(16,16);
    board_big(1,2:16) = row;
    board_big(2:16,1) = col;
    board_big(2:16,2:16) = board;
end