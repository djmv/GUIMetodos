function [Gm,tm,tau,Kp,err] = metodoDosPuntos_ModeloDePrimerOrdenHo(x,ts)
%% Método de Ho
t=ts;C_t=x;
a=-0.670;
b=0.670;
c=1.3;
d=-0.29;
p1=0.35;
p2=0.85;
SetPoint=C_t(end);
pos=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p1
pos=i;
end    
end
t1=t(pos);
pos=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p2
pos=i;
end    
end
t2=t(pos);
tao=a*t1+b*t2;
tm=c*t1+d*t2;
%% Modelo de primer orden-Ho
hold on
s=tf('s');
Gp_Ho = exp(-tm*s)/(tao*s+1);
%step(Gp_Ho);
%% Criterio de Error
y=C_t;
y1=step(Gp_Ho,t);
iae=trapz(t,abs(y-y1'));
err=iae;%Criterio de Error
Gm=Gp_Ho;tau=tao;Kp=x(end);
end

