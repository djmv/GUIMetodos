function [Gm,tm,tau,Kp,err] = jahanmiri_sub(sig,time)
tol=0.01;
y=sig;ts=time;
set=y(end);
s=tf('s');
sbe=(max(y)-set)/set;
dseta=-log(sbe)/(sqrt(pi^2+(log(sbe))^2));
if dseta > (sqrt(2)/2)
    mu=0;
else
    mu=pi;
end
psi1=sqrt(1-dseta^2)/(pi - atan(sqrt(1-dseta^2)/dseta));
term=(2*dseta*sqrt(1-dseta^2))/(2*dseta^2 - 1);
psi2=(mu+atan(term)-acos(dseta))/(sqrt(1-dseta^2));
% Punto de inflexión
d1=diff(y);
pos=find(max(d1)==d1);
d2=diff(d1);
%pos=find(-0.000002 < d2 & d2 < 0.000001);
TI=ts(pos(1));
%Time rise
for i=1:length(y)
    if(abs(y(i)-set)<tol)
        tr=ts(i);
        break;
    end
end
thau=(psi1*(tr-TI))/(1-psi1*psi2);
tm=abs((TI-psi1*psi2*tr)/(1-psi1*psi2));
tau=thau;
Kp=set;
Gm=(Kp*exp(-tm*s))/(thau^2*s^2+2*dseta*thau*s+1);
y1=step(Gm,ts);
iae=trapz(ts,abs(y-y1'));
err=iae;%Criterio de Error
end