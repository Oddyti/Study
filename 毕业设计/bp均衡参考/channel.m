function [y,len]=channel(x,snr_in_dB)
SNR=exp(snr_in_dB*log(10)/10);    %信噪比真值转换
sigma=1/sqrt(2*SNR);              %高斯白噪声的标准差
%指定信道的ISI参数，可以看出此信道质量还是比较差的
actual_isi=[1 -0.063 0.088 -0.126 -0.25 0.9025 0.25 0 0.126 0.038 0.088];
% actual_isi=[1 0.18 0.35 0.18 -0.25];
len_actual_isi = length(actual_isi);
len = len_actual_isi;
y=conv(actual_isi,x);               %信号通过信道，相当于信号序列与信道模型序列作卷积
%需要指出，此时码元序列长度变为N+len-1，译码时我们从第len个码元开始到N+len个结束
for i=1:2:(size(y,2) + 1),       
    [noise(i) noise(i+1)]=gngauss(sigma);   %产生噪声
end;
y = y + noise(1:length(y));                            %叠加噪声
end