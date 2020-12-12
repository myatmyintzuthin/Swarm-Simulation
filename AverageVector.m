function  A = AverageVector(V,a,n)
      
      temp = [0 0];
     
     for i = 1:n
       
          temp = temp + a(i,:);
           
     end
        A = (temp + V)/n+1;
       
       
end