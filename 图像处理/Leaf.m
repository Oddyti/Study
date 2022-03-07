clear;
clc;
close all;
% 导入图像
Image1 = imread('image2.jpg');

% 自动确定二值化阈值并二值化
Image2 = rgb2gray(Image1);
Image3 = imbinarize(Image2);

% 裁切出叶子和参照
rect1 = [0,0,28,15];
Refer = imcrop(Image3);
rect2 = [0, 15, 28, 20];
Leaf = imcrop(Image3);

subplot(2,2,1);
    imshow(Image2);
    title('Gray');
subplot(2,2,2);
    imshow(Image3);
    title('Binary');
subplot(2,2,3);
    imshow(Leaf);
    title('Leaf');
subplot(2,2,4);
    imshow(Refer);
    title('Reference');

% 测量像素点个数
SumLeaf = sum(sum(Leaf == 0));
SumRefer = sum(sum(Refer == 0));

% 计算面积
ReferArea = 100;  % 参照物的真实面积如1cm * 1cm的参照物则为100平方mm
LeafArea = (SumLeaf/SumRefer)*ReferArea;
fprintf('the area of the leaf is %f mm^2', LeafArea);




