close all;

w = -90:0.01:90;            % w
T = 0.5;                    % 采样周期

% 测试信号

    y = 0.5.*(w>=-5 & w<-3)+(0.5*w + 2).* (w>=-3 & w<-1)+1.5.* (w>=-1 & w<1)+(-0.5*w + 2).* (w>=1 & w<3)+0.5.* (w>=3 & w<=5);
    y = abs(y);
% 

How = Hw(w,T);              % 零阶保持频谱
H1w = Hw2(w,T);             % 理想的矫正滤波器Hr(jw)
H1w_new = Hrw(w,T);         % 重建后的矫正滤波器频谱Hr'(jw)
Hjw = How .* H1w_new ./ T;       % 联合H(jw)，重建后的联合滤波
x1w = y .* How ./T;        % 未矫正频域直接D/A输出  
x2w=y.*Hjw;              % xw重建矫正滤波器后的频域波形 

figure(1);
% 输入测试信号
subplot(2,2,1);plot(w,y);       axis([-8 8 -0.1 2.1]);grid on;
% 理想的矫正滤波器H(jw)
subplot(2,2,2);plot(w,H1w);     axis([-8 8 1 1.6]);grid on;
% 重建后的Hr'(jw)
subplot(2,2,3);plot(w,H1w_new); axis([-8 8 1 1.6]);grid on;
% 重建后的联合滤波
subplot(2,2,4);plot(w,Hjw);     axis([-7 7 -0.4 1.2]);grid on;

figure(2);
% 未矫正重建输入信号
subplot(2,2,1);plot(w,x1w);axis([-8 8 -0.1 2.1]);grid on;
% 矫正后重建输入信号
subplot(2,2,2);plot(w,x2w);axis([-8 8 -0.1 2.1]);grid on;

figure(3);
% 对比图
plot(w,y,'b','linewidth',0.5);axis([-8 8 -0.1 2.1]);grid on;hold on;
plot(w,x1w,'k','linewidth',0.5);axis([-8 8 -0.1 2.1]);grid on;hold on;
plot(w,x2w,'r','linewidth',0.5);axis([-8 8 -0.1 2.1]);grid on;hold on;
l1 = legend('原信号','未矫正','矫正后');
set(l1,'FontSize',18);

figure(4);
% 局部放大图
plot(w,y,'b','linewidth',0.5);  axis([-0.44 -0.38 1.495 1.503]);grid on;hold on;
plot(w,x1w,'k','linewidth',0.5);axis([-0.44 -0.38 1.495 1.503]);grid on;hold on;
plot(w,x2w,'r','linewidth',0.5);axis([-0.44 -0.38 1.495 1.503]);grid on;hold on;
l2 = legend('原信号','未矫正','矫正后');
set(l2,'FontSize',18);

