function E_Dec = Time_Recovery(E_Base,Fs_awg,Fs,Fb,Nsym,txrolloff,Nss,draw)
%> @时钟同步与恢复函数

%> @E_Base, 基带信号电场
%> @delta_t, 一个符号的时间周期
%> @Fs, QAM信号的原始采样频率
%> @Fb, QAM信号的波特率
%> @Nsym, 脉冲成型截断的符号范围
%> @txrolloff, 脉冲成型的滚降系数，取值0~1之间，决定频宽和陡峭程度
%> @Nss = Fs/Fb, QAM信号的原始采样频率下的过采样率

%> @E_Dec, 时间同步后的信号

% uiwait(msgbox('进入接收端DSP(时钟同步)','提示','help'));
close all;
fprintf(1,[' #   时钟同步计算中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

%% Gardner重采样算法
% dt_rec = Fs_awg/Fs;
% nom_v = round(Fs_awg/Fb);
% 
% t_new = 1:dt_rec:length(E_Base);
% 
% step = 0.03;
% var = linspace(0,1,1/step);
% var = var(1:end-1);
% L_temp = length(E_Base)/dt_rec;
% 
% PD_gardner = inf(size(var));
% 
% y = real(E_Base(1:L_temp));
% x = 1:L_temp;
% 
% t_new = t_new(1:L_temp);
% 
% for a_c = 1:length(var)
%     Toff = var(a_c)*nom_v;
%     I = interp1(x,y,t_new+Toff,'linear');
%     PD_gardner(a_c) = mean( I(2:2:L_temp-1) .* (I(3:2:L_temp)-I(1:2:L_temp-2)) );
% end
% 
% [~,PD_min] = min( abs(PD_gardner).^2 );
% Toff = var(PD_min)*nom_v;
% out = interp1(E_Base,t_new+Toff,'spline',0);

out = resample(E_Base,Fs,Fs_awg); % （备用对比）MATLAB自带的重采样算法

%% 匹配滤波
shapeFilter  = fdesign.pulseshaping(Fs/Fb, 'Square Root Raised Cosine','Nsym,beta', Nsym, txrolloff, Fs);
Hd = design(shapeFilter);
E_mflt = filter(Hd,out);

%% 时间抽取
E_dec_real = Decimator(real(E_mflt),Nss);
E_dec_imag = Decimator(imag(E_mflt),Nss);

%% 信号输出
E_Dec = E_dec_real + 1i*E_dec_imag;

if draw
    figure;
    scatter(real(E_Base),imag(E_Base),1,'Marker','o');title('时钟同步前的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)/4-20,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
    
    figure;
    scatter(real(E_Dec),imag(E_Dec),1,'Marker','o');title('时钟同步后的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2+1,scnsize(4)/4-20,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
end

end
