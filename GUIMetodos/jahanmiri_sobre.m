function [Gm,tm,tau,Kp,err,cri,ind2,ind5,ind70,ind90] = jahanmiri_sobre(sig,time)
tol=0.01;
y=sig;
ts=time;
set=y(end);
s=tf('s');
cnt=1;
for i=1:length(y)
    if (abs(y(i)-set*0.02)<tol)&&(cnt==1)
        ind2=[ts(i),y(i)];
        cnt=cnt+1;
    elseif (abs(y(i)-set*0.05)<tol)&&(cnt==2)
        ind5=[ts(i),y(i)];
        cnt=cnt+1;
    elseif (abs(y(i)-set*0.7)<tol)&&(cnt==3)
        ind70=[ts(i),y(i)];
        cnt=cnt+1;
    elseif (abs(y(i)-set*0.9)<tol)&&(cnt==4)
        ind90=[ts(i),y(i)];
        cnt=cnt+1;
    end
end
heta1=(ind90(1)-ind70(1))/(ind90(1)-ind2(1));
heta2=(ind90(1)-ind70(1))/(ind90(1)-ind5(1));
dseta1=sqrt((0.4844651-0.75323499*heta1)/(1-2.0946444*heta1));
dseta2=sqrt((0.4844651-0.75323499*heta2)/(1-2.0946444*heta2));
thau1=(ind90(1)-ind2(1))/(0.424301+4.62533*dseta1-2.65412*exp(-dseta1));
thau2=(ind90(1)-ind5(1))/(0.424301+4.62533*dseta2-2.65412*exp(-dseta2));
tm1=ind2(1);
Gm1=(set*exp(-tm1*s))/(thau1^2*s^2+2*dseta1*thau1*s+1); % FT tm=2%
y1=step(Gm1,time);
tm2=ind5(1);
Gm2=(set*exp(-tm2*s))/(thau2^2*s^2+2*dseta2*thau2*s+1); % FT tm=5%
y2=step(Gm2,time);
yp1=abs(y-y1');
yp2=abs(y-y2');
iae1=trapz(time,yp1); %Criterio de Error tm = 2%
iae2=trapz(time,yp2); %Criterio de Error tm = 5%
% iae1=49;
% iae2=4;
Kp=set;
if iae1>iae2
    Gm=Gm2;
    tau=thau2;
    tm=tm2;
    err=iae2;
    cri=5;
else
    Gm=Gm1;
    tau=thau1;
    tm=tm1;
    err=iae2;
    cri=2;
end
% err=length(y1);
% cri=length(y2);
% Kp=length(y);
end