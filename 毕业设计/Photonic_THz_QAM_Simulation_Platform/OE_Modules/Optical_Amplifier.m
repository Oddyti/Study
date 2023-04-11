function E_sig_n = Optical_Amplifier(E_sig, OSNR_dB, Noise_BW, Fs_awg, Lamda, C_Light, E_LO_laser, F_THz, draw)
    %> @光放大器函数（含光滤波器）

    %> @E_sig, 基带调制光信号
    %> @OSNR_dB, 光信噪比（单位dB）
    %> @Noise_BW, 噪声带宽
    %> @Fs_awg, AWG采样率
    %> @Lamda, 激光器波长
    %> @E_LO_laser, 本振激光器光场
    %> @F_THz, 太赫兹载波频率
    %> @C_Light, 光速

    %> @E_sig_n, 光放大器→滤波器后输出的光信号

    fprintf(1, [' #   光放大器与滤波器建模中------ ' '\n']);
    fprintf(1, [' ---------------------------\n']);

    OSNR = 10 ^ (OSNR_dB / 10);
    P_sig = mean(abs(E_sig) .^ 2);

    noise_power = (P_sig * Fs_awg) / (2 * Noise_BW * OSNR * 2);
    N = length(E_sig);
    n = 1:N;
    noise = wgn(1, N, noise_power, 'complex', 'linear');
    complex_noise = noise .* exp(1i * (2 * pi * 1 / (Lamda / C_Light) .* n) / Fs_awg);
    E_sig_n = complex_noise + E_sig;

    if draw
        % 引入光噪声后耦合信号光谱(归一化)
        figure;
        Sig_draw = E_sig_n + E_LO_laser;
        datalen = length(Sig_draw);
        fplot = linspace(1 / (Lamda / C_Light) - Fs_awg, 1 / (Lamda / C_Light) + F_THz + Fs_awg, datalen);
        FFT_Ex_1 = fftshift(fft(Sig_draw));
        FFT_Ex = abs(FFT_Ex_1) / (length(Sig_draw));
        FFT_Ex_dB = 10 * log10(FFT_Ex .^ 2);
        plot(fplot ./ 1e9, FFT_Ex_dB, 'black');
        title('引入光噪声后耦合信号光谱(归一化)', 'FontSize', 12);
        xlim([1 / (Lamda / C_Light) - Fs_awg + (F_THz + Fs_awg * 2) / 12 1 / (Lamda / C_Light) + F_THz + Fs_awg] / 1e9);
        xlabel('频率（GHz）');
        ylabel('功率（dB）');
        scnsize = get(0, 'ScreenSize');
        set(gcf, 'position', [scnsize(3) / 2 + scnsize(4) / 4 + 4, scnsize(4) / 4, scnsize(4) / 2, scnsize(4) / 3]); % 绘图区位置
    end

end
