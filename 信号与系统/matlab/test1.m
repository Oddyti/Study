T = 0.01;           % 采样周期
fs =1/T;           % 采样频率
ws = 2 * pi / T;    % ws
N = 256;           % 采样点数目
M = 2048;           % FIR 采样点数目 
n = 0:1:N-1;
t = n * T *0.1;
t1 = n * T ;        % 冲击采样
x=0.5*sin(2*pi*t)+2*sin(2*pi*10*t); % 源信号

xp=0.5*sin(2*pi*t1)+2*sin(2*pi*10*t1);  % 冲激采样 x[n]

xw = fft(x,N);

xw = fftshift(xw);

xw = abs(xw);                     % 源信号频谱



xpw = fft(xp,N);

xpw = fftshift(xpw);

xpw = abs(xpw);                           % 冲激采样频谱

f = n * fs/N;                 
f1 = n * fs/N - fs/2;

% 零阶保持频谱
How = Hw(f1,T);

%理想的矫正滤波器Hr(jw)
H1w = Hw2(f1,T); 

% 重建Hr'(jw)
H1w_new = Hrw(f1,T); %重建后的矫正滤波器频谱

% 联合H(jw) 重建后的联合滤波 离散预矫正
Hjw = How .* H1w_new;



x1w = xpw .* How /T;   %未矫正频域直接D/A输出



x2w=xpw.*Hjw./T; %xw重建矫正滤波器后的频域波形

subplot(5,2,1);plot(t,x);title('原信号');axis([0 0.5 -3 3]);grid on;
subplot(5,2,2);plot(f1,xw);title('原信号频谱');axis([-40 40 0 800]);grid on;
subplot(5,2,3);stem(t1,xp);title('原信号冲激采样');axis([0 0.5 -3 3]);grid on;
subplot(5,2,4);plot(f1,xpw);title('原信号冲激采样频谱');axis([-40 40 0 800]);grid on;

subplot(5,2,5);plot(f1,H1w);title('理想的矫正滤波器Hr(jw)');
subplot(5,2,6);plot(f1,H1w_new);title('重建Hr"(jw)');
subplot(5,2,7);plot(f1,Hjw);title('重建后的联合滤波');grid on;

subplot(5,2,8);plot(f1,x1w);title('未矫正频域');axis([-40 40 0 800]);grid on;
subplot(5,2,9);plot(f1,x2w);title('重建矫正后频域');axis([-40 40 0 800]);grid on;

%subplot(4,2,5);plot(f1,Hw);title('零阶保持响应频谱');%axis([-40 40 0 0.1]);grid on;
%subplot(4,2,6);plot(f1,x1w);title('理想矫正后频域');axis([-40 40 0 800]);grid on;


%subplot(4,2,6);plot(f1,x0w);title('零阶保持频谱');%axis([-40 40 0 1]);grid on;
%axis([-40 40 0 800]);grid on;

