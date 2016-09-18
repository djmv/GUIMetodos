function yi = ID(x,tol)
y=0;
    for i=1:1:length(x)
        if(x(i)> tol + x(end)) 
          y=1;
          
          break; 
        end
    end
    if(y==1)
    yi='El sistema es subamortiguado';
    disp(yi)
    else
     yi='El sistema es sobreamortiguado'; 
      disp(yi)
    end
    
end