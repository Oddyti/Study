img = imread('1038-a.tif');
T = mean2(img);
delta_T = 0.001;
count = 0;
while delta_T >= 0.001
    count = count + 1;
    g = img > T;
    G1 = img(g);
    G2 = img(~g);
    T_new = 0.5 * (mean2(G1) + mean2(G2));
    delta_T = abs(T - T_new);
    T = T_new;
end
img_new = imbinarize(img, T/255);
f1 = figure(1);
imshow(img);
title('Original Image', fontsize = 18);
f2 = figure(2);
imhist(img);
f3 = figure(3);
imshow(img_new);
title('After Global Thresholding', fontsize = 18);



