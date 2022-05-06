function im_new = set_cal(im1, im2, key)

    if key == 0
        im_new = 1- ((~im1) & (~im2));
    elseif key == 1
        im_new = 1 - (im2 - im1);
    elseif key == 2
        im_new = ~im1;
    elseif key == 3
        im_new = ~im2;
    end

end
