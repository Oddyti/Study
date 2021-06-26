T = 0.1;           % 采样周期
fs = 1/T;           % 采样频率
ws = 2 * pi / T;    % ws
N = 512;           % 采样点数目
M = 2048;           % FIR 采样点数目 
n = 0:1:N-1;
t = n * T *0.1;
t1 = n * T ;        % 冲击采样

x=sin(pi *t); % 源信号

xp=sin(pi* t1);  % 冲激采样 x[n]

xw = fft(x,N);

xw = fftshift(xw);

xw = abs(xw);                     % 源信号频谱



xpw = fft(xp,N);

xpw = fftshift(xpw);

xpw = abs(xpw);                           % 冲激采样频谱

f = n * fs/N;                      
f1 = n * fs/N - fs/2;

% 零阶保持频谱
H0w = Hw(f1,T);
x0w = xpw * H0w;




subplot(3,2,1);plot(t,x);       axis([0 6 -1.2 1.2]); ylabel('原信号');grid on;
subplot(3,2,2);plot(f1,xw);     ylabel('原信号频谱');grid on;
subplot(3,2,3);stem(t1,xp);     axis([0 6 -1.2 1.2]);ylabel('原信号冲激采样');grid on;
subplot(3,2,4);plot(f1,xpw);    ylabel('原信号冲激采样频谱');grid on;
subplot(3,2,5);plot(f1,x0w);     ylabel('零阶保持频谱');grid on;
subplot(3,2,6);plot(f1,H0w);     ylabel('零阶保持频谱');grid on;