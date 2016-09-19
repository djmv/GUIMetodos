function [Gm,tm,tau,t28,pos11,pos22,t63,Kp,err] = metodoDosPuntos_ModeloDePrimerOrdenDeSmith(x,ts)
t=ts;C_t=x;
p1=0.283;
p2=0.632;
SetPoint=C_t(end);
pos11=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p1
pos11=i;
end    
end
t28=t(pos11);
pos22=0;
for i=1:1:length(C_t)
if C_t(i)<SetPoint*p2
pos22=i;
end    
end
t63=t(pos22);
tao=1.5*(t63-t28);
tm=t63-tao;
%% Modelo de primer orden
hold on
s=tf('s');
Gp_smith= exp(-tm*s)/(tao*s+1);
%step(Gp_smith);
%% Criterio de Error
y=C_t;
y1=step(Gp_smith,t);
iae=trapz(t,abs(y-y1'));
err=iae;%Criterio de Error

Gm=Gp_smith;tau=tao;Kp=x(end);
end