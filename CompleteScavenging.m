%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Myat Myint Zu Thin(MIIT)
clc
clear all;
close all;

n = 100;                          %number of particles
v = normrnd(0,3,[n,2]);          %velocity of each particle
x = -100+200*rand(n,2);          %position of each particle
dt = 0.1;                        %time interval
nfLandscape = 4;                 %Landscape position
sigma = [75 80; 80 75; 75 85; 60 60];     %standard deviation
pos = [-100 150;100 100; 50 -100; -100 -50];   %concentration of food 

H0 = 9;                           %H = amount of concentration  
H1 = 12;
H2 = 20;
H3 = 2;

a = -200:2:200;
b = -200:2:200;
[X, Y] = meshgrid(a,b);

Z0 = exp(-(((X-pos(1,1)).^2)/(2*sigma(1,1)^2) +((Y-pos(1,2)).^2)/(2*sigma(1,2)^2)));
Z1 = exp(-(((X-pos(2,1)).^2)/(2*sigma(2,1)^2) +((Y-pos(2,2)).^2)/(2*sigma(2,2)^2)));
Z2 = exp(-(((X-pos(3,1)).^2)/(2*sigma(3,1)^2) +((Y-pos(3,2)).^2)/(2*sigma(3,2)^2)));
Z3 = exp(-(((X-pos(4,1)).^2)/(2*sigma(4,1)^2) +((Y-pos(4,2)).^2)/(2*sigma(4,2)^2)));
Z = (Z0+Z1+Z2+Z3);
Alpha = 10;                      %attraction of food 

Vid = VideoWriter('Scavenging100Particles.avi');
Vid.FrameRate = 10;
Vid.Quality = 100;
open(Vid);
for t = 0.2:dt:30
   
   
     %%%%%%%%%%%%%%%%%%%%%%% Ploting
     for i = 1:n
       plot(pos(1,1),pos(1,2),'sb','markerface','b','markersize',11); 
       plot(pos(2,1),pos(2,2),'sg','markerface','g','markersize',11);
       plot(pos(3,1),pos(3,2),'sy','markerface','y','markersize',11);
       plot(pos(4,1),pos(4,2),'sk','markerface','k','markersize',11);

       plot(x(i,1),x(i,2),'ko','markerface','r','markersize',3);
        
        axis([-220 220 -220 220]);
        hold on
         
     end
   
     contour(X,Y,Z);
    hold off
    pause(0.1);
     F = getframe(gcf);
     writeVideo(Vid,F);
     
    %%%%%%%%%%%%%%%%%%%%%%%%%%% long range attraction
    for j = 1:n
     
     gradient0 = Grad(x(j,1),x(j,2),sigma(1,1),sigma(1,2),pos(1,1),pos(1,2));
     gradient1 = Grad(x(j,1),x(j,2),sigma(2,1),sigma(2,2),pos(2,1),pos(2,2));
     gradient2 = Grad(x(j,1),x(j,2),sigma(3,1),sigma(3,2),pos(3,1),pos(3,2));
     gradient3 = Grad(x(j,1),x(j,2),sigma(4,1),sigma(4,2),pos(4,1),pos(4,2));
     

     gradient = H0*gradient0 + H1*gradient1 + H2*gradient2 + H3*gradient3;
    v(j,:) =  v(j,:) +Alpha*(gradient/norm(gradient));
    x(j,:) = x(j,:) + v(j,:)*dt;
  
    end
  
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Velocity maching 
   
    for k = 1:n
        count = 0;
       for m = 1:n
             Vref = zeros(n,2);
           if(k ~= m)
     r1 = x(k,:);
     r2 = x(m,:);
     v1 = v(k,:);
     v2 = v(m,:);
    
    d = DistancebetweenTwoPoint(r1(1),r1(2),r2(1),r2(2));
  if(d < 10)
        
        v1r = sqrt((v1(1)^2+v1(2)^2)/(v2(1)^2+v2(2)^2))*v2;
        Vref(k,:) = v1r;
        
        count = count+1;
    end
   end
  end
  if (Vref(k,:) ~= 0)
           
       v(k,:) = AverageVector(v(k,:),Vref,count);
      
    end
   end 
  %%%%%%%%%%%%%%%%%%%%%%% collision
  for p = 1:n
      if(k <= n-1)
        for l = p+1:x
    r1 = x(p,:);
    r2 = x(l,:);
    v1 = v(p,:);
    v2 = v(l,:);
    
    d = DistancebetweenTwoPoint(r1(1),r1(2),r2(1),r2(2));
  if(d < 20)
        v1r = sqrt((v1(1)^2+v1(2)^2)/(v2(1)^2+v2(2)^2))*v2;
        v2r = sqrt((v2(1)^2+v2(2)^2)/(v1(1)^2+v1(2)^2))*v1;
        v(k,:) = v1r;
        v(l,:) = v2r;
       
  end
        end
        end
    end    
 
   
end
close(Vid);
function d = DistancebetweenTwoPoint(x1,y1,x2,y2)
 
  d = sqrt((x2-x1).^2+(y2-y1).^2);
  
  
end
function  A = AverageVector(V,a,n)
      
      temp = [0 0];
     
     for i = 1:n
       
          temp = temp + a(i,:);
           
     end
        A = (temp + V)/(n+1);
       
       
end
function G = Grad(x,y,sigmax,sigmay,x0,y0)

x1 = (x-x0)/(sigmax^2);
x2 = exp(-(((x-x0).^2)/(2*sigmax^2) +((y-y0).^2)/(2*sigmay^2)));

G(1) = -x1*(x2);
y1 = (y-y0)/(sigmay^2);
G(2) = -y1*(x2);
end
 
