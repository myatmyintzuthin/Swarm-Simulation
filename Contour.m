
sigma = [75 80; 80 75; 75 85; 60 60];     %standard deviation
pos = [-100 150;100 100; 50 -100; -100 -50];   %concentration of food
a = -200:2:200;
b = -200:2:200;
[X, Y] = meshgrid(a,b);

Z0 = exp(-(((X-pos(1,1)).^2)/(2*sigma(1,1)^2) +((Y-pos(1,2)).^2)/(2*sigma(1,2)^2)));
Z1 = exp(-(((X-pos(2,1)).^2)/(2*sigma(2,1)^2) +((Y-pos(2,2)).^2)/(2*sigma(2,2)^2)));
Z2 = exp(-(((X-pos(3,1)).^2)/(2*sigma(3,1)^2) +((Y-pos(3,2)).^2)/(2*sigma(3,2)^2)));
Z3 = exp(-(((X-pos(4,1)).^2)/(2*sigma(4,1)^2) +((Y-pos(4,2)).^2)/(2*sigma(4,2)^2)));
Z = (Z0+Z1+Z2+Z3);

figure 
surf(X,Y,Z);
shading flat;
figure
contour(X,Y,Z);
