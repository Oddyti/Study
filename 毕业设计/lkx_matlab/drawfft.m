function drawfft(data, fs, figure_count, figtitle)
    Ts = 1/fs;
    L = length(data);
    t = (1:L)*Ts;
    y = fftshift(fft(data));
    fshift = (-L/2:L/2-1)*(fs/L);
    figure(figure_count);
    subplot(2,1,1);
        plot(t,real(data));
        xlim([1, 100]*1e-15);
        title(figtitle);
    subplot(2,1,2);
        plot(fshift,abs(y));
        title(figtitle);
end