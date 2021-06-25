
w = -10:0.001:10;
y = (1+(2/pi)*w).*(w>=(-pi/2) & w<=0)+(1-(2/pi)*w).*(w>0 & w<=(pi/2))+0.*(w<(-pi/2) | w>(pi/2))
y = abs(y);
plot(w,y);axis([-10 10 -0.1 2]);

M = 1;
T = 1;
n = 1;
N = 1;

% hr[n]
function h = hrn(n)
    sum = 0;
    for m = 1:1:M
        sum = sum + ((m*pi/(2*M))/(sin(m*pi/(2*M)))*cos(m*n*pi*M));
    end
    h = (1/M)*(1/2 + sum);
end

% Hr'(jw)
function H = Hrw(w)
    sum = 0;
    for n = 1:1:N
        sum = sum + hrn(n)*cos(n*w*T);
    end
    H = hrn(0) + 2*sum;
end
