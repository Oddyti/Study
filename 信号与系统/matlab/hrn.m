% hr[n]
function h = hrn(n)
    sum = 0;
    M = 10000;
    for m = 1:1:M
        sum = sum + ((m.*pi./(2.*M))./(sin(m.*pi./(2.*M))).*cos(m.*n.*pi./M));
    end
    h = (1./M).*(1/2 + sum);
end