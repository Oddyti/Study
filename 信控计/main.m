% 读指令
    % cmd: 指令音频数据， fs: 采样频率
    [MyAudio, fs] = audioread(MyAudio.flac);
    % cmd指令时频图
    AudioLength = length(MyAudio);
    t = (0:AudioLength-1)/fs;
    fft_MyAudio = fft(MyAudio, fs);
    f = fs*(0:fs/2-1)/fs;
    OrignFigure = figure(1);
        subplot(1, 2, 1);
        plot(t, MyAudio);
        title('原始语音指令频谱');

        subplot(1, 2, 2);
        plot(f, abs(fft_MyAudio(1:fs/2)));
        title('原始语音指令');
% 

%  量化
    % 量化bit
    qN = 8;
    [qt_MyAudio, q]
