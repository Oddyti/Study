close all;

w = -90:0.01:90;            % w
T = 0.5;                    % 采样周期

% 测试信号
    y = (1+(2/pi)*w).*(w>=(-pi/2) & w<=0)+(1-(2/pi)*w).*(w>0 & w<=(pi/2))+0.*(w<(-pi/2) | w>(pi/2));
    y = abs(y);
% 

How = Hw(w,T);              % 零阶保持频谱
H1w = Hw2(w,T);             % 理想的矫正滤波器Hr(jw)
H1w_new = Hrw(w,T);         % 重建后的矫正滤波器频谱Hr'(jw)
Hjw = How .* H1w_new;       % 联合H(jw)，重建后的联合滤波
x1w = y .* How ./ T;        % 未矫正频域直接D/A输出  
x2w=y.*Hjw./T;              % xw重建矫正滤波器后的频域波形 

figure(1);
subplot(3,2,1);plot(w,y);title('输入信号','fontsize',14);axis([-3 3 -0.1 1.2]);grid on;
subplot(3,2,2);plot(w,H1w);title('理想的矫正滤波器H(jw)','fontsize',14);axis([-8 8 1 1.6]);grid on;
subplot(3,2,3);plot(w,H1w_new);title('重建后的Hr''(jw)','fontsize',14);axis([-8 8 1 1.6]);grid on;
subplot(3,2,4);plot(w,Hjw);title('重建后的联合滤波','fontsize',14);axis([-40 40 -0.3 0.6]);grid on;
subplot(3,2,5);plot(w,x1w);title('未矫正重建输入信号','fontsize',14);axis([-3 3 -0.1 1.2]);grid on;
subplot(3,2,6);plot(w,x2w);title('矫正后重建输入信号','fontsize',14);axis([-3 3 -0.1 1.2]);grid on;

figure(2);
plot(w,y,'b','linewidth',0.5);axis([-5 5 -0.1 1.2]);hold on;
plot(w,x1w,'k','linewidth',0.5);axis([-5 5 -0.1 1.2]);hold on;
plot(w,x2w,'r','linewidth',0.5);axis([-5 5 -0.1 1.2]);hold on;
title('对比','fontsize',18);
l1 = legend('原信号','未矫正','矫正后');
set(l1,'FontSize',18);

figure(3);
plot(w,y,'b','linewidth',0.5);axis([-1.4195 -1.415 0.0965 0.0978]);hold on;
plot(w,x1w,'k','linewidth',0.5);axis([-1.4195 -1.415 0.0965 0.0978]);hold on;
plot(w,x2w,'r','linewidth',0.5);axis([-1.4195 -1.415 0.0965 0.0978]);hold on;
title('局部放大','fontsize',18);
l2 = legend('原信号','未矫正','矫正后');
set(l2,'FontSize',18);