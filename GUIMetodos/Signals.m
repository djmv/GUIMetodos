%Señal sobamortiguada - escalon
clear all;close all;
syms x t
N=[0  0 0.51];
D=[1 1 10 0];
Hf=poly2sym(N)/poly2sym(D);
Ht=ilaplace(Hf);
t=0:0.1:17;
SigSobre=double(subs(Ht,t));
sigSubAWGN = awgn(SigSobre,55);
plot(t,SigSobre);
hold on 
plot(t,sigSubAWGN,'r');
ylim([0 0.1])

Signal=[t;sigSubAWGN];

%%
%Señal sobreamortiguada - escalon
clear all;close all;
syms x t
N=[0  0 0.51];
D=[1 1 0.1 0];
Hf=poly2sym(N)/poly2sym(D);
Ht=ilaplace(Hf);
t=0:0.1:60;
SigSobre=double(subs(Ht,t));
sigSobreAWGN = awgn(SigSobre,25);
plot(t,SigSobre);
hold on 
plot(t,sigSobreAWGN,'r');
ylim([0 7])
Signal=[t;sigSobreAWGN];
%%

[signal,ex] = uigetfile('*.mat','Select the MATLAB file');
S1=load([ex signal]);
S1(1);
plot(S1.Signal(1,1:end),S1.Signal(2,1:end))


%%

Inch_SS = get(0,'screensize');
setpixelposition(figure1,Inch_SS)
