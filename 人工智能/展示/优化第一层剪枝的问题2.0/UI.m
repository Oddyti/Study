function UI()
    define_coef;
    figure(1);
    axis([0 17 0 17]);
    hold on;
    % axis off;
    axis equal;

    % draw line
    for i = 1:16
        line([1 16], [i i]);
        line([i i], [1 16]);
    end

    % player代表玩家
    player = 1;
    board = zeros(15);
    use_ai = 0;
    global win;

    while 1
        hold on
        is_playing = 1;
        while is_playing
            if use_ai
                tic;
                [~, rx, ry] = find_bestmove(board);
                toc;
                xpos = rx + 0.5;
                ypos = ry + 0.5;

                if board(rx, ry) == 1 || board(rx, ry) == 2
                    continue;
                end
                is_playing = 0;
                use_ai = 0;
            else
                [xpos, ypos] = ginput(1);
                xpos = 0.5 * (floor(xpos) + ceil(xpos));
                ypos = 0.5 * (floor(ypos) + ceil(ypos));
                if xpos <= 0.5 || xpos >= 16 || ypos <= 0.5 || ypos >= 16
                    continue
                end
                rx = floor(xpos);
                ry = floor(ypos);
                if board(rx, ry) == 1 || board(rx, ry) == 2
                    continue;
                end
                is_playing = 0;
                use_ai = 1;
            end
        end
        % turn over
        if player == 1
            draw_chess(xpos, ypos, player);
            board(rx, ry) = player;
            player = 2;
        else
            draw_chess(xpos, ypos, player);
            board(rx, ry) = player;
            player = 1;
        end
        win = is_win(board);
        if win == 1
            disp('恭喜玩家获胜！！！')
            break;
        elseif win == 2
            disp('电脑获胜！！！')
            break;
        end
    end
