function [Gm,t1,t2,pos111,pos222,tm,tau,Kp,err,rr] = metodoDosPuntos_ModeloDeSegundoMasTiempoMuertoOrdenHo(x,ts)
%% Metodo de Ho polo doble
t=ts;C_t=x;rr=1;
a=-0.463;
b=0.463;
c=1.574;
d=-0.574;
p1=0.35;
p2=0.85;
SetPoint=C_t(end);
pos111=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p1
pos111=i;
end    
end
t1=t(pos111);
pos222=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p2
pos222=i;
end    
end
t2=t(pos222);
tao=a*t1+b*t2;
tm=c*t1+d*t2;
%% Modelo de segundo m�s tiempo muerto orden-Ho
hold on
s=tf('s');
if(tm<0)
    
    errordlg('Tiempo muerto negativo, no se puede aplicar el m�todo de Ho con polo doble');
    Gm=1;tau=1;Kp=1;err=0;
    
else
    Gp_Ho2 = exp(-tm*s)/(tao*s+1)^2;
    %step(Gp_Ho2);
    title('respuesta al escal�n');
    %% Criterio de Error
    y=C_t;
    y1=step(Gp_Ho2,t);
    iae=trapz(t,abs(y-y1));
    err=iae;%Criterio de Error
    Gm=Gp_Ho2;tau=tao;Kp=x(end);
    rr=0;
end

end

