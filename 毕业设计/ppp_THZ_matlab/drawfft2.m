function drawfft2(data, fs, figure_count)
    Ts = 1/fs;
    L = length(data);
    t = (1:L)*Ts;
    y = fftshift(fft(data));
    fshift = (-L/2:L/2-1)*(fs/L);
    figure(figure_count);
    subplot(2,1,1);
        plot(t,real(data));
        xlim([1, 100]*1e-15);
    subplot(2,1,2);
        plot(fshift,abs(y));
        xlim([0,0.01]*1e14);
end