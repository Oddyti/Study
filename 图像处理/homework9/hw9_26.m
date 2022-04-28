clc;
clear;
close all;

img_1 = imread('9-26a.tif');
img_1 = imbinarize(img_1);
img_2 = imread('9-26b.tif');
img_2 = imbinarize(img_2);
se_1 = img_2;
se_2 = 1 - img_2;
img_3 = bwhitmiss(img_1,se_1,se_2);
f2 = figure(1);
imshow(img_3);
saveas(f2, 'f2.png');