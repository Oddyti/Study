%
close all;
clc;
clear;

img = imread('RGB-color-cube.tif');
img1 = fix(img / 51) * 51;
f1 = figure(1);
set(f1,'position',[0 0 840 420]);
subplot(1, 2, 1);
    imshow(img);
    title('original image', Fontsize = 18);
subplot(1, 2, 2);
    imshow(img1);
    title('web colors', Fontsize = 18);
saveas(f1, 'f1.png');
