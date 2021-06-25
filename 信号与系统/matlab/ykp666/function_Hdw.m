function Hd = Hdw(w)
%滤波器频率响应
sum1=0;
for n=1:1:N
sum1=sum1+2*h(n)*cos(n*w*T);
end
Hd=sum1+h(0);
end

