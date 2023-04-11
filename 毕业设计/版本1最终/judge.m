function sig_judge = judge(sig)
    sig_judge = zeros(1,length(sig));
    Constellation =[3+3j 3+1j 1+3j 1+1j 3-3j 3-1j 1-3j 1-1j -3+3j -3+1j -1+3j -1+1j -3-3j -3-1j -1-3j -1-1j];
    for i = 1:length(sig)
        [~,j]=min(abs(Constellation - sig(i)));
            sig_judge(i) = Constellation(j); 
    end
end