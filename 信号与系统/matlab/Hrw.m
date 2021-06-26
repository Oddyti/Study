% 重建后的FIR Hr'(jw)
function H = Hrw(w,T)
    sum = 0;
    N =5000;
    for n = 1:1:N
        sum = sum + hrn(n).*cos(n.*w.*T);
    end
    H = hrn(0) + 2.*sum;
end