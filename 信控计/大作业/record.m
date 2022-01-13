fs = 16000; 
R = audiorecorder(fs, 16 ,1) ;
disp('Start speaking.')
recordblocking(R,1);
disp('End of Recording.');
cmd = getaudiodata(R);
audiowrite('cmd.flac', cmd, fs);