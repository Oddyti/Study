function UI()
    
    define_coef;
    figure(1);
    axis([0 17 0 17]);
    hold on
    axis off;
    axis equal;

    % draw line
    for i = 1:16
        line([1 16], [i i]);
        line([i i], [1 16]);
    end

    board = zeros(15);
    use_ai = 0;
    global win;

    while 1
        hold on
        
        if use_ai
            tic;
            [~, rx, ry] = find_bestmove(board);
            toc;
            xpos = rx + 0.5;
            ypos = ry + 0.5;

            if board(rx, ry) == 1 || board(rx, ry) == 2
                continue;
            end

            draw_chess(xpos, ypos, 2);
            drawnow;
            board(rx, ry) = 2;
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

                draw_chess(xpos, ypos, 1);
                drawnow;
                board(rx, ry) = 1;
                use_ai = 1;
                
        end
        
        win = is_win(board);
        if win == 1
            winmsg = 'Black Win!!';
            msgbox(winmsg)
            break;
        elseif win == 2
            winmsg =' White Win!!';
            msgbox(winmsg)
            break;
        end

    end
