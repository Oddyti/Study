clear;
clc;
close all;

% R = audiorecorder(8000,8,1);
% disp('Start')
% recordblocking(R,8);
% disp('End');
% cmd = getaudiodata(R);
% audiowrite('MyAudio.flac', cmd, 8000);

[MyAudio, fs] = audioread('MyAudio.flac');
AudioLength = length(MyAudio);

%  量化
% 量化bit
[Vmax, ~] = max(MyAudio);
[Vmin, ~] = min(MyAudio);
qN = 4;
q = (Vmax - (Vmin)) / (2 ^ qN - 1);
qAudio = [];

for i = 1:AudioLength
    temp = (MyAudio(i) + Vmax) / q;
    qAudio = [qAudio; floor(temp)];
end

noise = downsample(qAudio, 15);
figure(1);
t = 1:length(noise);
plot(t, noise);
noise_bit = [];

for i = 1:length(noise)
    temp = dec2bin(noise(i), 4)';
    temp1 = str2num(temp);
    noise_bit = [noise_bit; temp1];
end

save noise_bit.mat noise_bit;
