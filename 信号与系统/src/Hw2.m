% 理想的矫正滤波器Hr(jw)
function H = Hw2(w,T)
    H = (w.*T./2)./(sin(w.*T./2));
end