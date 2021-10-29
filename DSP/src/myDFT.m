function Xk = myDFT(xn , N)
    n = [0:1:N-1];
    k = [0:1:N-1];
    WN = exp(-j*2*pi/N);
    Wnk = WN.^(n'*k);
    Xk = xn*Wnk;
end