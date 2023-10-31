function E_Base_IQC = IQ_Imbalance_Comp(E_Base)
%> @IQ失衡补偿函数

%> @该算法主要基于Gram-Schmidt算法
%> @E_Base, 基带信号电场
%> @E_Base_IQC, IQ失衡补偿后的基带信号电场

fprintf(1,[' #   IQ失衡补偿计算中------ ' '\n']);
fprintf(1,[' ---------------------------\n']);

I = real(E_Base);
Q = imag(E_Base);

rho = mean(I.*Q); % I路与Q路相关值

% I路功率归一化
L_I = length(I);
absxsq_I = I.*conj(I);        
E_I = sum(absxsq_I);
P_I = E_I/L_I;

Q = Q - rho*I/P_I;

% Q路功率归一化
L_Q = length(Q);
absxsq_Q = Q.*conj(Q);        
E_Q = sum(absxsq_Q);
P_Q = E_Q/L_Q;

E_Base_IQC = (I/sqrt(P_I) + 1i*Q/sqrt(P_Q))/sqrt(2);

end

