function varargout = Punto_3(varargin)
% PUNTO_3 MATLAB code for Punto_3.fig
%      PUNTO_3, by itself, creates a new PUNTO_3 or raises the existing
%      singleton*.
%
%      H = PUNTO_3 returns the handle to a new PUNTO_3 or the handle to
%      the existing singleton*.
%
%      PUNTO_3('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PUNTO_3.M with the given input arguments.
%
%      PUNTO_3('Property','Value',...) creates a new PUNTO_3 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Punto_3_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Punto_3_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Punto_3

% Last Modified by GUIDE v2.5 19-Sep-2016 17:24:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Punto_3_OpeningFcn, ...
    'gui_OutputFcn',  @Punto_3_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end


% End initialization code - DO NOT EDIT


% --- Executes just before Punto_3 is made visible.
function Punto_3_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Punto_3 (see VARARGIN)

% Choose default command line output for Punto_3
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% Inch_SS = get(0,'screensize');
% set(gcf, 'Position', Inch_SS);
screensize = get(0, 'ScreenSize');
monitors = get(0,'MonitorPositions');
old0units = get(0, 'Units');

% UIWAIT makes Punto_3 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Punto_3_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in Abrir.
function Abrir_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
hold off
global Tp x ts tol;
[signal,ex] = uigetfile('*.mat','Select the MATLAB file');
if (signal ~= 0)
    S1=load([ex signal]);
    ts=S1.Signal(1,:);
    x=S1.Signal(2,:);
    plot(ts,x,'r');
    legend('Señal ingresada')
    %Validamos el tipo de sistema
    tol=str2double(get(handles.tol,'String'));
    Tipo = ID(S1.Signal(2,1:end),tol);
    set(handles.Tipo, 'String', Tipo)
    a = 'Mótodos de tres puntos: Jahanmiri';
    b = 'Mótodos de dos puntos: Modelo de primer orden de smith';
    c = 'Mótodos de dos puntos: Modelo de primer orden-Ho';
    d = 'Mótodos de dos puntos: Modelo de segundo mós tiempo muerto orden-Ho';
    e = 'Mótodos de la tangente:Ziegler y Nichols';
    
    switch Tipo
        case 'El sistema es subamortiguado'
            xo = {a;' ';' ';' ';' '};
            set(handles.Lista,'string',xo)
            Tp = 1;
        case 'El sistema es sobreamortiguado'
            xo = {a; b;c;d;e};
            set(handles.Lista,'string',xo)
            Tp=0;
            
    end
end
function Tipo_Callback(hObject, eventdata, handles)
% hObject    handle to Tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Tipo as text
%        str2double(get(hObject,'String')) returns contents of Tipo as a double


% --- Executes during object creation, after setting all properties.
function Tipo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Tipo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in Lista.
function Lista_Callback(hObject, eventdata, handles)
% hObject    handle to Lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Lista contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Lista


% --- Executes during object creation, after setting all properties.
function Lista_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Lista (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Aproximar.
function Aproximar_Callback(hObject, eventdata, handles)
% hObject    handle to Aproximar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% coloar informacion en pop - ap menó
a1='Señal de entrada ';
b1='Señal de entrada con Señal aproximada ';
c1='Señal de entrada con puntos  detectados para aproximación  ';
aa={a1;b1;c1};
set(handles.popupmenu1, 'String', aa);
global Tp x ts Gm1  u iii Mtdo errJaha1 errJaha2 errsmith errHo errHo2 pos1 pos11 pos111 pos2 pos22 pos222 t_r t_i ind2 ind5 ind70 ind90 cri;
Mtdo = get(handles.Lista,'Value');
file_list = get(handles.Lista,'String');
disp(file_list(Mtdo))
switch Mtdo
    case 1
        if Tp == 1
            %Jahanmiri sub
            cla
            clear Gm tm tau Kp s xo
            [Gm,tm,tau,Kp,errJaha1,t_r,t_i]=jahanmiri_sub(x,ts);Gm1=Gm;
            syms s;
            num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
            bar=strcat('-------------------------');
            deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
            TF={num;bar;deno}; %función de transferencia(String)
            set(handles.tfs,'String',TF);
            a=strcat('Tm:  ',' ',num2str(tm));
            b=strcat('tau: ',' ',num2str(tau));
            c=strcat('Kp: ',' ',num2str(Kp));
            d=strcat('Error(IAE): ',' ',num2str(errJaha1));
            xo = {a;b;c;d};
            set(handles.param,'string',xo)
        elseif Tp == 0
            %Jahanmiri sobre
            cla
            clear Gm tm tau Kp s xo
            if length(x) == length(ts)
                [Gm,tm,tau,Kp,errJaha2,cri,ind2,ind5,ind70,ind90] = jahanmiri_sobre(x,ts);Gm1=Gm;
                syms s;
                num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
                bar=strcat('-------------------------');
                deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
                TF={num;bar;deno}; %función de transferencia(String)
                set(handles.tfs,'String',TF);
                a=strcat('Tm:  ',' ',num2str(tm));
                b=strcat('tau: ',' ',num2str(tau));
                c=strcat('Kp: ',' ',num2str(Kp));
                d=strcat('Error(IAE): ',' ',num2str(errJaha2));
                xo = {a;b;c;d};
                set(handles.param,'string',xo)
                
                
            else
                disp('fas')
            end
        end
    case 2
        %Modelo de primer orden de smith
        clear Gm tm tau Kp s xo t28 t63
        cla
        [Gm,tm,tau,t28,pos11,pos22,t63,Kp,errsmith] = metodoDosPuntos_ModeloDePrimerOrdenDeSmith(x,ts);Gm1=Gm;
        
        syms s;
        num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
        bar=strcat('-------------------------');
        deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
        TF={num;bar;deno}; %función de transferencia(String)
        set(handles.tfs,'String',TF);
        a=strcat('Tm:  ',' ',num2str(tm));
        b=strcat('tau: ',' ',num2str(tau));
        c=strcat('Kp: ',' ',num2str(Kp));
        d=strcat('t28: ',' ',num2str(t28));
        
        e=strcat('t63: ',' ',num2str(t63));
        f=strcat('Error(IAE): ',' ',num2str(errsmith));
        xo = {a;b;c;d;e;f};
        set(handles.param,'string',xo)
    case 3
        cla
        clear Gm tm tau Kp s xo
        [Gm,tm,t1,t2,pos1,pos2,tau,Kp,errHo] = metodoDosPuntos_ModeloDePrimerOrdenHo(x,ts);Gm1=Gm;
        syms s;
        num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
        bar=strcat('-------------------------');
        deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
        TF={num;bar;deno}; %función de transferencia(String)
        set(handles.tfs,'String',TF);
        a=strcat('Tm:  ',' ',num2str(tm));
        b=strcat('tau: ',' ',num2str(tau));
        c=strcat('Kp: ',' ',num2str(Kp));
        e=strcat('t1: ',' ',num2str(t1));
        d=strcat('t2: ',' ',num2str(t2));
        f=strcat('Error(IAE): ',' ',num2str(errHo));
        xo = {a;b;c;d;e;f};
        set(handles.param,'string',xo)
        
    case 4
        clear Gm tm tau Kp s xo
        cla
        [Gm,t1,t2,pos111,pos222,tm,tau,Kp,errHo2,rr] = metodoDosPuntos_ModeloDeSegundoMasTiempoMuertoOrdenHo(x,ts);
        Gm1=Gm;
        syms s;
        num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
        bar=strcat('-------------------------');
        deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
        TF={num;bar;deno}; %función de transferencia(String)
        set(handles.tfs,'String',TF);
        a=strcat('Tm:  ',' ',num2str(tm));
        b=strcat('tau: ',' ',num2str(tau));
        c=strcat('Kp: ',' ',num2str(Kp));
        d=strcat('t28: ',' ',num2str(t1));
        e=strcat('t63: ',' ',num2str(t2));
        f=strcat('Error(IAE): ',' ',num2str(errHo2));
        xo = {a;b;c;d;e;f};
        set(handles.param,'string',xo)
        
    case 5
        %tangente sobre
        cla
        clear Gm tm tau Kp s
        [Gm,tm,tau,Kp,errTan,u,iii]=tangente(x,ts);
        Gm1=Gm;
        syms s;
        num=strcat(char(vpa(poly2sym(Gm.num{1,1},s),3)),'*exp(-',num2str(Gm.OutputDelay),'*s)');
        bar=strcat('-------------------------');
        deno=strcat(char(vpa(poly2sym(Gm.den{1,1},s),3)));
        TF={num;bar;deno}; %función de transferencia(String)
        set(handles.tfs,'String',TF);
        a=strcat('Tm:  ',' ',num2str(tm));
        b=strcat('tau: ',' ',num2str(tau));
        c=strcat('Kp: ',' ',num2str(Kp));
        d=strcat('Error(IAE): ',' ',num2str(errTan));
        xo = {a;b;c;d};
        set(handles.param,'string',xo)
end


function tol_Callback(hObject, eventdata, handles)
% hObject    handle to tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tol as text
%        str2double(get(hObject,'String')) returns contents of tol as a double


% --- Executes during object creation, after setting all properties.
function tol_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tol (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on selection change in param.
function param_Callback(hObject, eventdata, handles)
% hObject    handle to param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns param contents as cell array
%        contents{get(hObject,'Value')} returns selected item from param


% --- Executes during object creation, after setting all properties.
function param_CreateFcn(hObject, eventdata, handles)
% hObject    handle to param (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tfs_Callback(hObject, eventdata, handles)
% hObject    handle to tfs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tfs as text
%        str2double(get(hObject,'String')) returns contents of tfs as a double


% --- Executes during object creation, after setting all properties.
function tfs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tfs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Graf.
function Graf_Callback(hObject, eventdata, handles)
% hObject    handle to Graf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
b = get(handles.popupmenu1, 'Value');
global Gm1 ts x u iii Mtdo pos1 pos11 pos111 pos2 pos22 pos222 t_r t_i ind2 ind5 ind70 ind90 Tp cri
switch b
    case 1
        hold off
        plot(ts,x,'r')
        legend('Señal ingresada')
        
    case 2
        hold off
        plot(ts,x,'r');hold on
        step(Gm1,ts)
        legend('Señal ingresada','Señal aproximada ')
        
    case 3
        if Mtdo==1
            hold off
            plot(ts,x,'r');hold on
            if Tp == 1
                plot(t_r(1),t_r(2),'Ok');
                plot(t_i(1),t_i(2),'Ok');
            else
                if cri == 2
                    plot(ind2(1),ind2(2),'Ok');
                    plot(ind70(1),ind70(2),'Ok');
                    plot(ind90(1),ind90(2),'Ok');
                else
                    plot(ind5(1),ind5(2),'Ok');
                    plot(ind70(1),ind70(2),'Ok');
                    plot(ind90(1),ind90(2),'Ok');
                end
            end
            %Agregar los puntos detectados en el metodo
            legend('Señal ingresada')
        end
        if Mtdo==2
            hold off
            plot(ts,x,'r');hold on;
            %Agregar los puntos detectados en el metodo
            plot(ts(pos11),x(pos11),'ok');hold on
            plot(ts(pos22),x(pos22),'ok');hold on
            legend('Señal ingresada','t1','t2')
            
        end
        if Mtdo==3 ;
            hold off
            plot(ts,x,'r');hold on
            %Agregar los puntos detectados en el metodo
            plot(ts(pos1),x(pos1),'ok');hold on
            plot(ts(pos2),x(pos2),'ok');hold on
            legend('Señal ingresada','t1','t2')
        end
        if Mtdo==4 ;
            hold off
            plot(ts,x,'r');hold on
            %Agregar los puntos detectados en el metodo
            plot(ts(pos111),x(pos111),'ok');hold on
            plot(ts(pos222),x(pos222),'ok');hold on
            legend('Señal ingresada','t1','t2')
        end
        if Mtdo==5
            hold off
            plot(ts,x,'r');hold on
            plot(ts(1:end-2),u,'g');hold on
            plot(ts(iii),x(iii),'ok')
            ylim([-0.1 x(end)+0.1])
            legend('Señal ingresada','Recta tangente','Punto de Inflexión')
        end
        
end
% --- Executes on button press in Save.
function Save_Callback(hObject, eventdata, handles)
% hObject    handle to Save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global x ts
% figure 1
% plot(ts,x); hold on
% step(Gm1,ts)
% legend('Señal ingresada','Señal aproximada ')
saveas(handles.Signal,'Sistema.fig')


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global Tp x ts
cla
if Tp == 1
    %Jahanmiri sub
   
    clear Gm tm tau Kp s xo
    [Gm1,tm,tau,Kp,errJaha,t_r,t_i]=jahanmiri_sub(x,ts);
    Gm11=step(Gm1,ts);hold on
    plot(ts,Gm11,'r','parent',handles.Signal);hold on 
elseif Tp == 0
    if length(x) == length(ts)
        [Gm6,tm,tau,Kp,errJaha,cri,ind2,ind5,ind70,ind90] = jahanmiri_sobre(x,ts);
        Gm66=step(Gm6,ts);
        plot(ts,Gm66,'r','parent',handles.Signal);hold on
    else
        disp('fas')
    end
end
cla
if Tp == 0
[Gm2,tm,tau,t28,pos11,pos22,t63,Kp,errsmith] = metodoDosPuntos_ModeloDePrimerOrdenDeSmith(x,ts);
[Gm3,tm,t1,t2,pos1,pos2,tau,Kp,errHo] = metodoDosPuntos_ModeloDePrimerOrdenHo(x,ts);
[Gm4,t1,t2,pos111,pos222,tm,tau,Kp,errHo2,rr] = metodoDosPuntos_ModeloDeSegundoMasTiempoMuertoOrdenHo(x,ts);
Gm22=step(Gm2,ts);Gm33=step(Gm3,ts);Gm44=step(Gm4,ts);
plot(ts,Gm22,':m','parent',handles.Signal);hold on
plot(ts,Gm33,'b','parent',handles.Signal);hold on
plot(ts,Gm44,'g','parent',handles.Signal);hold on
[Gm5,tm,tau,Kp,errTan,u,iii]=tangente(x,ts);
Gm55=step(Gm5,ts);
plot(ts,Gm55,'y','parent',handles.Signal);hold on
ff='Aprox tangente';
else
 Gm5=1;errTan=1000;
 errsmith=1000; errHo =1000;errHo2=1000;
 Gm55=step(Gm5,ts);
end
Error=[errJaha errsmith errHo errHo2 errTan];
Vmin =find(min(Error)== Error);
ff=' ';
plot(ts,x,'k','parent',handles.Signal);hold on
a='Modelo Jahanmiri';
b='Modelo de primer: orden de smith';
c='MetodoDosPuntos: Modelo de primer orden Ho';
d='Metodo dos puntos: Modelo de segundo mas tiempo muerto orden Ho';
e='Método tangente';
if(Vmin==1)
f=a;
plot(ts,Gm11,'m','parent',handles.Signal);hold on
end;
if(Vmin==2)
f=b;
plot(ts,Gm22,'m','parent',handles.Signal);hold on
end;
if(Vmin==3)
f=c;
plot(ts,Gm33,'m','parent',handles.Signal);hold on
end;
if(Vmin==4)
f=d;
plot(ts,Gm44,'m','parent',handles.Signal);hold on
end;
if(Vmin==5)
f=e;
if Tp == 0
plot(ts,Gm55,'m','parent',handles.Signal);hold on
end
end;
legend('Señal de entrada','Aprox Jahanmiri','Aprox orden de smith ','Aprox Modelo de primer orden Ho','Aprox segundo mas tiempo muerto orden',ff)
xo = {f};
set(handles.mejor,'string',xo);

% --- Executes on selection change in mejor.
function mejor_Callback(hObject, eventdata, handles)
% hObject    handle to mejor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns mejor contents as cell array
%        contents{get(hObject,'Value')} returns selected item from mejor


% --- Executes during object creation, after setting all properties.
function mejor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mejor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
