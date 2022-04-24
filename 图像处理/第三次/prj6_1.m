%
close all;
clc;
clear all;

img = imread('RGB-color-cube.tif');
f1 = figure;
subplot(1,2,1);
imshow(img);
title('original image');

img1 = fix((img/51)*51);
subplot(1,2,2);
imshow(img1);
title('web colors');

saveas(f1, 'f1.png');
