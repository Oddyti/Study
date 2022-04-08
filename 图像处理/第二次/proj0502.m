clc;
clear;
close all;

img = imread('Fig0507(a).tif');
img_n = imnoise(img, 'salt & pepper', 0.2);
img_median = my_median(img_n);
img_median2 = medfilt2(img_n);

f1 = figure(1);
set(f1,'position',[0 0 800 600]);
    imshow(img);
    title('orignal', fontsize = 16);
saveas(f1, 'f1.png');
f2 = figure(2);
set(f2,'position',[0 0 800 600]);
    imshow(img_n);
    title('add salt & pepper noise', fontsize = 16);
saveas(f2, 'f2.png');

f3 = figure(3);
set(f3,'position',[0 0 1900 1800]);
subplot(1,2,1);
    imshow(img_median);
    title('my median filter', fontsize = 18);
subplot(1,2,2);
    imshow(img_median2);
    title('median filter of matlab', fontsize = 18);
saveas(f3, 'f3.png');