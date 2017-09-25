function varargout = VTOL_simfig(varargin)
% VTOL_SIMFIG MATLAB code for VTOL_simfig.fig
%      VTOL_SIMFIG, by itself, creates a new VTOL_SIMFIG or raises the existing
%      singleton*.
%
%      H = VTOL_SIMFIG returns the handle to a new VTOL_SIMFIG or the handle to
%      the existing singleton*.
%
%      VTOL_SIMFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in VTOL_SIMFIG.M with the given input arguments.
%
%      VTOL_SIMFIG('Property','Value',...) creates a new VTOL_SIMFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before VTOL_simfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to VTOL_simfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help VTOL_simfig

% Last Modified by GUIDE v2.5 22-Sep-2017 18:02:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @VTOL_simfig_OpeningFcn, ...
                   'gui_OutputFcn',  @VTOL_simfig_OutputFcn, ...
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


% --- Executes just before VTOL_simfig is made visible.
function VTOL_simfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to VTOL_simfig (see VARARGIN)

% Choose default command line output for VTOL_simfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes VTOL_simfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.axes1,'XLim',[-1.5,1.5],'YLim',[-0.1, 3],'dataaspectratio',[1 1 1]);
hold on
plot([-1.5,1.5],[0,0],':')
drone = VTOL(handles.axes1);
drone.VRotate(30);


% --- Outputs from this function are returned to the command line.
function varargout = VTOL_simfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function fL_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fL_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fL_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fL_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function fR_slider_Callback(hObject, eventdata, handles)
% hObject    handle to fR_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function fR_slider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fR_slider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
