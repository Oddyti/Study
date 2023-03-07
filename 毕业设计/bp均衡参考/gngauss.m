function [gsrv1,gsrv2]=gngauss(m,sgma)
 if nargin == 0,                 %如果没有输入实参，则均方为0，标准差为1
  m=0; sgma=1;
elseif nargin == 1,               %如果输入实参为1个参数，则标准差为输入实参，均值为0
  sgma=m; m=0;
end;
u=rand;                          
z=sgma*(sqrt(2*log(1/(1-u))));   
u=rand;                          
gsrv1=m+z*cos(2*pi*u);
gsrv2=m+z*sin(2*pi*u);
end

