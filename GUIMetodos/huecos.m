clear all;clc;close all
num=1;
den=[1 0.5 1];
h=tf(num,den);
ts=linspace(0,25,1000);
y=step(h,ts);
ys=y;
%ys(100:110)=0;
ys(250:270)=0;
%ys(440:460)=0;
r=find(0 == ys );
if r(1) == 1
  r=r(2:end);  
end
plot(ts,ys);% Real
k=1;
ind(k)=r(k);
for i=2:length(r)-1
    if (r(i+1)-r(i))>1
       k=k+1;
       ind(k)=r(i);
       k=k+1;
       ind(k)=r(i+1);
    elseif i == length(r)-1
        k=k+1;
        ind(k)=r(i+1);
    end
end

for i=2:2:length(ind)
clear yt tt ylog
yt=ys;tt=ts;
yt(ind(i-1):ind(i))=[];
tt(ind(i-1):ind(i))=[];
ylog=log10(yt);
yr=ylog(ind(i-1)-5:ind(i-1)+5);
tt=tt(ind(i-1)-5:ind(i-1)+5);
pr=sum(yr'*tt');
sx=sum(tt);
sy=sum(yr);
sx2=sum(tt.^2);
m1=((size(yr,1)+20)*pr-sx*sy)/((size(yr,1)+20)*sx2-sx^2);
b1=(sy-m1*sx)/((size(yr,1)+20));
r1=10^(m1);
A=10^(b1);
yapx=A*r1.^(ts);
ys(ind(i-1):ind(i))=yapx(ind(i-1):ind(i));
end
hold on 
plot(ts,ys,'R') % Aproximada
hold off
figure
plot(ts,ys)
figure