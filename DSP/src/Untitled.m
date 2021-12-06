x=0:0.001:pi;
H=0;
for k=1:1:20
    H=H+(sin(41.*(x./2-(k+10).*pi/41))./41./sin(x./2-(k+10).*pi./41));
end
H2=H+0.5*(sin(41.*(x./2-(10).*pi/41))./41./sin(x./2-(10).*pi./41));
H1=exp(-1i.*20.*x).*H;
H3=exp(-1i.*20.*x).*H2;
f1 = figure(1);set(gcf,'outerposition',get(0,'screensize'));
set(gca,'FontSize',16);
plot(x,20*log10(abs(H1)),'Linewidth', 1.4);
hold on;
plot(x,20*log10(abs(H3)),'Linewidth', 1.4);
legend('加题1','加题2');
saveas(f1,'jxti','png');