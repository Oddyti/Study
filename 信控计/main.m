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
    q = (1-(-1))/2^qN;
    qAudio = floor((MyAudio + 1)/q);
% 

%  信源编码
    % unique函数：对数组按升序排序，并去掉多余的重复的值
    % cell数组：元胞数组，每个单元可以储存不同类型的变量
    % numel(A)函数：Numbers of Elements返回数组A中元素的个数
    % find(A = b)：返回一个列向量，记录了数组A中等于b的元素的位置（按列数）

    len = length(qAudio);
    unique_x = unique(qAudio);
    unique_len = length(unique_x);

    symbols = cell(1, unique_len);
    p = zeros(1, unique_len);

    for i = 1:unique_len
        symbols{1,i} = unique_x(i);
        p(i) = numel(find(qAudio==unique_x(i))) / len;
    end

    [dict, avglen] = huffmandict(symbols, p);

    source_encode = huffmanenco(qAudio, dict);
% 
% 信道编码
    