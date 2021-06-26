ws=2*pi/1000;
w=-4:ws:4;%hr[n]的采点
N=2*pi/ws;
n=1:1:N;
T=0.0001*2*pi;
t=-10:T:10;
y1=x(t);
y2=fft(y1);
%subplot(2,1,1);
%plot(t,y2);
%H1=Hw(w,T);
Hd1=Hdw(w,T);
Hr1=Hrw(w);
subplot(3,1,1);
plot(w,Hd1);
subplot(3,1,2);
plot(w,Hr1);
%h1=hn(n);
%H_final=H1*Hd;
%y3=conv(y1,h1);
%plot(w,y3);
h1=hn(n);
subplot(3,1,3);
plot(n,h1);
function y = x (t)
y =sin (2*pi*t)+sin(20*pi*t);
end

function H = Hw(w,T)
%零阶保持滤波器
H =T*sin(w*T/2)/(w*T/2);
end

%M定为1000
function h = hn(n)
%离散滤波器单位冲激响应
sum=0;
for i=1:1:5000
sum=sum+(i.*pi./(10000))./sin(i.*pi./10000).*cos(i.*n.*pi./(5000));
end
h=(1/5000).*(1./2 + sum);
end

function Hd = Hdw(w,T)
%滤波器频率响应
sum1=0;
for n=1:1:1000
sum1=sum1+2.*hn(n).*cos(n.*w.*T);
end
Hd=sum1+hn(0);
end

function Hr = Hrw(w)
%连续域上滤波器频谱
Hr=w.*0.0001.*2.*pi./2./sin(w.*0.0001.*2.*pi/2);
end
