function [SigQam, SigSam] = channel(txSeq, Snr)

    Fs = 400e3;
    fc = 100e3;
    Ms = 16;
    %% 串并转换
    SigQam = qammod(txSeq, Ms,'bin','InputType','bit');
    SigQamI = real(SigQam);
    SigQamQ = imag(SigQam);

    %% 脉冲成形
    R = 0.5;            % 滚降系数
    span = 10;          % 滤波器包含符号数
    sps = 6;            % 每个符号所含采样点数
    Filter = rcosdesign(R,span,sps,'sqrt');
    SigInterpI = upsample(SigQamI, sps);
    SigInterpQ = upsample(SigQamQ, sps);
    modSigI = conv(SigInterpI, Filter, 'same');
    modSigQ = conv(SigInterpQ, Filter, 'same');

    %% 调制
    txSigI = modSigI .* cos(2 * pi * fc * (0:length(modSigI) - 1) / Fs).';
    txSigQ = modSigQ .* (-sin(2 * pi * fc * (0:length(modSigQ) - 1) / Fs)).';
    txSig = txSigI + txSigQ;

    %% AWGN信道传输
    % EbNo = 8;
    % Snr = EbNo + 10*log10(k) - 10*log10(sps);
    rxSig = awgn(txSig, Snr, 'measured');

    %% 解调
    demodSeqI = 2 * rxSig .* cos(2 * pi * fc * (0:length(rxSig) - 1) / Fs).';
    demodSeqQ = 2 * rxSig .* (-sin(2 * pi * fc * (0:length(rxSig) - 1) / Fs)).';

    %% 匹配滤波
    SigI = conv(demodSeqI.', Filter, 'same');
    SigQ = conv(demodSeqQ.', Filter, 'same');

    %% 抽样
    SigSamI = downsample(SigI, sps);
    SigSamQ = downsample(SigQ, sps);
    SigSam = SigSamI + SigSamQ*1i;

    SigQam = SigQam.';
end