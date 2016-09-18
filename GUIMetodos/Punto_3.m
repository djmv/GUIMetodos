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

% Last Modified by GUIDE v2.5 17-Sep-2016 19:07:58

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
global Tp x ts;
[signal,ex] = uigetfile('*.mat','Select the MATLAB file');
    if (signal ~= 0)
        S1=load([ex signal]);
        ts=S1.Signal(1,:);
        x=S1.Signal(2,:);
        plot(ts,x);
        
    end
%Validamos el tipo de sistema
tol=str2double(get(handles.tol,'String'));
 Tipo = ID(S1.Signal(2,1:end),tol);
 set(handles.Tipo, 'String', Tipo) 
 a = 'Métodos de tres puntos: Jahanmiri';
 b = 'Métodos de dos puntos: Ho, Smith';
 c = 'Métodos de la tangente:Ziegler y Nichols';
 
 switch Tipo
   case 'El sistema es subamortiguado'        
        xo = {a;' ';' '};
        set(handles.Lista,'string',xo)
        Tp = 1;
   case 'El sistema es sobreamortiguado'
        xo = {a; b;c};
        set(handles.Lista,'string',xo)
        Tp=0;
        
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
global Tp x ts;
Mtdo = get(handles.Lista,'Value');
file_list = get(handles.Lista,'String');
disp(file_list(Mtdo))
 switch Mtdo
   case 1
        if Tp == 1
        %Jahanmiri sub
        elseif Tp == 0
        %Jahanmiri sobre
        end
   case 2
         if Tp == 1
        %Ho Sub
        elseif Tp == 0
        %Ho sobre
        end
     
   case 3
        %tangente sobre
        
        [Haprox,tm,tau,Kp]=tangente(x,ts);
        s=evalc('Haprox');
        idx = findstr(s,sprintf('\n'));
        s = s(idx(3)+1:idx(end-3));   
        set(handles.tfs,'String',s);
        a=strcat('Tm:  ',' ',num2str(tm));
        b=strcat('tau: ',' ',num2str(tau));
        c=strcat('Kp: ',' ',num2str(Kp));
         xo = {a;b;c};
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
