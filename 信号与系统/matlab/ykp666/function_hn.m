function h = hn(n)
%离散滤波器单位冲激响应
sum=0;
for i=1:1:M
sum=sum+(i*pi/(2*M))/sin(i*pi/2/M)*cos(i*n*pi/M);
end
h=1/2/M+sum;
end

