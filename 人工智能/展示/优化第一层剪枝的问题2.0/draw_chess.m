function draw_chess(x, y, flag)
    t = 0:pi / 100:2 * pi;
    rx = x + 0.5 * cos(t);
    ry = y + 0.5 * sin(t);

    if flag == 1
        fill(rx, ry, 'k');
    else
        fill(rx, ry, 'w');
    end
