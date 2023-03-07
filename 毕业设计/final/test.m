%% 画图
color1 = [104 8 123];
color2 = [34 139 34];
color3 = [210 105 39];
figure(1);
x = 0:12;
plot(x, err_ratio_all(1,:),'-o','color',color1/255,'linewidth',2);hold on;
plot(x, err_ratio_all(2,:),'-+','color',color1/255,'linewidth',2);hold on;
plot(x, err_ratio_all(3,:),'-*','color',color1/255,'linewidth',2);hold on;
plot(x, err_ratio_all(4,:),'-x','color',color2/255,'linewidth',2);hold on;
plot(x, err_ratio_all(5,:),'-s','color',color2/255,'linewidth',2);hold on;
plot(x, err_ratio_all(6,:),'-d','color',color2/255,'linewidth',2);hold on;
plot(x, err_ratio_all(7,:),'-^','color',color3/255,'linewidth',2);hold on;
plot(x, err_ratio_all(8,:),'-p','color',color3/255,'linewidth',2);hold on;
plot(x, err_ratio_all(9,:),'-h','color',color3/255,'linewidth',2);hold on;
legend('mt-mt','mt-prbs','mt-mix','prbs-mt','prbs-prbs','prbs-mix','mix-mt','mix-prbs','mix-mix','Location','Northeast')
title('误码率');
xlabel('SNR');
ylabel('误码率');

err_ratio_db = 10*log10(err_ratio_all);
figure(2);
semilogy(x, err_ratio_db(1,:),'-o','color',color1/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(2,:),'-+','color',color1/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(3,:),'-*','color',color1/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(4,:),'-x','color',color2/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(5,:),'-s','color',color2/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(6,:),'-d','color',color2/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(7,:),'-^','color',color3/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(8,:),'-p','color',color3/255,'linewidth',2);hold on;
semilogy(x, err_ratio_db(9,:),'-h','color',color3/255,'linewidth',2);hold on;
legend('mt-mt','mt-prbs','mt-mix','prbs-mt','prbs-prbs','prbs-mix','mix-mt','mix-prbs','mix-mix','Location','Northeast')
title('误码率');
xlabel('SNR');
ylabel('误码率/dB');



