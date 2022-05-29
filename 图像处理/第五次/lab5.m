f = imread('1038-a.tif');
count = 0;
T = mean2(f); 
done = false;
while ~done 
    count = count + 1; 
    g = f > T; 
    Tnext = 0.5* ( mean(f (g) ) + mean ( f ( ~g ) )); 
    done = abs (T - Tnext ) < 0.5; 
    T = Tnext ; 
end 
g = im2bw(f , T/255 ) ; 
imshow(f) % Fig . 11. 1 3(a) . 
figure , imhist (f) % Fig . 11.1 3(b) . 
figure , imshow(g) % Fig . 11.1 3(c) . 