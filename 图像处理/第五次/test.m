f = imread('1038-a.tif');
T = mean2(f); 
g = f > T; 
Tnext = 0.5* ( mean(f (g) ) + mean ( f ( -g ) )); 


