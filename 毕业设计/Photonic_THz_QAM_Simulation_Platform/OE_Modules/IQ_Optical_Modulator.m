function E_sig = IQ_Optical_Modulator(Sig, Clipping, Vac, Vpi, Phi_off, E_laser, Fs_awg, Lamda, E_LO_laser, F_THz, C_Light, draw)
    %> @IQ-MZM光调制器函数

    %> @Sig, MZM调制的基带信号
    %> @Clipping, 基带放大器饱和裁剪比例
    %> @Vac, Vpp峰峰值大小（归一化）
    %> @Vpi, MZM调制器Vpi值
    %> @Phi_off, IQ失衡度数
    %> @E_laser, 驱动MZM的激光器光场
    %> @Fs_awg, AWG采样率
    %> @Lamda, 激光器波长
    %> @E_LO_laser, 本振激光器光场
    %> @F_THz, 太赫兹载波频率
    %> @C_Light, 光速

    %> @E_sig, 基带调制光信号

    % uiwait(msgbox('进入发送端光调制(IQ光调制器)','提示','help'));
    close all;
    fprintf(1, [' #   IQ光调制器建模中------ ' '\n']);
    fprintf(1, [' ---------------------------\n']);

    Sig_Real = real(Sig); % QAM基带信号的实部
    % QAM基带信号的实部裁剪
    Sig_Real_Max = max(Sig_Real);

    for i = 1:length(Sig_Real)

        if Sig_Real(i) > Sig_Real_Max * Clipping
            Sig_Real(i) = Sig_Real_Max * Clipping;
        end

    end

    Sig_Imag = imag(Sig); % QAM基带信号的虚部

    % QAM基带信号的虚部裁剪
    Sig_Imag_Max = max(Sig_Imag);

    for i = 1:length(Sig_Imag)

        if Sig_Imag(i) > Sig_Imag_Max * Clipping
            Sig_Imag(i) = Sig_Imag_Max * Clipping;
        end

    end

    Sig_Real_N = Vac / max(abs(Sig_Real + 1i * Sig_Imag)) .* Sig_Real; % 实部归一化
    Sig_Imag_N = Vac / max(abs(Sig_Real + 1i * Sig_Imag)) .* Sig_Imag; % 虚部归一化

    Voff = Vpi * (2/2) + 0 * Vpi; % 偏置电压，2/2确保载波抑制

    MZM_I = cos(pi / 2 .* (Sig_Real_N + Voff) ./ Vpi); % MZM-I臂信号
    MZM_Q = cos(pi / 2 .* (Sig_Imag_N + Voff) ./ Vpi); % MZM-Q臂信号

    MZM_mod = MZM_I + MZM_Q .* exp(1i * (pi / 2 + Phi_off)); % MZM调制信号

    E_sig = E_laser .* MZM_mod'; % MZM输出的基带调制光信号

    if draw
        % 基带QAM调制光信号光谱(归一化)
        figure;
        Sig_draw = MZM_mod;
        datalen = length(Sig_draw);
        fplot = linspace(1 / (Lamda / C_Light) - Fs_awg / 2, 1 / (Lamda / C_Light) + Fs_awg / 2, datalen);
        FFT_Ex_1 = fftshift(fft(Sig_draw));
        FFT_Ex = abs(FFT_Ex_1) / (length(Sig_draw));
        FFT_Ex_dB = 10 * log10(FFT_Ex .^ 2);
        plot(fplot ./ 1e9, FFT_Ex_dB, 'r');
        title('基带QAM调制光信号光谱(归一化)', 'FontSize', 12);
        xlabel('频率（GHz）');
        ylabel('功率（dB）');
        xlim([1 / (Lamda / C_Light) - Fs_awg / 2 1 / (Lamda / C_Light) + Fs_awg / 2] / 1e9);
        scnsize = get(0, 'ScreenSize');
        set(gcf, 'position', [scnsize(3) / 2 - scnsize(4) * 3/4, scnsize(4) / 4, scnsize(4) / 2, scnsize(4) / 3]); % 绘图区位置

        % 耦合信号光谱(归一化)
        figure;
        Sig_draw = E_sig + E_LO_laser;
        datalen = length(Sig_draw);
        fplot = linspace(1 / (Lamda / C_Light) - Fs_awg, 1 / (Lamda / C_Light) + F_THz + Fs_awg, datalen);
        FFT_Ex_1 = fftshift(fft(Sig_draw));
        FFT_Ex = abs(FFT_Ex_1) / (length(Sig_draw));
        FFT_Ex_dB = 10 * log10(FFT_Ex .^ 2);
        plot(fplot ./ 1e9, FFT_Ex_dB, 'm');
        title('耦合信号光谱(归一化)', 'FontSize', 12);
        xlim([1 / (Lamda / C_Light) - Fs_awg + (F_THz + Fs_awg * 2) / 12 1 / (Lamda / C_Light) + F_THz + Fs_awg] / 1e9);
        xlabel('频率（GHz）');
        ylabel('功率（dB）');
        set(gcf, 'position', [scnsize(3) / 2 - scnsize(4) / 4 + 2, scnsize(4) / 4, scnsize(4) / 2, scnsize(4) / 3]); % 绘图区位置

    end

end
