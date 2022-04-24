function main
    B = ones(3, 3);

    im = imread(’testpattern1024.tif’);
    f1 = figure(1);
    subplot(22[1,2]); imshow(im); title(‘原图’)
    im_N1 = image_dilation(im, B);
    subplot(223); imshow(im_N1); title(‘膨胀后图片’)
    im_N2 = image_erode(im, B);
    subplot(224); imshow(im_N2); title(‘腐蚀后图片’)

function im_N = image_dilation(im, B) %二值图膨胀程序
    [m, n] = size(im);
    zero_ac = zeros(m, 1);
    zero_ar = zeros(1, n + 2);
    % 以0扩展图像
    im1 = [zero_ar; [zero_ac, im, zero_ac]; zero_ar];
    
    im_N = zeros(m, n);

    for i = 2:m + 1

        for j = 2:n + 1
            N_zero = find([im1(i - 1, j - 1) im1(i - 1, j) im1(i - 1, j + 1) im1(i, j - 1)…
                    im1(i, j) im1(i, j + 1) im1(i + 1, j - 1) im1(i + 1, j) im1(i + 1, j + 1)]);

            if size(N_zero, 2) > 0
                im_N(i - 1, j - 1) = 1;
            end

        end

    end

function im_N = image_erode(im, B) %二值图腐蚀程序
    [m, n] = size(im);
    zero_ac = zeros(m, 1);
    zero_ar = zeros(1, n + 2);
    im1 = [zero_ar; [zero_ac, im, zero_ac]; zero_ar];
    im_N = zeros(m, n);

    for i = 2:m + 1

        for j = 2:n + 1
            N_zero = find([im1(i - 1, j - 1) im1(i - 1, j) im1(i - 1, j + 1) im1(i, j - 1)…
                    im1(i, j) im1(i, j + 1) im1(i + 1, j - 1) im1(i + 1, j) im1(i + 1, j + 1)]);

            if size(N_zero, 2) == 9
                im_N(i - 1, j - 1) = 1;
            end

        end

    end

function im = image_set(im1, im2, key) %图像的交、差、补运算程序

    if key == ’交’
        im = im1 & im2;
    elseif key == ’差’
        im = im1 & ~im2;
    else
        im = ~im1;
    end

