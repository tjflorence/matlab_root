function varargout = PLControl(varargin)
% PLCONTROL MATLAB code for PLControl.fig
%      PLCONTROL, by itself, creates a new PLCONTROL or raises the existing
%      singleton*.
%
%      H = PLCONTROL returns the handle to a new PLCONTROL or the handle to
%      the existing singleton*.
%
%      PLCONTROL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PLCONTROL.M with the given input arguments.
%
%      PLCONTROL('Property','Value',...) creates a new PLCONTROL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PLControl_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PLControl_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PLControl

% Last Modified by GUIDE v2.5 18-Jun-2013 14:18:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PLControl_OpeningFcn, ...
                   'gui_OutputFcn',  @PLControl_OutputFcn, ...
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


% --- Executes just before PLControl is made visible.
function PLControl_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PLControl (see VARARGIN)

% Choose default command line output for PLControl
handles.output = hObject;

hComm = initialize_pl;
PLControl_user_settings;
handles.basePowerVolt_quickHeating = basePowerVolt_quickHeating;
% handles.basePowerVolt_slowHeating = basePowerVolt_slowHeating;
% handles.basePowerVolt_quickCooling = basePowerVolt_quickCooling;
% handles.basePowerVolt_slowCooling = basePowerVolt_slowCooling;

handles.wallPowerVolt_quickHeating = wallPowerVolt_quickHeating;
handles.wallPowerVolt_slowHeating = wallPowerVolt_slowHeating;
handles.wallPowerVolt_quickCooling = wallPowerVolt_quickCooling;
handles.wallPowerVolt_slowCooling = wallPowerVolt_slowCooling;

handles.pid4base.windup_guard = pid4base_windup_guard;
handles.pid4base.proportional_gain = pid4base_proportional_gain;
handles.pid4base.integral_gain = pid4base_integral_gain;
handles.pid4base.derivative_gain = pid4base_derivative_gain;
% 
% handles.pid4base.windup_guard = 50;
% handles.pid4base.proportional_gain = 25;
% handles.pid4base.integral_gain = 0.2;
% handles.pid4base.derivative_gain = 5;

handles.pid4base.prev_error = 0;
handles.pid4base.int_error = 0;

% handles.pid4wall.windHeating_guard = pid4wall_windHeating_guard;
% handles.pid4wall.proportional_gain = pid4wall_proportional_gain;
% handles.pid4wall.integral_gain = pid4wall_integral_gain;
% handles.pid4wall.derivative_gain = pid4wall_derivative_gain;
% handles.pid4wall.windHeating_guard = 50;
% handles.pid4wall.proportional_gain = 20;
% handles.pid4wall.integral_gain = 0.1;
% handles.pid4wall.derivative_gain = 0.1;    
% handles.pid4wall.prev_error = 0;
% handles.pid4wall.int_error = 0;

handles.hComm = hComm;
handles.warnState = 0;
handles.desiredFloorTemp = str2double(get(handles.set_floor_temp,'String'));
handles.desiredWallTemp = str2double(get(handles.set_wall_temp,'String'));
handles.desired_peltier1_temp = str2double(get(handles.set_peltier1,'String'));
handles.desired_peltier2_temp = str2double(get(handles.set_peltier2,'String'));
handles.desired_peltier3_temp = str2double(get(handles.set_peltier3,'String'));
handles.desired_peltier4_temp = str2double(get(handles.set_peltier4,'String'));
handles.start = 0;
handles.clock = 0;

handles.expDataRootDir = expDataRootDir;
handles.expProtocolDir = expProtocolDir;
handles.expFile = defaultProtocol;
set(handles.experiment_file, 'string', handles.expFile);

handles.trialDone = 0;
handles.WALLOVERHEATEMP = 70;
handles.FLOOROVERHEATTEMP = 60;
handles.PELTIEROVERHEATTEMP = 60;
handles.tempLogFid = 0;
handles.warnState2 = 0;
handles.warnState1 = 0;

handles.count = 0;
handles.last_peltier1_temp = 0;
handles.last_peltier2_temp = 0;
handles.last_peltier3_temp = 0;
handles.last_peltier4_temp = 0;
handles.oldBaseTemp = 25;
handles.oldWallTemp = 25;
handles.volt1 = 99;
handles.volt2 = 99;
lh = hComm.hNICRio.addlistener('DataAvailable', @(src, events)tempControlHelp(src, events, hObject));
handles.hComm.lh = lh;
fprintf(hComm.hAgilent,'OUTP ON');
turnOnOffSwitcher(handles.hComm, 'off', 1);
turnOnOffSwitcher(handles.hComm, 'off', 2);
turnOnOffSwitcher(handles.hComm, 'off', 3);
turnOnOffSwitcher(handles.hComm, 'off', 4);
hComm.hNICRio.startBackground();

%find default metadata xml file
updateLineNames;
updateEffectors;
curfile = mfilename('fullpath');
[current_path, filename] = fileparts(curfile);
handles.defualtMetaXmlFile = fullfile(current_path, 'PLControlMetaTree.xml');

% Heatingdate handles structure
guidata(hObject, handles);

% UIWAIT makes PLControl wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PLControl_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function wall_temp_Callback(hObject, eventdata, handles)
% hObject    handle to wall_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of wall_temp as text
%        str2double(get(hObject,'String')) returns contents of wall_temp as a double


% --- Executes during object creation, after setting all properties.
function wall_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to wall_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function floor_temp_Callback(hObject, eventdata, handles)
% hObject    handle to floor_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of floor_temp as text
%        str2double(get(hObject,'String')) returns contents of floor_temp as a double


% --- Executes during object creation, after setting all properties.
function floor_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to floor_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peltier1_temp_Callback(hObject, eventdata, handles)
% hObject    handle to peltier1_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peltier1_temp as text
%        str2double(get(hObject,'String')) returns contents of peltier1_temp as a double


% --- Executes during object creation, after setting all properties.
function peltier1_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peltier1_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peltier2_temp_Callback(hObject, eventdata, handles)
% hObject    handle to text22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text22 as text
%        str2double(get(hObject,'String')) returns contents of text22 as a double


% --- Executes during object creation, after setting all properties.
function text22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peltier3_temp_Callback(hObject, eventdata, handles)
% hObject    handle to peltier3_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peltier3_temp as text
%        str2double(get(hObject,'String')) returns contents of peltier3_temp as a double


% --- Executes during object creation, after setting all properties.
function peltier3_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peltier3_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function peltier4_temp_Callback(hObject, eventdata, handles)
% hObject    handle to peltier4_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peltier4_temp as text
%        str2double(get(hObject,'String')) returns contents of peltier4_temp as a double


% --- Executes during object creation, after setting all properties.
function peltier4_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peltier4_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when user attempts to close figure1.
function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
exit_pl(handles.hComm);
delete(hObject);

function set_floor_temp_CreateFcn(hObject, eventdata, handles)


function set_floor_temp_Callback(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of text as text
%        str2double(get(hObject,'String')) returns contents of text as a
%        double
desiredFloorTemp = str2double(get(hObject,'String'));
handles.desiredFloorTemp = desiredFloorTemp;

guidata(hObject, handles);

% --- Executes on button press in log_temp.
function log_temp_Callback(hObject, eventdata, handles)
% hObject    handle to log_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of log_temp


% --- Executes during object creation, after setting all properties.
function text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_wall_temp_Callback(hObject, eventdata, handles)
% hObject    handle to set_wall_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_wall_temp as text
%        str2double(get(hObject,'String')) returns contents of set_wall_temp as a double
desiredWallTemp = str2double(get(hObject,'String'));
handles.desiredWallTemp = desiredWallTemp;
guidata(hObject, handles);





% --- Executes during object creation, after setting all properties.
function set_wall_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_wall_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_peltier1_Callback(hObject, eventdata, handles)
% hObject    handle to set_peltier1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_peltier1 as text
%        str2double(get(hObject,'String')) returns contents of set_peltier1 as a double

 desired_peltier1_temp = str2double(get(hObject,'String'));
 handles.desired_peltier1_temp = desired_peltier1_temp;
 guidata(hObject, handles);

 
 
% --- Executes during object creation, after setting all properties.
function set_peltier1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_peltier1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_peltier2_Callback(hObject, eventdata, handles)
% hObject    handle to set_peltier2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_peltier2 as text
%        str2double(get(hObject,'String')) returns contents of set_peltier2 as a double
 desired_peltier2_temp = str2double(get(hObject,'String'));
 handles.desired_peltier2_temp = desired_peltier2_temp;
 guidata(hObject, handles);
 

% --- Executes during object creation, after setting all properties.
function set_peltier2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_peltier2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function experiment_file_Callback(hObject, eventdata, handles)
% hObject    handle to experiment_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of experiment_file as text
%        str2double(get(hObject,'String')) returns contents of experiment_file as a double
handles.expFile = get(hObject,'String');
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function experiment_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to experiment_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in choose_exp.
function choose_exp_Callback(hObject, eventdata, handles)
% hObject    handle to choose_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
oldPath = pwd;
cd(handles.expProtocolDir);
[filename, pathname] = uigetfile('*.mat', 'Select an experiment file');
if isequal(filename,0)
   return
else
   expFile = fullfile(pathname, filename);
   set(handles.experiment_file, 'string', expFile);
   handles.expFile = expFile;
end

cd(oldPath);
guidata(hObject, handles);


function set_peltier3_Callback(hObject, eventdata, handles)
% hObject    handle to set_peltier3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_peltier3 as text
%        str2double(get(hObject,'String')) returns contents of set_peltier3 as a double
 desired_peltier3_temp = str2double(get(hObject,'String'));
 handles.desired_peltier3_temp = desired_peltier3_temp;
 guidata(hObject, handles);
 

% --- Executes during object creation, after setting all properties.
function set_peltier3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_peltier3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function set_peltier4_Callback(hObject, eventdata, handles)
% hObject    handle to set_peltier4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of set_peltier4 as text
%        str2double(get(hObject,'String')) returns contents of set_peltier4 as a double
 desired_peltier4_temp = str2double(get(hObject,'String'));
 handles.desired_peltier4_temp = desired_peltier4_temp;
 guidata(hObject, handles);
 

% --- Executes during object creation, after setting all properties.
function set_peltier4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to set_peltier4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in start_exp.
function start_exp_Callback(hObject, eventdata, handles)
% hObject    handle to start_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of start


%start experiments
if exist(handles.expFile, 'file')
    load(handles.expFile);
    if ~exist('experiment', 'var')
        warndlg('Invalid experiment file', 'wrong file');
        return;
    else
        experimentName = experiment.name;
    end
    handles.testingMode = 0;
else
    warndlg('You have no experiment file selected. Select one experiment file first.');
    return;
end

if isempty(handles.expDataDir)
    warndlg('You should choose a experiment data directory if you want to record movie','No dir Warning');
    return;
end

%save the protocol to a txt file
protocolTxtFile = [handles.expDataDir,'\protocol.txt'];
fidProtocol = fopen(protocolTxtFile, 'w');
fprintf(fidProtocol , 'experiment name: %s\n', experiment.name);
for i = 1:length(experiment.protocol)
    fprintf(fidProtocol, 'trial %d:\n', i);
    fprintf(fidProtocol, 'trial_duration: %d\n', experiment.protocol(i).trial_duration);
    fprintf(fidProtocol, 'pattern_ID: %d\n', experiment.protocol(i).pattern_ID);
    fprintf(fidProtocol, 'gain_bias:[ %d %d %d %d ]\n', experiment.protocol(i).gain_bias(1),...
        experiment.protocol(i).gain_bias(2), experiment.protocol(i).gain_bias(3),...
        experiment.protocol(i).gain_bias(4));
    fprintf(fidProtocol, 'pattern_position: [ %d %d ]\n', experiment.protocol(i).pattern_position(1), experiment.protocol(i).pattern_position(2));
    fprintf(fidProtocol, 'temperature settings: [ %d %d %d %d %d %d ]\n', experiment.protocol(i).temps(1),...
        experiment.protocol(i).temps(2),experiment.protocol(i).temps(3),experiment.protocol(i).temps(4),...
        experiment.protocol(i).temps(5),experiment.protocol(i).temps(6));
    fprintf(fidProtocol, 'recordMovie: %d\n', experiment.protocol(i).recordMovie);
    fprintf(fidProtocol, '\n');
end
fclose(fidProtocol);

%start trials
handles.start = 1;
%guidata(hObject, handles);
set(handles.abort_exp,'Enable','On');
set(handles.test,'Enable','Off');
set(hObject,'Enable','Off');

if handles.testingMode == 0
    set(handles.set_floor_temp,'Enable', 'off');
    set(handles.set_wall_temp,'Enable', 'off');
    set(handles.set_peltier1, 'Enable', 'off');
    set(handles.set_peltier2, 'Enable', 'off');
    set(handles.set_peltier3, 'Enable', 'off');
    set(handles.set_peltier4, 'Enable', 'off');
end
%set(handles.current_time, 'String', num2str(length(Trial)));

%empty met_data_file input
if isempty(handles.meta_data_file)
    warndlg('You should input meta data for the exmperiment before start','No dir Warning');
    return;
end

set(handles.meta_data_file, 'string', '');

 %set old value to zero to make sure always setPeltierTemp when pressing
 %start button
 
 handles.last_peltier1_temp = 0;
 handles.last_peltier2_temp = 0;
 handles.last_peltier3_temp = 0;
 handles.last_peltier4_temp = 0;

handles.time= 0;
guidata(hObject, handles);


for i = 1:length(experiment.protocol)
    handles.trial_duration = experiment.protocol(i).trial_duration;
    guidata(hObject, handles);
    trialInfo = [num2str(i), '/', num2str(length(experiment.protocol))];
    set(handles.current_trial, 'String', trialInfo);
    
    handles.desiredFloorTemp = experiment.protocol(i).temps(1);
    handles.desired_wall_temp = experiment.protocol(i).temps(2);
    
    set(handles.set_floor_temp,'String', num2str(handles.desiredFloorTemp, 4));
    set(handles.set_wall_temp,'String', num2str(handles.desired_wall_temp, 4));
    
    
    handles.desired_peltier1_temp = experiment.protocol(i).temps(3);
    handles.desired_peltier2_temp = experiment.protocol(i).temps(4);
    handles.desired_peltier3_temp = experiment.protocol(i).temps(5);
    handles.desired_peltier4_temp = experiment.protocol(i).temps(6);
    guidata(hObject, handles);
%     setPeltierTemp(handles.hComm, handles.desired_peltier1_temp, handles.desired_peltier2_temp,...
%         handles.desired_peltier3_temp, handles.desired_peltier4_temp);
    
    set(handles.set_peltier1, 'String', num2str(handles.desired_peltier1_temp,4));
    set(handles.set_peltier2, 'String', num2str(handles.desired_peltier2_temp,4));
    set(handles.set_peltier3, 'String', num2str(handles.desired_peltier3_temp,4));
    set(handles.set_peltier4, 'String', num2str(handles.desired_peltier4_temp,4));
    
    Panel_com('set_pattern_id',experiment.protocol(i).pattern_ID);    
    Panel_com('set_position', experiment.protocol(i).pattern_position);
    Panel_com('send_gain_bias', experiment.protocol(i).gain_bias);
    Panel_com('start');
    
    %log temperature values
    
    isLog = get(handles.log_temp, 'Value'); %returns toggle state of log_temp
    if isLog
        
        if isempty(handles.expDataDir)
            warndlg('You should choose a experiment data directory if you want to record movie','No dir Warning');
            return;
        end

        tempLogFile = [handles.expDataDir, '\',experimentName,'_trail_', num2str(i),'_temp.txt'];
        tempLogFid = fopen(tempLogFile, 'w');
        handles.tempLogFid = tempLogFid;
    else
        handles.tempLogFid = 0;
    end
    guidata(hObject, handles);
    
    if handles.hComm.camera    
        
        trialMovieName = [handles.expDataDir, '\',experimentName,'_trial',num2str(i), '.ufmf'];
        
        if experiment.protocol(i).recordMovie 
            rsp = handles.hComm.flea3.stopCapture();             
            rsp = handles.hComm.flea3.disableLogging();
            rsp = handles.hComm.flea3.setVideoFile(trialMovieName);
            rsp = handles.hComm.flea3.enableLogging();
            rsp = handles.hComm.flea3.startCapture();
        else
            rsp = handles.hComm.flea3.stopCapture();
            rsp = handles.hComm.flea3.disableLogging();
            rsp = handles.hComm.flea3.startCapture();
        end
    end
    
    %set pattern information
    while 1
        
        %check the current status
        %use DAQ timer to timing the trial duration to get accurate
        %timing informaiton
        pause(0.1);
        handles = guidata(hObject);
        
        if handles.trialDone
            if experiment.protocol(i).recordMovie
                rsp = handles.hComm.flea3.stopCapture();
                rsp = handles.hComm.flea3.disableLogging();
                rsp = handles.hComm.flea3.startCapture();
            end
            Panel_com('stop');
            handles.trialDone = 0;
            %close logging temp file
            if handles.tempLogFid
                fclose(handles.tempLogFid);
                handles.tempLogFid = 0;
            end

            guidata(hObject, handles);
            break;
        end
        
        %to stop after user press 'abort'.
        if handles.start == 0
            set(hObject,'Enable','On');
            set(handles.abort_exp,'Enable','Off');
            set(handles.test,'Enable','On');
            return;
        end
    end
    
end

handles.start = 0;
set(handles.abort_exp,'Enable','Off');
set(handles.test,'Enable','On');

%fprintf(handles.hComm.hAgilent,'OUTP OFF');
turnOnOffSwitcher(handles.hComm, 'off', 1);
turnOnOffSwitcher(handles.hComm, 'off', 2);
turnOnOffSwitcher(handles.hComm, 'off', 3);
turnOnOffSwitcher(handles.hComm, 'off', 4);

if handles.testingMode == 0
    set(handles.set_floor_temp,'Enable', 'on');
    set(handles.set_wall_temp,'Enable', 'on');
    set(handles.set_peltier1, 'Enable', 'on');
    set(handles.set_peltier2, 'Enable', 'on');
    set(handles.set_peltier3, 'Enable', 'on');
    set(handles.set_peltier4, 'Enable', 'on');
end

set(handles.current_trial, 'string', '');
set(handles.current_time, 'string', '');
set(hObject,'Enable','On');
guidata(hObject, handles);
    

% --- Executes on button press in abort_exp.
function abort_exp_Callback(hObject, eventdata, handles)
% hObject    handle to abort_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles.start = 0;
if handles.tempLogFid
    fclose(handles.tempLogFid);
    handles.tempLogFid = 0;
end

handles.clock = 0;
%handles.trial = 0;

%fprintf(handles.hComm.hAgilent,'OUTP OFF');
turnOnOffSwitcher(handles.hComm, 'off', 1);
turnOnOffSwitcher(handles.hComm, 'off', 2);
turnOnOffSwitcher(handles.hComm, 'off', 3);
turnOnOffSwitcher(handles.hComm, 'off', 4);

%stop camera
rps = handles.hComm.flea3.stopCapture();

set(handles.set_floor_temp,'Enable', 'on');
set(handles.set_wall_temp,'Enable', 'on');
set(handles.set_peltier1, 'Enable', 'on');
set(handles.set_peltier2, 'Enable', 'on');
set(handles.set_peltier3, 'Enable', 'on');
set(handles.set_peltier4, 'Enable', 'on');
set(handles.start_exp,'Enable','On');
set(handles.test,'Enable','On');

set(handles.current_time, 'string', '');
set(handles.current_time, 'string', '');
guidata(hObject, handles);
    

function total_trial_Callback(hObject, eventdata, handles)
% hObject    handle to current_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_time as text
%        str2double(get(hObject,'String')) returns contents of current_time as a double



function current_time_Callback(hObject, eventdata, handles)
% hObject    handle to current_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of current_time as text
%        str2double(get(hObject,'String')) returns contents of current_time as a double


% --- Executes during object creation, after setting all properties.
function current_time_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_time (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function peltier2_temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to peltier2_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton2.
function togglebutton2_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton2


function tempControlHelp(hObject, event, hfig)
 %read temperature of the floor, wall, and the peltiers
 handles = guidata(hfig);
 handles.count = mod(handles.count + 1,2);

 desiredFloorTemp = handles.desiredFloorTemp;
 desiredWallTemp = handles.desiredWallTemp;
 
 wallTemp = event.Data(1);
 baseTemp = (event.Data(2)+event.Data(3)+event.Data(4))/3; 
 
 %To avild corrupt data, read available bytes;
 if handles.hComm.hOven1.bytesAvailable ~= 0
     fscanf(handles.hComm.hOven1);
 end
 if handles.hComm.hOven2.bytesAvailable ~= 0
     fscanf(handles.hComm.hOven2);
 end
 if handles.hComm.hOven3.bytesAvailable ~= 0
     fscanf(handles.hComm.hOven3);
 end
 if handles.hComm.hOven4.bytesAvailable ~= 0
     fscanf(handles.hComm.hOven4);
 end
 [peltier1Temp, peltier2Temp, peltier3Temp, peltier4Temp] = readPeltierTemp(handles.hComm);
 [peltier1Pwr, peltier2Pwr, peltier3Pwr, peltier4Pwr] = readPowerOutput(handles.hComm);
 
 peltier_array = {num2str(peltier1Temp,'%3.2f'), num2str(peltier1Pwr,'%3.2f'); num2str(peltier2Temp,'%3.2f'), num2str(peltier2Pwr,'%3.2f');...
     num2str(peltier3Temp,'%3.2f'), num2str(peltier3Pwr,'%3.2f'); num2str(peltier4Temp,'%3.2f'), num2str(peltier4Pwr,'%3.2f')};
 
 baseTemp = (baseTemp + handles.oldBaseTemp)/2;
 wallTemp = (wallTemp + handles.oldWallTemp)/2;
%  wallTemp = 53;
 
 %floor_wall_temp = [baseTemp; wallTemp];
 handles.oldBaseTemp = baseTemp;
 handles.oldWallTemp = wallTemp;
 
 %if the temperature is too high, turn off the power supply
 
 if (wallTemp > handles.WALLOVERHEATEMP || baseTemp > handles.FLOOROVERHEATTEMP)
     if (handles.warnState1 == 0)
         handles.warnState1 = 1;
         fprintf(handles.hComm.hAgilent,'OUTP OFF');
         turnOnOffSwitcher(handles.hComm, 'off',1);
         turnOnOffSwitcher(handles.hComm, 'off',2);
         turnOnOffSwitcher(handles.hComm, 'off',3);
         turnOnOffSwitcher(handles.hComm, 'off',4);
         warndlg('Temperature of the wall or floor is too high, All power supplies have been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState1 = 0;
 end
 
 if (peltier1Temp > handles.PELTIEROVERHEATTEMP || peltier2Temp > handles.PELTIEROVERHEATTEMP...
         || peltier3Temp > handles.PELTIEROVERHEATTEMP || peltier4Temp > handles.PELTIEROVERHEATTEMP)
     if (handles.warnState2 == 0)
         handles.warnState2 = 1;
         fprintf(handles.hComm.hAgilent,'OUTP OFF');
         turnOnOffSwitcher(handles.hComm, 'off',1);
         turnOnOffSwitcher(handles.hComm, 'off',2);
         turnOnOffSwitcher(handles.hComm, 'off',3);
         turnOnOffSwitcher(handles.hComm, 'off',4);
         warndlg('Temperature of the wall or floor is too high, All power supplies have been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState2 = 0;
 end
 
%update GUI and temp file every one second
if handles.count == 0
    if(handles.tempLogFid)
        fprintf(handles.tempLogFid, '%6.2f,%6.2f,%6.2f,%6.2f,%6.2f,%6.2f\n',baseTemp, wallTemp, peltier1Temp, peltier2Temp, peltier3Temp, peltier4Temp);
    end
    
    
    %PID control for the base
    
    % integration with windup guarding
    curr_error = desiredFloorTemp - baseTemp;
    handles.pid4base.int_error = handles.pid4base.int_error + curr_error;
    
    %anti windup
    if handles.pid4base.int_error < -handles.pid4base.windup_guard
        handles.pid4base.int_error = -handles.pid4base.windup_guard;
    elseif (handles.pid4base.int_error > handles.pid4base.windup_guard)
        handles.pid4base.int_error = handles.pid4base.windup_guard;
    end
    
    if curr_error >= 0.1
        control = handles.basePowerVolt_quickHeating;
    else   
        % differentiation
        diff = curr_error - handles.pid4base.prev_error;
        
        % scaling
        p_term = handles.pid4base.proportional_gain * curr_error;
        i_term = handles.pid4base.integral_gain * handles.pid4base.int_error;
        d_term = handles.pid4base.derivative_gain * diff;
        
        % summation of terms
        control = p_term + i_term + d_term;
    end
    
    if control >= handles.basePowerVolt_quickHeating
        control = handles.basePowerVolt_quickHeating;
    elseif control <=0
        control = 0;
    end
    
    fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
    fprintf(handles.hComm.hAgilent, ['VOLT ', num2str(control, '%3.2f')]);
    %disp(['VOLT for floor ', num2str(control, '%3.2f')]);
    
    % save current error as previous error for next iteration
    handles.pid4base.prev_error = curr_error;
    
%     %PID controller for the wall
%     curr_wall_error = desiredWallTemp - wallTemp;
%     handles.pid4base.int_error = handles.pid4base.int_error + curr_wall_error; 
%     
%     if handles.pid4wall.int_error < -handles.pid4wall.windup_guard
%         handles.pid4wall.int_error = -handles.pid4wall.windup_guard;
%     elseif (handles.pid4wall.int_error > handles.pid4wall.windup_guard)
%         handles.pid4wall.int_error = handles.pid4wall.windup_guard;
%     end
%     
%     if curr_wall_error >= 0.5
%         control = 20;
%     else   
%         % differentiation
%         diff = curr_wall_error - handles.pid4wall.prev_error;
%         
%         % scaling
%         p_term = handles.pid4wall.proportional_gain * curr_wall_error;
%         i_term = handles.pid4wall.integral_gain * handles.pid4wall.int_error;
%         d_term = handles.pid4wall.derivative_gain * diff;
%         
%         % summation of terms
%         control = p_term + i_term + d_term;
%         
%         fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
%     end
%     
%     if control >=20
%         control = 20;
%     elseif control <=0
%         control = 0;
%     end
%     
%     fprintf(handles.hComm.hAgilent, ['VOLT ', num2str(control, '%3.2f')]);
%     disp(['VOLT 4 wall ', num2str(control, '%3.2f')]);
%     
%     % save current error as previous error for next iteration
%     handles.pid4wall.prev_error = curr_wall_error;

    floor_wall_temp = {num2str(baseTemp, '%3.2f') num2str(control, '%3.2f'); num2str(wallTemp, '%3.2f'), num2str(handles.volt2, '%3.2f')};

    set(handles.table_floor_wall, 'data', floor_wall_temp);
    set(handles.table_peltier_array, 'data', peltier_array);
    
end

 %onOff temperature control for the wall and floor
 
%  if baseTemp <= desiredFloorTemp - 0.5
%      if handles.volt1~= handles.basePowerVolt_quickHeating
%          fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
%          fprintf(handles.hComm.hAgilent, ['VOLT ', num2str(handles.basePowerVolt_quickHeating, '%3.2f')]);
%          disp(['VOLT ', num2str(handles.basePowerVolt_quickHeating, '%3.2f')]);
%          handles.volt1 = handles.basePowerVolt_quickHeating;
%      end
%      
%  elseif baseTemp <= desiredFloorTemp - 0.05
%      if handles.volt1~= handles.basePowerVolt_slowHeating
%          fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
%          fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.basePowerVolt_slowHeating, '%3.2f')]);
%          disp(['VOLT ' ,  num2str(handles.basePowerVolt_slowHeating, '%3.2f')]);
%          handles.volt1 = handles.basePowerVolt_slowHeating;
%      end
%      
%  elseif baseTemp >= desiredFloorTemp + 0.5
%      if handles.volt1~=handles.basePowerVolt_quickCooling
%          fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
%          fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.basePowerVolt_quickCooling, '%3.2f')]);
%          disp(['VOLT ' ,  num2str(handles.basePowerVolt_quickCooling, '%3.2f')]);
%          handles.volt1 = handles.basePowerVolt_quickCooling;
%      end
% 
%  elseif baseTemp >= desiredFloorTemp + 0.05
%      if handles.volt1~=handles.basePowerVolt_slowCooling
%          fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
%          fprintf(handles.hComm.hAgilent, ['VOLT ' , num2str(handles.basePowerVolt_slowCooling, '%3.2f')]);
%          disp(['VOLT ' , num2str(handles.basePowerVolt_slowCooling, '%3.2f')]);
%          handles.volt1 = handles.basePowerVolt_slowCooling;
%      end
%  end

%7777777777777777777777777777777777777777777777777
 if wallTemp <= desiredWallTemp - 2
     if handles.volt2~= handles.wallPowerVolt_quickHeating
         fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
         fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.wallPowerVolt_quickHeating, '%3.2f')]);
         handles.volt2 = handles.wallPowerVolt_quickHeating;
     end
     
 elseif wallTemp <= desiredWallTemp - 0.1
     if handles.volt2~= handles.wallPowerVolt_slowHeating
         fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
         fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.wallPowerVolt_slowHeating, '%3.2f')]);
         handles.volt2 = handles.wallPowerVolt_slowHeating;
     end
     
 elseif wallTemp >= desiredWallTemp + 2
     if handles.volt2~= handles.wallPowerVolt_quickCooling
         fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
         fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.wallPowerVolt_quickCooling, '%3.2f')]);
         handles.volt2 = handles.wallPowerVolt_quickCooling;
     end
     
 elseif wallTemp >= desiredWallTemp + 0.1
     if handles.volt2~= handles.wallPowerVolt_slowCooling
         fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
         fprintf(handles.hComm.hAgilent, ['VOLT ' ,  num2str(handles.wallPowerVolt_slowCooling, '%3.2f')]);
         handles.volt2 = handles.wallPowerVolt_slowCooling;
     end
 end

%77777777777777777777777777777777777777777777777777
 if handles.start == 1
     if (handles.last_peltier1_temp ~= handles.desired_peltier1_temp || handles.last_peltier2_temp ~= handles.desired_peltier2_temp...
             || handles.last_peltier3_temp ~= handles.desired_peltier3_temp || handles.last_peltier4_temp ~= handles.desired_peltier4_temp)
         setPeltierTemp(handles.hComm, handles.desired_peltier1_temp, handles.desired_peltier2_temp, handles.desired_peltier3_temp, handles.desired_peltier4_temp);
         handles.last_peltier1_temp = handles.desired_peltier1_temp;
         handles.last_peltier2_temp = handles.desired_peltier2_temp;
         handles.last_peltier3_temp = handles.desired_peltier3_temp;
         handles.last_peltier4_temp = handles.desired_peltier4_temp;
     end
     % every second update the time information
     if handles.count == 0
         handles.clock = handles.clock + 1;
         if handles.clock <= handles.trial_duration
             timeInfo = [num2str(handles.clock), '/', num2str(ceil(handles.trial_duration))];
             set(handles.current_time, 'String', timeInfo);
         else
             handles.trialDone = 1;
             handles.clock = 0;
         end
     end
 else
     set(handles.current_time, 'String', ' ');
     set(handles.current_trial, 'String', ' ');
 end
 guidata(hfig, handles);

% --- Executes when entered data in editable cell(s) in table_peltier_array.
function table_peltier_array_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_peltier_array (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)



function exp_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to exp_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_data_dir as text
%        str2double(get(hObject,'String')) returns contents of exp_data_dir as a double


% --- Executes during object creation, after setting all properties.
function exp_data_dir_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sel_data_dir.
function sel_data_dir_Callback(hObject, eventdata, handles)
% hObject    handle to sel_data_dir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

oldPath = pwd;
cd(handles.expDataDir);

folder_name = uigetdir(handles.expDataDir,'Please select a directory to save experimental data');
if isequal(folder_name,0)
   return;
else
   expDataDir = folder_name;
   set(handles.exp_data_dir, 'string', expDataDir);
   handles.expDataDir = expDataDir;
end
cd(oldPath);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function current_trial_CreateFcn(hObject, eventdata, handles)
% hObject    handle to current_trial (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in test.
function test_Callback(hObject, eventdata, handles)
% hObject    handle to test (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%start experiments

    experimentName = 'testPeltiers';
    experiment.protocol(1).pattern_position = 1;
    temp1 = str2num(get(handles.set_floor_temp, 'String'));
    temp2 = str2num(get(handles.set_wall_temp, 'String'));
    temp3 = str2num(get(handles.set_peltier1, 'String'));
    temp4 = str2num(get(handles.set_peltier2, 'String'));
    temp5 = str2num(get(handles.set_peltier3, 'String'));
    temp6 = str2num(get(handles.set_peltier4, 'String'));
    
    experiment.protocol(1).temps =[temp1 temp2 temp3 temp4 temp5 temp6];
    experiment.protocol(1).trial_duration=7200;
    experiment.protocol(1).gain_bias=[0 0 0 0];
    experiment.protocol(1).pattern_ID= 1;
    experiment.protocol(1).recordMovie= 1;
    handles.testingMode = 1;

%log temperature values

isLog = get(handles.log_temp, 'Value'); %returns toggle state of log_temp
if isLog
    if isempty(handles.expDataDir)
        warndlg('You should choose a experiment data directory if you want to log temperature','No dir Warning');
        return;
    else
        tempLogFile = [handles.expDataDir, '\',experimentName,'_', datestr(now, 'yyyymmddTHHMMSS'), '.txt'];
        tempLogFid = fopen(tempLogFile, 'w');
        handles.tempLogFid = tempLogFid;
    end
else
    handles.tempLogFid = 0;
end

%start trials
handles.start = 1;
%guidata(hObject, handles);
set(handles.abort_exp,'Enable','On');
set(handles.start_exp,'Enable','Off');
set(hObject,'Enable','Off');

if handles.testingMode == 0
    set(handles.set_floor_temp,'Enable', 'off');
    set(handles.set_wall_temp,'Enable', 'off');
    set(handles.set_peltier1, 'Enable', 'off');
    set(handles.set_peltier2, 'Enable', 'off');
    set(handles.set_peltier3, 'Enable', 'off');
    set(handles.set_peltier4, 'Enable', 'off');
end
%set(handles.current_time, 'String', num2str(length(Trial)));

for i = 1:length(experiment.protocol)
    handles.trial_duration = experiment.protocol(i).trial_duration;
    guidata(hObject, handles);
    trialInfo = [num2str(i), '/', num2str(length(experiment.protocol))];
    set(handles.current_trial, 'String', trialInfo);
    
    handles.desiredFloorTemp = experiment.protocol(i).temps(1);
    handles.desired_wall_temp = experiment.protocol(i).temps(2);
    %setFloorWallTemp(handles.hComm, handles.desiredFloorTemp, handles.desired_wall_temp);
    
    set(handles.set_floor_temp,'String', num2str(handles.desiredFloorTemp, 4));
    set(handles.set_wall_temp,'String', num2str(handles.desired_wall_temp, 4));
    
    
    handles.desired_peltier1_temp = experiment.protocol(i).temps(3);
    handles.desired_peltier2_temp = experiment.protocol(i).temps(4);
    handles.desired_peltier3_temp = experiment.protocol(i).temps(5);
    handles.desired_peltier4_temp = experiment.protocol(i).temps(6);
    setPeltierTemp(handles.hComm, handles.desired_peltier1_temp, handles.desired_peltier2_temp,...
        handles.desired_peltier3_temp, handles.desired_peltier4_temp);
    
    set(handles.set_peltier1, 'String', num2str(handles.desired_peltier1_temp,4));
    set(handles.set_peltier2, 'String', num2str(handles.desired_peltier2_temp,4));
    set(handles.set_peltier3, 'String', num2str(handles.desired_peltier3_temp,4));
    set(handles.set_peltier4, 'String', num2str(handles.desired_peltier4_temp,4));
    
    %set pattern information
    while 1     
        
        %check the current status
        %use DAQ timer to timing the trial duration to get accurate
        %timing informaiton
        pause(0.1);
        handles = guidata(hObject);
        
        if handles.trialDone
            handles.trialDone = 0;
            guidata(hObject, handles);
            break;
        end
        
        %to stop after user press 'abort'.    
        if handles.start == 0
            set(hObject,'Enable','On');
            set(handles.abort_exp,'Enable','Off');
            set(handles.start_exp,'Enable','On');
            return;
        end
    end
    
end

handles.start = 0;
set(handles.abort_exp,'Enable','Off');
set(handles.start_exp,'Enable','On');
if handles.tempLogFid
    fclose(handles.tempLogFid);
    handles.tempLogFid = 0;
end
%fprintf(handles.hComm.hAgilent,'OUTP OFF');
turnOnOffSwitcher(handles.hComm, 'off', 1);
turnOnOffSwitcher(handles.hComm, 'off', 2);
turnOnOffSwitcher(handles.hComm, 'off', 3);
turnOnOffSwitcher(handles.hComm, 'off', 4);

if handles.testingMode == 0
    set(handles.set_floor_temp,'Enable', 'on');
    set(handles.set_wall_temp,'Enable', 'on');
    set(handles.set_peltier1, 'Enable', 'on');
    set(handles.set_peltier2, 'Enable', 'on');
    set(handles.set_peltier3, 'Enable', 'on');
    set(handles.set_peltier4, 'Enable', 'on');
end

set(handles.current_trial, 'string', '');
set(handles.current_time, 'string', '');
set(hObject,'Enable','On');
guidata(hObject, handles);
    


% --- Executes on button press in meta_data_input.
function meta_data_input_Callback(hObject, eventdata, handles)
% hObject    handle to meta_data_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

defaultsFile = handles.defualtMetaXmlFile;

% Load defaults XML tree from sample file
defaultsTree = loadXMLDefaultsTree(defaultsFile);

[pathstr, protocolName, ext]  = fileparts(handles.expFile);
defaultsTree.setValueByPathString('protocol', protocolName);
defaultsTree.setValueByPathString('date', datestr(now,30));

% Create figure in which to place JIDE property grid
fig = figure( ...
    'MenuBar', 'none', ...
    'Name', 'Metadata Input GUI', ...
    'NumberTitle', 'off', ...
    'Toolbar', 'none' ...
    );
                  
% Create JIDE PropertyGrid and display defaults data in figure
pgrid = PropertyGrid(fig,'Position', [0 0 1 1]);
pgrid.setDefaultsTree(defaultsTree, 'advanced');

h = uicontrol('Position', [230 20 80 20], 'String', 'Continue', ...
                      'Callback', 'uiresume(gcbf)');
% Block unit figure is destroyed
uiwait(gcf);
close(fig);
% Create XML meta data file from defaults tree. Note we haven't checked if
% we have all the required values filled in, but this is suppose to be a 
% simple example - I'll show how to do this in a more ellaborate example.
metaData = createXMLMetaData(defaultsTree);

% Save defaultsTree as xml file. Note, the current values for all the meta
% data are saved in the tree so that it is possible to have meata data whose 
% default option is to use the last value used. 
defaultsTree.write(defaultsFile);

% Save meta tree as xml file
oldPath = pwd;
cd(handles.expDataRootDir);
currentDate = datestr(now, 29);
tempPath1 = [handles.expDataRootDir, '\', currentDate];
if ~exist(tempPath1, 'dir')
    mkdir(tempPath1);
end

cd(tempPath1);
driverName = metaData.attribute.driver;
dataPath = [tempPath1, '\', driverName];

if exist(dataPath, 'dir')
    for i = 1:100
        tempPath2 = [dataPath, '_', num2str(i)];
        if ~exist(tempPath2, 'dir')
            break;
        end
    end
else
    tempPath2 = dataPath;
end

mkdir(tempPath2);
    
handles.expDataDir = tempPath2;
cd(oldPath);
set(handles.exp_data_dir, 'string', tempPath2);


metaDataFile = [handles.expDataDir, '\',datestr(now,29),'_',driverName,'_metaData.xml'];
metaData.write(metaDataFile);

set(handles.meta_data_file, 'string', metaDataFile);

guidata(hObject, handles);

%         f = figure;
%         h = uicontrol('Position', [20 20 200 40], 'String', 'Continue', ...
%                       'Callback', 'uiresume(gcbf)');
%         disp('This will print immediately');
%         uiwait(gcf);
%         disp('This will print after you click Continue'); close(f);

function meta_data_file_Callback(hObject, eventdata, handles)
% hObject    handle to meta_data_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of meta_data_file as text
%        str2double(get(hObject,'String')) returns contents of meta_data_file as a double


% --- Executes during object creation, after setting all properties.
function meta_data_file_CreateFcn(hObject, eventdata, handles)
% hObject    handle to meta_data_file (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
