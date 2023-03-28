function [Eout,est_f_off]= Freq_Offset_Comp(Ein,R,Fb)
%> @ÆµÆ«¹À¼Æº¯Êý£¨º¬ÆµÆ«²¹³¥ÓëÏàÎ»ÔëÉù²¹³¥£©

%% rotate constellation so that 4th power end in 0 not pi
Ph_rot = exp(1i*pi/4);
Ph_rec = exp(-1i*pi/4);
Ein_rot = Ein*Ph_rot;
N = size(Ein_rot,1);
T = 1/Fb;
f = (0:N-1)'/Fb;
%% partitioning and 4-power frequency estimation
C13 = zeros(N,1);
% Select classes
for n=1:N
    A = abs(Ein_rot(n));
    [~,i] = min(abs(R-A),[],1);
    if i==1 || i==3
        C13(n) =  Ein_rot(n);
    end
end
% Select non-zero indices
ind1 = find(C13);
% Class 1 and 3 symbols
Sym_13 = C13(ind1);
% 4-fold and phase tracking
Theta_est = angle((Sym_13./abs(Sym_13)).^4);
Theta_est = unwrap(Theta_est)/4;
%% frequency offset estimation and recovery compensation
Theta_est_shift = circshift(Theta_est,1);
ind_shift = circshift(ind1,1);
delt_Theta = Theta_est(2:end)-Theta_est_shift(2:end);
delt_ind = ind1(2:end)-ind_shift(2:end);
Average_delta_Theta = mean(delt_Theta./delt_ind);
est_f_off = Average_delta_Theta/(2*pi*T);
print_str = ' >   ÆµÂÊÆ«ÒÆ¹À¼ÆÖµÎª %0.0f MHz\n';
fprintf(print_str,vpa(est_f_off/1e6,4));
Eout = Ein_rot.*exp(-2i*pi*f*est_f_off)*Ph_rec;
end