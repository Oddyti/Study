close all;
clear;
clc;
img = imread('aini.jpg');
img_gray = rgb2gray(img);

% 获取灰度直方图的信息（r，数量，概率）
[Y,X] = size(img_gray);
grayvalue = unique(img_gray);
l = 256 - length(grayvalue);
b = zeros(l, 1);
grayvalue = cat(1,grayvalue,b);
imginfo=[];
for i=1:length(grayvalue)
        [ANSy,ANSx]=find(img_gray==grayvalue(i));
        imginfo.gray(i)=grayvalue(i);
        imginfo.count(i)=length(ANSy);
        imginfo.prob(i)=length(ANSy)/(Y*X);
end 

% 获取量化后的灰度s，数量，概率
hist_eq = [];
hist_eq.gray = imginfo.gray;
hist_eq.s = zeros(1,256);
hist_eq.ceil_s = zeros(1,256);
hist_eq.count = zeros(1,256);
for k = 1:1:length(grayvalue)
    for j = 1:1:k
        hist_eq.s(k) = hist_eq.s(k) + imginfo.prob(j);
        hist_eq.count(k) = hist_eq.count(k) + imginfo.count(j);
    end
    hist_eq.s(k) = (255) * hist_eq.s(k);
end
hist_eq.ceil_s = ceil(hist_eq.s);

% 获取均衡化后的图像
imgHist = zeros(size(img_gray));
for y = 1:1:Y
    for x = 1:1:X
        i = img_gray(y,x);
        imgHist(y,x) = hist_eq.ceil_s(i+1);
    end
end
imgHist = uint8(imgHist);

% 计算均衡化后的直方图信息
[Y1,X1] = size(imgHist);
hist_eq_grayvalue = unique(imgHist);
hist_eq.count_new = zeros(1, 256);
hist_eq.prob = zeros(1, 256);
for i=1:length(grayvalue)
        [ANSy,ANSx]=find(imgHist==grayvalue(i));
        % imginfo.position(i) = [ANSy, ANSy];
        hist_eq.count_new(i)=length(ANSy);
        hist_eq.prob(i)=length(ANSy)/(Y1*X1);
end












figure(1);
    subplot(2,2,1);
        imshow(img);
        title('Original Image');
    subplot(2,2,2);
        imshow(img_gray);
        title('Grayscale Image')
    subplot(2,2,3);
        stem(imginfo.gray,imginfo.count,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(imginfo.count)]);
        title('My Histogram');
    subplot(2,2,4);
        imhist(img_gray);
        ylim('auto');
        title('The imhist()')

f2 = figure(2);
    subplot(2,2,[1,2]);
        plot(hist_eq.gray, hist_eq.s);
        xlabel('r');
        ylabel('s');
        axis([0 255 0 255]);
        title('Tranformation Function')
    subplot(2,2,3);
        stem(imginfo.gray,imginfo.count,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(imginfo.count)]);
        title('Original Histogram');
    subplot(2,2,4);
        stem(hist_eq.gray,hist_eq.count_new,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(hist_eq.count_new)]);
        title('After Histogram Equalization');
    
f3 = figure(3);
    subplot(2,2,1);
        imshow(img_gray);
        title('Original Grayscale Image');
    subplot(2,2,2);
        stem(imginfo.gray,imginfo.count,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(imginfo.count)]);
        title('Original Histogram');
    subplot(2,2,3);
        imshow(imgHist);
        title('After Histogram Equalization');
    subplot(2,2,4);
        stem(hist_eq.gray,hist_eq.count_new,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(hist_eq.count_new)]);
        title('After Histogram Equalization');
f4 = figure(4);
    subplot(2,2,1);
        imshow(imgHist);
        title('My Histogram Equalization');
    subplot(2,2,2);
        stem(hist_eq.gray,hist_eq.count_new,'Marker','none');
        xlabel('Graylevel');
        ylabel('Quantity');
        axis([0 255 0 1.2*max(hist_eq.count_new)]);
        title('My Histogram Equalization');  
    subplot(2,2,3);
        I = histeq(img_gray);
        imshow(I)
        title('The histeq()');
    subplot(2,2,4);
        imhist(I);
        ylim('auto');
        title('The histeq()');