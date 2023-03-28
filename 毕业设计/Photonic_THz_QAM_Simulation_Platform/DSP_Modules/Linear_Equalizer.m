function [E_est,H_taps] = Linear_Equalizer(E_Dec,Eq_type,Eq_iter,Eq_CMA_Delay,Eq_taps,Eq_mu,Eq_Adaptive_mu,Eq_conv,M,draw)
%> @线性均衡函数

%> @E_Dec, 时间同步后的信号
%> @Eq_type, 'MMA'为>4阶QAM，'CMA'为QPSK
%> @Eq_iter, 均衡迭代次数
%> @Eq_CMA_Delay, CMA 时延，可调范围为0到Nss-1
%> @Eq_taps, 滤波器抽头
%> @Eq_mu, CMA的mu值
%> @Eq_Adaptive_mu = 0; % CMA自适应更新mu值
%> @Eq_conv, CMA均衡器预设值长度
%> @M, QAM信号阶数

%> @E_est, 均衡器输出
%> @H_taps, 均衡器系数

% uiwait(msgbox('进入接收端DSP(线性均衡)','提示','help'));
close all;
fprintf(1,[' #   线性均衡计算中------ ' '\n']);

%% 算法初始化定义
Nconv_length = Eq_conv;
MMA_FLAG = false;
Niter = Eq_iter;
NumberOfTaps = Eq_taps;

Ein = modnorm(E_Dec(1+Eq_CMA_Delay:end),'avpow',1) * E_Dec(1+Eq_CMA_Delay:end); % 信号功率归一化

param_Ex = buffer(real(Ein),NumberOfTaps,NumberOfTaps-1,'nodelay');
param_Ey = buffer(imag(Ein),NumberOfTaps,NumberOfTaps-1,'nodelay');

% QAM星座归一化计算
const = qammod([0:M-1],M);
Constellation = modnorm(const(:),'avpow',1) * const;
Constellation = Constellation';

param_mu = repmat(Eq_mu,[2 2]);

% QAM星座归一化半径计算
if strcmpi(Eq_type,'CMA')
    param_R = 1;
elseif strcmpi(Eq_type,'MMA')
    param_R = uniquetol( abs(Constellation), 1e-8 );
else
    error('错误的均衡器类型: %s.',Eq_type);
end
R2 = param_R.^2;

param_H_init = zeros(2,2,NumberOfTaps);
param_H_init(:,:,ceil((NumberOfTaps+1)/2)) = [1,0; 0,1];

% 均衡的符号数量
N = floor(length(Ein)-NumberOfTaps+1);

% 滤波器参数初始化
Hxx(:,1) = squeeze(param_H_init(1,1,:));
Hyx(:,1) = squeeze(param_H_init(1,2,:));
Hxy(:,1) = squeeze(param_H_init(2,1,:));
Hyy(:,1) = squeeze(param_H_init(2,2,:));

% 输出初始化
Ex_est = nan(N,1);
Ey_est = nan(N,1);

% 均衡误差初始化
err_x = nan(N+1,1);
err_y = nan(N+1,1);

cExx=param_mu(1)*conj(param_Ex);
cEyx=param_mu(2)*conj(param_Ex);
cExy=param_mu(3)*conj(param_Ey);
cEyy=param_mu(4)*conj(param_Ey);

%% CMA / MMA 算法
for it=1:Niter
    fprintf(1,[' o   线性均衡迭代第 ' num2str(it) ' 次 ' '\n']);
    
    if it>1
        Hxx(:,1) = Hxx(:,end);
        Hyx(:,1) = Hyx(:,end);
        Hxy(:,1) = Hxy(:,end);
        Hyy(:,1) = Hyy(:,end);
    end
    
    for n=1:N
        % 计算均衡信号
        Ex_est(n) = sum(Hxx(:,n).*param_Ex(:,n) + Hxy(:,n).*param_Ey(:,n));
        Ey_est(n) = sum(Hyx(:,n).*param_Ex(:,n) + Hyy(:,n).*param_Ey(:,n));
        
        if ~MMA_FLAG && n>Nconv_length
            MMA_FLAG=true;
        end
        if MMA_FLAG % 利用MMA算法于FIR信号更新
            A = abs(Ex_est(n)); % X
            [~,i] = min(abs(param_R-A),[],1);
            err_x(n) = R2(i) - A^2;
            
            A = abs(Ey_est(n)); % Y
            [~,i] = min(abs(param_R-A),[],1);
            err_y(n) = R2(i) - A^2;
        else % 利用CMA算法于预收敛
            err_x(n) = 1 - abs(Ex_est(n))^2;
            err_y(n) = 1 - abs(Ey_est(n))^2;
        end
        
        % 更新滤波器系数
        if ~Eq_Adaptive_mu
            Hxx(:,n+1) = Hxx(:,n)+err_x(n)*Ex_est(n)*cExx(:,n);
            Hyx(:,n+1) = Hyx(:,n)+err_y(n)*Ey_est(n)*cEyx(:,n);
        else
            Hxx(:,n+1) = Hxx(:,n)+err_x(n)*Ex_est(n)*param_mu(1,1)*conj(param_Ex(:,n));
            Hyx(:,n+1) = Hyx(:,n)+err_y(n)*Ey_est(n)*param_mu(1,2)*conj(param_Ex(:,n));
        end
        
        if ~Eq_Adaptive_mu
            Hxy(:,n+1) = Hxy(:,n)+err_x(n)*Ex_est(n)*cExy(:,n);
            Hyy(:,n+1) = Hyy(:,n)+err_y(n)*Ey_est(n)*cEyy(:,n);
        else
            Hxy(:,n+1) = Hxy(:,n)+err_x(n)*Ex_est(n)*param_mu(2,1)*conj(param_Ey(:,n));
            Hyy(:,n+1) = Hyy(:,n)+err_y(n)*Ey_est(n)*param_mu(2,2)*conj(param_Ey(:,n));
        end
        
        if Eq_Adaptive_mu
            if n>1 && ~((sign(real(err_x(n)))==sign(real(err_x(n-1)))) && (sign(imag(err_x(n)))==sign(imag(err_x(n-1)))))
                param_mu(1,1)=param_mu(1,1)/(1+param_mu(1,1)*(abs(err_x(n))^2));
            elseif n>1 && ~((sign(real(err_y(n)))==sign(real(err_y(n-1)))) && (sign(imag(err_y(n)))==sign(imag(err_y(n-1)))))
                param_mu(1,2)= param_mu(1,2)/(1+param_mu(1,2)*(abs(err_y(n))^2));
            end
            param_mu(2,1) = param_mu(1,1);
            param_mu(2,2) = param_mu(1,2);
        end
    end
end

% 抽头系数输出
H_taps.xx = Hxx(:,end);
H_taps.xy = Hxy(:,end);
H_taps.yx = Hyx(:,end);
H_taps.yy = Hyy(:,end);

% 归一化
Ex_est = modnorm(Ex_est(:),'avpow',1) * Ex_est;
Ey_est = modnorm(Ey_est(:),'avpow',1) * Ey_est;

% 均衡器输出
E_est = Ex_est+1i*Ey_est;

if draw
    figure;
    scatter(real(E_Dec),imag(E_Dec),1,'Marker','o');title('线性均衡前的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)*3/8,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
    
    figure;
    scatter(real(E_est),imag(E_est),1,'Marker','o');title('线性均衡后的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2+1,scnsize(4)*3/8,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
end
fprintf(1,[' ---------------------------\n']);
end

%% Backup
% if draw
%     WND_L=300;
%     eq_err_x = conv(abs(err_x).^2,rectwin(WND_L)/WND_L,'valid');
%     eq_err_y = conv(abs(err_y).^2,rectwin(WND_L)/WND_L,'valid');
%     figure;
%     suptitle('均衡器误差（移动平均）');
%     subplot(2,1,1);plot(WND_L:length(err_x),10*log10(eq_err_x),...
%         'Color',[0 0 1]);
%     xlabel('时间, Sa');
%     ylabel('MSE误差, dB');
%     title(sprintf('%I路均衡器误差（移动平均）',WND_L));
%     subplot(2,1,2);plot(WND_L:length(err_y),10*log10(eq_err_y),...
%         'Color',[1 0 0]);
%     xlabel('时间, Sa');
%     ylabel('MSE误差, dB');
%     title(sprintf('%Q路均衡器误差（移动平均）',WND_L));
%     set(gcf,'unit','centimeters','position',[8,2,15,12]); % 绘图区位置
% end
% 
% uiwait(msgbox('进入接收端DSP(线性均衡的星座图)','提示','help'));
% close all;
