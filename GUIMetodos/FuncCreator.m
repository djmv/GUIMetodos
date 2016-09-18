%% Creacion del sistema
clear all;close all;clc
%Varia Zt en los diferentes rangos y obtendras las fiferentes respuestas
%con el ruido que quieras
wn=10;           zt=0.5;         SNR=1000;       long=20;
n=[0 0 wn^2];   d=[1 2*zt*wn wn^2];
Ht=tf(n,d);
%step(Ht)
syms x t
Htsim=ilaplace(poly2sym(n)/poly2sym(d));
h=0.1;                      %paso
xi=0:h:long;                  %Vertor x
y=double(subs(Htsim,t,xi)); %Vector y sin ruido 
y= awgn(y,SNR);            %Vector y con ruido
plot(xi,y)                  %Grafica señal
hold on ;grid on 
Signal=[xi;y];