function img_m = my_median(img)
    [row, col] = size(img);
    img_m = img;
    for r = 2:row - 1
        for c = 2:col - 1
            median3 = [
                img(r-1, c-1) img(r-1 , c) img(r-1, c+1)
                img(r, c-1) img(r , c) img(r, c+1)
                img(r +1, c-1) img(r+1 , c) img(r+1, c+1)];
            median3 = reshape(median3, [9,1]);
            M = median(median3);
            img_m(r, c) = M;
        end
    end
end