function im_N = my_dilation(im) %二值图膨胀程序
    [m, n] = size(im);
    zero_ac = ones(m, 2);
    zero_ar = ones(2, n + 4);
    im1 = [zero_ar; [zero_ac, im, zero_ac]; zero_ar];
    im1 = 1 - im1;
    im_N = ones(m + 1, n + 1);

    for i = 2:m + 1
        for j = 2:n + 1
            N_zero = find([im1(i - 1, j - 1) im1(i - 1, j) im1(i - 1, j + 1)
                        im1(i, j - 1) im1(i, j) im1(i, j + 1)
                        im1(i + 1, j - 1) im1(i + 1, j) im1(i + 1, j + 1)]);
            if size(N_zero) > 0
                im_N(i - 1, j - 1) = 0;
            end
        end
    end
