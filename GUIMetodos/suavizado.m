function [ssig] = suavizado(sig)
z=sig;
a=0.4;
yi1(2)=z(1);
for i=3:length(z)+1
    if z(i-1) == 0
        yi1(i)=a(1)*z(i-1)+(1-a(1))*yi1(i-1);
    else
         yi1(i)=a(1)*z(i-1)+(1-a(1))*yi1(i-1);
    end
   
end
yi1=yi1(2:end);
ssig=yi1;
end