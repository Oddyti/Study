img = imread("test.tif");

[m, n] = size(img);
% 边界扩展
zero_ac = ones(m, 2);
zero_ar = ones(2, n + 4);
img_new = [zero_ar; [zero_ac, img, zero_ac]; zero_ar];

img_mid = zeros(m + 2, n + 2);

b_0_m = 0;
b_0_n = 0;

for i = 2:1:m + 1

    for j = 2:1:n + 1

        if (img_new(i, j - 1) == 0 && img_new(i - 1, j) == 0 && img_new(i, j) == 1)
            b_0_m = i;
            b_0_n = j;
            break
        end

    end

end


c_0_m = b_0_m;
c_0_n = b_0_n - 1;
img_mid(b_0_m, b_0_n) = 1;

b_m = b_0_m;
b_n = b_0_n;
c_m = c_0_m;
c_n = c_0_n;
cb_m = 0;
cb_n = 0;
b_2_m = 0;
b_2_n = 0;

while (b_2_m ~= b_0_m || b_2_n ~= b_0_n)

    if (img_new(c_m, c_n) ~= 1)

        if (c_m == b_m && c_n == b_n - 1 && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_m = c_m - 1;
        end

        if (c_m == b_m - 1 && c_n == b_n - 1 && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_n = c_n + 1;
        end

        if (c_m == b_m - 1 && c_n == b_n && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_n = c_n + 1;
        end

        if (c_m == b_m - 1 && c_n == b_n && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_n = c_n + 1;
        end

        if (c_m == b_m - 1 && c_n == b_n + 1 && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_m = c_m + 1;
        end

        if (c_m == b_m && c_n == b_n + 1 && img_new(c_m, c_n) ~= 1)
            cb_m = c_m; 
            cb_n = c_n;
            c_m = c_m + 1;
        end

        if (c_m == b_m + 1 && c_n == b_n + 1 && img_new(c_m, c_n) ~= 1)
            cb_m = c_m; 
            cb_n = c_n;
            c_n = c_n - 1;
        end

        if (c_m == b_m + 1 && c_n == b_n && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_n = c_n - 1;
        end

        if (c_m == b_m + 1 && c_n == b_n - 1 && img_new(c_m, c_n) ~= 1) 
            cb_m = c_m; 
            cb_n = c_n;
            c_m = c_m - 1;
        end

    end

    if (img_new(c_m, c_n) == 1)
        b_m = c_m;
        b_n = c_n;
        c_m = cb_m;
        c_n = cb_n;
        b_2_m = b_m;
        b_2_n = b_n;
        img_mid(b_m, b_n) = 1;
    end
 
end

img_out = img_mid(2:m + 1, 2:n + 1);

figure;
subplot(1, 2, 1)
    imshow(img)
    title('原始图像',fontsize = 18)
subplot(1, 2, 2)
    imshow(img_out);
    title('输出的边界',fontsize = 18)
