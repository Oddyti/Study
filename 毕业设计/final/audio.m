clc 
clear 
y = 0: 50000 ; 
Fs = 16000; 
R = audiorecorder(Fs, 16 ,2) ;
disp('Start')
recordblocking(R,1);
disp('End');
cmd = getaudiodata(R);
audiowrite('MyAudio.flac', cmd, Fs);
[pyr , fs ] = audioread('MyAudio.flac');
L       = length(pyr) ;  
%sound(pyr,64000)     ;
FFT_sig = fft(pyr,fs)   ;
ts      =  (0:L-1) /fs  ; %  The moment of the raw data point 
xf      = fs/(length(pyr) - 1)          ;
xf1     = xf*(0:length(FFT_sig) - 1)    ; % Frequency scale on the frequency domain diagram 
subplot(2 ,2 ,1 )   ;
plot(xf1,abs(FFT_sig)) ; title('Spectrum of the original signal ') ;
xlabel('Time/s' )   ;   ylabel('Amplitued') ;
subplot(2 ,2,3  )   ;
plot(ts ,pyr)       ;


t_y1    = (L -1) / (4*fs)       ;
x1      = 0 : t_y1: L           ; % sampling frequency 
y1      = 5 * sin(x1*8000*pi)   ;    
sig_2   = y1 ;
length(sig_2)
t   = (0:length(sig_2))/fs  ; 
%hold on     ;
min = 999   ; max = -999    ; 
M   = 8     ;
for i = 1 :length(sig_2)  % Get the maximum and minimum values of the  data 
    if(sig_2(i) < min)
        min = sig_2(i)    ;
    end
    if(sig_2(i) > max)
        max = sig_2(i)    ;
    end
end
det = (max - min) / M     ; % Obtain a quantitative scale 
m   = zeros(1,M)          ; 
for i = 1:M
    m(i) = min + i * det  ; % Quantitative value 
end
qv      = zeros(1,floor(L)) ;
node    = [min - 0.0001 , m(1:M-1) ,max + 0.0001]   ;
display(node(1));
for i   = 1:length(sig_2) % Quarntify data 
    for j = 1:M
        if(node(j) < sig_2(i) && sig_2(i) <= node(j + 1))
            qv(i) = (node(j) + node(j + 1) ) / 2 ;
        end
    end
end 

subplot(2,2,4)
% plot(t(1:length(sig_2)) ,qv(1:length(sig_2)) ,'b') ;
plot(t(1:length(sig_2)) ,qv(1:length(sig_2)) ,'b');

% Spectrogram
FFT_qv  = fft(qv,fs) ;
xf_qv   = fs/(length(qv) - 1 )          ;
x_qv    = xf_qv*(0 : length(FFT_qv) -1 );
subplot(2,2,2)
plot(x_qv , abs(FFT_qv)) 
title('Spectrum of the original signal ')   ;
xlabel('Time/s' )   ;   ylabel('Amplitued') ;
figure 
subplot(2,1,1)
plot(qv,'b')
axis([0 200 -5 5]);
subplot(2,1,2)
plot(y1,'r')
axis([0 200 -5 5]);



