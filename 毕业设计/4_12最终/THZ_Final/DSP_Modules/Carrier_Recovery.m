function [E_CPR,freq_off] = Carrier_Recovery(E_est,BPS_PAR,BPS_N,M,Fb,draw)
%> @载波恢复函数（含频偏补偿与相位噪声补偿）

%> @E_est, 均衡器输出
%> @BPS_PAR, 相位估计粒度
%> @BPS_N, 块大小
%> @M, QAM信号阶数

uiwait(msgbox('进入接收端DSP(载波恢复)','提示','help'));
close all;
fprintf(1,[' #   相噪补偿计算中------ ' '\n']);
fprintf(1,[' #   并行计算开启中------ ' '\n']);

E_in = modnorm(E_est(:), 'avpow', 1)* E_est;

const = qammod([0:M-1],M);
Constellation = modnorm(const(:),'avpow',1) * const;
Constellation = Constellation';
R = uniquetol( abs(Constellation), 1e-8 );

B = BPS_PAR;
b = (0:B-1)';
gamma = pi/2; % square QAM with symmetry use pi/2 | no symmetry use 2*pi
phi_b = (b/(B-1))*gamma-pi/4;
N = BPS_N;

% [E_fr,freq_off] = Freq_Offset_Comp(E_in,R,Fb); % 频率偏移估计
freq_off = 0;
E_fr=E_in;
PConstellation=Constellation*(exp(-1i*phi_b).');

d = zeros(B,length(E_fr));
parfor k = 1:length(E_fr)
    [d(:,k),~] = min(bsxfun(@minus,PConstellation,E_fr(k)));
end
d = (abs(d)).^2;

% 滑动窗口平均
s = zeros(B,length(d)-2*N-1);
for k = N+1:1:length(d)-N-1
    s(:,k-N) = sum(d(:,k-N:k+N+1),2);
end
[~,indb]= min(s);

%% 相位恢复
Theta_est = -unwrap(phi_b(indb)*4)/4;
E_fr = E_fr(:);
E_fr = E_fr(N+1:end-N-1);
E_cpr = -E_fr.*exp(-1i*Theta_est);

E_CPR = modnorm(E_cpr(:), 'avpow', 1)* E_cpr;

if draw
    figure;
    scatter(real(E_est),imag(E_est),1,'Marker','o');title('载波恢复前的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2-scnsize(4)/2-1,scnsize(4)/4-20,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
    
    figure;
    scatter(real(E_CPR),imag(E_CPR),1,'Marker','o');title('载波恢复后的星座图');
    scnsize = get(0,'ScreenSize');
    set(gcf,'position',[scnsize(3)/2+1,scnsize(4)/4-20,scnsize(4)/2,scnsize(4)/2]); % 绘图区位置
end
fprintf(1,[' ---------------------------\n']);
end

