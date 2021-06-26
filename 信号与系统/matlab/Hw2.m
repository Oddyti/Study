function H = Hw2(w,T)
    %连续时间系统Hr(jw) 即待重建的
    H = (w.*T./2)./(sin(w.*T./2));
end