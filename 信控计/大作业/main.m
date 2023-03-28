clear;
clc;
close all;
%% 录制语音信号
    % 采样频率16000Hz，采样位数16bits，通道数1，录音时长1s
    Fs = 48000; 
    R = audiorecorder(Fs, 16 ,1) ;
    disp('Start')
    recordblocking(R,2);
    disp('End');
    cmd = getaudiodata(R);
    audiowrite('MyAudio.flac', cmd, Fs);
    
%% 指令读取
    [MyAudio1, fs] = audioread('MyAudio.flac');
    AudioLength1 = length(MyAudio1);
    MyAudio = MyAudio1(30000:60000);
    AudioLength = length(MyAudio);
    t = (0:AudioLength-1)/fs;
    fft_MyAudio = fft(MyAudio, fs);
    f = fs*(0:fs/2-1)/fs;
    f1 = figure(1);
    subplot(211);
    plot(t, MyAudio);
    title('原始语音指令','Fontsize', 16);
    xlabel('Time(s)');ylabel('Amplitude(V)');
    subplot(212);
    plot(f, abs(fft_MyAudio(1:fs/2)));
    title('原始语音指令频谱','Fontsize', 16);
    xlabel('Frequency(Hz)');ylabel('Amplitude');

%  量化
    % 量化bit
    [Vmax, ~] = max(MyAudio);
    [Vmin, ~] = min(MyAudio);
    qN = 4;
    q = (Vmax-(Vmin))/(2^qN-1);
    qAudio = [];
    for i = 1:AudioLength
        temp = (MyAudio(i)+Vmax)/q;
        qAudio = [qAudio; floor(temp)];
    end

    qMin = min(qAudio);
    qAudio2 = qAudio - qMin;
    tx_bit_audio = [];
    flag = [];
    for i = 1:length(tx_bit)
        temp = dec2bin(qAudio2(i),4)';
        temp = str2num(temp);
        if length(temp) > 4
            flag = [flag, i];
        end
        tx_bit_audio = [tx_bit_audio; temp];
    end
    
    tx_bit_aduio = tx_bit_audio(20000:52767);
    save tx_bit_aduio.mat tx_bit_aduio;
    
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
    fprintf('----- Source Encode -----\n');
    fprintf('平均码长 : %f\n', avglen );
    fprintf('信源熵 : %f\n', sum(p.*(-log2(p))) );
    fprintf('编码效率 : %f\n', 1/sum(p.*(-log2(p))) );
    fprintf('编码前字符串总长度 : %d\n', len*qN);
    fprintf('编码后字符串二进制总长度 : %d\n', length(source_encode));
    fprintf('压缩率 : %f\n', len*qN/length(source_encode));

% 信道编码
    % 使用了matlab自带的卷积码的函数生成卷积码
    % trellis = poly2trellis(ConstraintLength，CodeGenerator)，其中trellis是一个网格表，用来规定我们使用的卷积编码的规则，ConstraintLength是描述每一路输入的长度，CodeGenerator描述输入和模2加法器的连接关系（8进制计数），此处用了（2，1，7）卷积编辑器规则
    % code = convenc(source_encode, trellis)输出编码后的序列
    trellis = poly2trellis(7, [171 133]);
    channel_encode = convenc(source_encode, trellis);
    fprintf('----- Channel Encode -----\n');
    fprintf('信道编码前字符串长度 : %d\n', length(source_encode));
    fprintf('信道编码后字符串长度 : %d\n', length(channel_encode));
    fprintf('编码速率：%.1f\n',length(source_encode)/length(channel_encode));


% BPSK调制解调
    % 选用了二进制相移键控BPSK进行调制，并加入了高斯白噪声，信噪比为10dB
    bpsk_out = pskmod(channel_encode,2);
    awgn_out = awgn(bpsk_out, 10);
    % 仍然使用pskmode 函数进行解调
    demodulation_out = pskdemod(awgn_out,2);
    % 计算错误率
    [erros, ratio] = biterr(demodulation_out, channel_encode);
    fprintf('-------- Modulation --------\n');
    fprintf('调制解调出错数 : %d\n', erros);
    fprintf('调制解调误码率 : %f\n', ratio);

% 信道译码
    channel_decode = vitdec( demodulation_out,trellis,32,'trunc','hard');
    % 计算错误率
    [erros2, ratio2] = biterr(channel_decode, source_encode);
    fprintf('-------- Channel Decode --------\n');
    fprintf('信道译码出错数 : %d\n', erros2);
    fprintf('信道译码误码率 : %f\n', ratio2);

% 信源译码
    source_decode=huffmandeco(channel_decode,dict);
    % 计算错误率
    [erros3, ratio3] = biterr(source_decode, qAudio);
    fprintf('-------- Source Decode --------\n');
    fprintf('信源译码出错数 : %d\n', erros3);
    fprintf('信源译码误码率 : %f\n', ratio3);
% 信号重建
    restore_out  =  source_decode * q - 1;
    fprintf('-------- Mean Square Erro --------\n');
    fprintf('均方误差: %f\n', mse(restore_out - MyAudio));
    audiowrite('Restore_MyAudio.flac', restore_out, fs);


% 对比图
    figure(2);
    subplot(211);
    plot(t, MyAudio, 'b')
    title('原始语音指令信号','Fontsize', 16);
    xlabel('Time(s)');ylabel('Amplitude(V)');
    subplot(212);
    plot(t, restore_out, 'b')
    title('重建语音指令信号','Fontsize', 16);
    xlabel('Time(s)');ylabel('Amplitude(V)');

    figure(3);
    fft_restore = fft(restore_out, fs);
    subplot(211);
    plot(f, abs(fft_MyAudio(1:fs/2)));
    title('原始语音指令信号频谱','Fontsize', 16);
    xlabel('Frequency(Hz)');ylabel('Amplitude');
    subplot(212);
    plot(f, abs(fft_MyAudio(1:fs/2)));
    title('重建语音指令信号频谱','Fontsize', 16);
    xlabel('Frequency(Hz)');ylabel('Amplitude');

% 语音识别
    load('commandNet.mat');
    auditorySpect = helperExtractAuditoryFeatures(restore_out,fs);
    command = classify(trainedNet,auditorySpect);
    fprintf('-------- Speech Recognition --------\n');
    fprintf("识别结果：%s\n", command);