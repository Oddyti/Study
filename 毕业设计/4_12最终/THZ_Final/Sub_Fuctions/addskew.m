function sigout=addskew(sigin,skew,Fs)
%> @添加时域skew子函数

isitreal = isreal(sigin);
if ~isitreal
    sig=[real(sigin(:)) imag(sigin(:))];
else
    sig=sigin(:);
end
for i=1:size(sig,2)
    sig=sig(:,i)';
    Npoints=length(sig);
    freqGrid=[0:(Npoints/2) (-Npoints/2+1):1:-1]/Npoints;
    
    SkewPhase=exp(1i*2*pi*skew*Fs*freqGrid);
    SIGIN=fft(sig);
    SIGOUT=SIGIN.*SkewPhase;
    sigo=real(ifft(SIGOUT));
    sigout(:,i)=sigo(:);
end
if ~isitreal
    sigout = sigout(:,1) + 1i*sigout(:,2);
end
end