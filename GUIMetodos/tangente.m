function  [Gps,tm,tau,Kp] = tangente(sig,time)
y=sig; xi=time;
h=abs(xi(end)-xi(1))/length(xi);
yp=diff(y)/h;               %Primera derivada 
%  hold on ;grid on 
%  plot(xi(1:end-1),yp,'k')  %Grafica primera derivada

ypp=diff(yp)/h;             %Segunda derivada 
%hold on ;grid on 
%plot(xi(1:end-2),ypp,'r')   %Grafica Segunda derivada

ii=zeros(1,length(xi));      %Vector de busqueda
%%
tolinflex=0.014;
for i=1:1:length(ypp)
    if(-tolinflex<ypp(i) && ypp(i)<tolinflex) 
      infle=xi(i);
      disp(xi(i));
      break;
    end
end
%%
m=yp(i);
k=y(i)-m*infle;
u = m.*(xi(1:end-2))+ k;
% hold on 
% plot(xi(1:end-2),u,'k')
% hold on 
% plot(xi(i),y(i),'ok')
% ylim([-0.1 y(end)+0.1])
% hold off

%% Tiempo muerto 
tolinflex=0.008;
for i=1:1:length(u)
    if(-tolinflex<u(i) && u(i)<tolinflex) 
      Tm=xi(i);
      disp(xi(i));
      break;
    end
end

%% Tau
tol=0.15;
for i=1:1:length(u)
    if(-tol+y(end)<u(i) && u(i)<tol+ y(end)) 
      Tmm=xi(i);
      disp(xi(i));
      break;
    end
end
tou=Tmm-Tm;
tau=tou;
tm=Tmm;
Kp=y(end);
%% Funcion en el tiempo aproximada 
s=tf('s');
Gps=(Kp*exp(-Tm*s))/(tou*s + 1);
end