
clc
clear all;
close all;
i = [1 0];
j = [0 1];
inev = [-1 0];
jnev = [0 -1];
min = -5;
max = 15;
x = 50;
v = normrnd(0,3,[x,2]);
r = 7+3.*rand(x,2);
%r = 10*rand(x,2);
dt = 0.1;
%Z = A*exp( - (a*(X-x0).^2 + 2*b*(X-x0).*(Y-y0) + c*(Y-y0).^2));

Alpha = 0.2;

cm = [5 5];
A = 0.5;
%gradient = zeros(x,2);
for t = 0.2:dt:50
   
    
     %%%%%%%%%%%%%%%%%%%%%%% Ploting
     for p = 1:x
        
        plot(r(p,1),r(p,2),'ko','markerface','r','markersize',3);
        axis([-50 50 -50 50]);
        hold on
         
    end
    hold off
    pause(0.1);
    for n = 1:x
        
    gradient(n,:) = [A*exp(-(r(n,1).^2/2 + r(n,2).^2/2)),A*exp(-(r(n,1).^2/2 + r(n,2).^2/2))];
    %gradient(n,:) = 2*[(-2*a)*exp(-(a*(r(n,1)-p0).^2 + c*(r(n,2)-q0).^2)),(-2*c)*exp(-(a*(r(n,1)-p0).^2 + c*(r(n,2)-q0).^2))];
  
    v(n,:) = v(n,:) + Alpha*(gradient(n,:));
    r(n,:) = r(n,:) + v(n,:)*dt;
  
    end
  
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%% Velocity maching 
   
    for k = 1:x
        count = 0;
       for m = 1:x
             Vref = zeros(x,2);
           if(k ~= m)
     r1 = r(k,:);
     r2 = r(m,:);
     v1 = v(k,:);
     v2 = v(m,:);
    
    d = DistancebetweenTwoPoint(r1(1),r1(2),r2(1),r2(2));
  if(d < 0.7)
        
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
  for k = 1:x
      if(k <= x-1)
        for l = k+1:x
    r1 = r(k,:);
    r2 = r(l,:);
    v1 = v(k,:);
    v2 = v(l,:);
    
    d = DistancebetweenTwoPoint(r1(1),r1(2),r2(1),r2(2));
  if(d < 0.7)
        v1r = sqrt((v1(1)^2+v1(2)^2)/(v2(1)^2+v2(2)^2))*v2;
        v2r = sqrt((v2(1)^2+v2(2)^2)/(v1(1)^2+v1(2)^2))*v1;
        v(k,:) = v1r;
        v(l,:) = v2r;
       
  end
        end
        end
    end    
   %%%%%%%%%%%%%%%%%%%%%%%%% Central mass
   %for b = 1:x
   %found = 0;
    %rx = r(b,:);
    %dis = DistancebetweenTwoPoint(cm(1),cm(2),rx(1),rx(2));
    %while(dis > 5 && found == 0)
     %   v(b,:) = -v(b,:);
      %  found = 1;
    %end    
   %end  
   
   for b= 1:x
       
       if(gradient(b,:) == 0)
           v(b,:) = 0;
       end
   end
    
   
   
end

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
 