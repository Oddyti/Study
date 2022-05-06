clear;
close all;
clc;

A = imread('9-23.tif');
B = strel('disk', 15, 0);
C = imerode(A, B);
D = imdilate(C, B);
E = imdilate(D, B);
F = imerode(E, B);
f1 = figure(1);

set(f1,'position',[0 0 800 600]);
subplot(2, 2, 1);
    imshow(C);
    title('C', fontsize = 16);
subplot(2, 2, 2); 
    imshow(D);  
    title('D', fontsize = 16);
subplot(2, 2, 3);
    imshow(E);
    title('E', fontsize = 16);
subplot(2, 2, 4);
    imshow(F);
    title('F', Fontsize = 16);
saveas(f1,'f1.png');

