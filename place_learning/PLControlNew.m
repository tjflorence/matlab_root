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

% Last Modified by GUIDE v2.5 25-Apr-2013 15:17:59

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
handles.hComm = hComm;
handles.warnState = 0;
handles.desiredFloorTemp = str2double(get(handles.set_floor_temp,'String'));
handles.desiredWallTemp = str2double(get(handles.set_wall_temp,'String'));
handles.desired_peltier1_temp = str2double(get(handles.set_peltier1,'String'));
handles.desired_peltier2_temp = str2double(get(handles.set_peltier2,'String'));
handles.desired_peltier3_temp = str2double(get(handles.set_peltier3,'String'));
handles.desired_peltier4_temp = str2double(get(handles.set_peltier4,'String'));
handles.start = 0;
handles.WALLOVERHEATEMP = 70;
handles.FLOOROVERHEATTEMP = 60;
handles.PELTIEROVERHEATTEMP = 60;

lh = hComm.hNICRio.addlistener('DataAvailable', @(src, events)tempControlHelp(src, events, hObject)); 
fprintf(hComm.hAgilent,'OUTP OFF');
turnOnOffSwitcher(handles.hComm, 'off');
hComm.hNICRio.startBackground();

% Update handles structure
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
% hObject    handle to peltier2_temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of peltier2_temp as text
%        str2double(get(hObject,'String')) returns contents of peltier2_temp as a double


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


% --- Executes on button press in closedloop.
function closedloop_Callback(hObject, eventdata, handles)
% hObject    handle to closedloop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of closedloop

button_state = get(hObject,'Value');

if button_state == get(hObject,'Max')
    % toggle button is depressed
    handles.start = 1;
    set(hObject,'String','Open loop')
    fprintf(handles.hComm.hAgilent,'OUTP ON');
    setPeltierTemp(handles.hComm, handles.desired_peltier1_temp, desired_peltier2_temp, desired_peltier3_temp, desired_peltier4_temp);
    isLog = get(handles.log_temp, 'Value'); %returns toggle state of log_temp
    if isLog
        tempLogFile = [pwd, '\logTemp', datestr(now, 'yyyymmddTHHMMSS'), '.txt'];
        tempLogFid = fopen(tempLogFile, 'r');
        handles.tempLogFid = tempLogFid;
    end
elseif button_state == get(hObject,'Min')
    % toggle button is not depressed
    handles.start = 0;
    set(hObject,'String','Closed Loop');
    fclose(handles.tempLogFid);
    fprintf(handles.hComm.hAgilent,'OUTP OFF');
    turnOnOffSwitcher(handles.hComm, 'off');
end

guidata(hObject, handles);

function tempControlHelp(hObject, event, hfig)
 
 persistent volt1 volt2 volt3 volt4 volt5 volt6;
 if (isempty(volt1)) %It does not already exist
     volt1 = 0;
 end
 if (isempty(volt2)) %It does not already exist
     volt2 = 0;
 end
 if (isempty(volt3)) %It does not already exist
     volt3 = 0;
 end
  
 %read temperature of the floor, wall, and the peltiers
 handles = guidata(hfig);
 desiredFloorTemp = handles.desiredFloorTemp;
 desiredWallTemp = handles.desiredWallTemp;
 
 wallTemp = event.Data(1);
 baseTemp = (event.Data(2)+event.Data(3)+event.Data(4))/3; 
 %To avild corrupt data, read available bytes;
 if handles.hComm.hOven.bytesAvailable ~= 0
     fscanf(handles.hComm.hOven);
 end
 [peltier1Temp, peltier2Temp, peltier3Temp, peltier4Temp] = readPeltierTemp(handles.hComm);

 set(handles.floor_temp,'String', num2str(baseTemp, 4));
 set(handles.wall_temp,'String', num2str(wallTemp, 4));
 set(handles.peltier1_temp, 'String', num2str(peltier1Temp,4));
 set(handles.peltier2_temp, 'String', num2str(peltier2Temp,4));
 set(handles.peltier3_temp, 'String', num2str(peltier3Temp,4));
 set(handles.peltier4_temp, 'String', num2str(peltier4Temp,4));
 
 fprintf(handles.tempLogFid, '%f,%f,%f,%f,%f,%f\n',baseTemp, wallTemp, peltier1Temp, peltier2Temp, peltier3Temp, peltier4Temp); 
 
 %if the temperature is too high, turn off the power supply

 if (wallTemp > handles.WALLOVERHEATEMP || baseTemp > handles.FLOOROVERHEATTEMP)
     if (handles.warnState == 0)
         handles.warnState = 1;
         fprintf(handles.hComm.hAgilent,'OUTP OFF');
         warndlg('Temperature of the wall or floor is too high, the power supply has been turned off.', 'Over heat Dialog');z
     end
 else
     handles.warnState = 0;
 end
 
 if (peltier1Temp > handles.PELTIEROVERHEATTEMP)
     if (handles.warnState == 0)
         handles.warnState = 1;
         turnOnOffSwitcher(handles.hComm, 'off', 1);
         warndlg('Temperature of the peltier1 is too high, the power supply has been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState = 0;
 end
 
 if (peltier2Temp > handles.PELTIEROVERHEATTEMP)
     if (handles.warnState == 0)
         handles.warnState = 1;
         turnOnOffSwitcher(handles.hComm, 'off', 2);
         warndlg('Temperature of the peltier2 is too high, the power supply has been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState = 0;
 end
 
 if (peltier3Temp > handles.PELTIEROVERHEATTEMP)
     if (handles.warnState == 0)
         handles.warnState = 1;
         turnOnOffSwitcher(handles.hComm, 'off', 3);
         warndlg('Temperature of the peltier3 is too high, the power supply has been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState = 0;
 end
 
 if (peltier4Temp > handles.PELTIEROVERHEATTEMP)
     if (handles.warnState == 0)
         handles.warnState = 1;
         turnOnOffSwitcher(handles.hComm, 'off', 4);
         warndlg('Temperature of the peltier4 is too high, the power supply has been turned off.', 'Over heat Dialog');
     end
 else
     handles.warnState = 0;
 end
     
 %onOff temperature control for the wall and floor
 if handles.start == 1  
      
     if baseTemp <= desiredFloorTemp - 0.5
         if volt1~= 20
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
             fprintf(handles.hComm.hAgilent, 'VOLT 20');
             volt1 = 20;
         end
         
     elseif baseTemp <= desiredFloorTemp - 0.05
         if volt1~=13
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
             fprintf(handles.hComm.hAgilent, 'VOLT 13');
             volt1 = 13;
         end
         
     elseif baseTemp >= desiredFloorTemp + 0.05
         if volt1~=5
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
             fprintf(handles.hComm.hAgilent, 'VOLT 5');
             volt1 = 5;
         end
     elseif baseTemp >= desiredFloorTemp + 0.5
         if volt1~=0
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 1');
             fprintf(handles.hComm.hAgilent, 'VOLT 0');
             volt1 = 0;
         end
     end
     
     
     if wallTemp <= desiredWallTemp - 2
         if volt2~=10
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
             fprintf(handles.hComm.hAgilent, 'VOLT 10');
             volt2 = 10;
         end
         
     elseif wallTemp <= desiredWallTemp - 0.1
         if volt2~=7
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
             fprintf(handles.hComm.hAgilent, 'VOLT 7');
             volt2 = 7;
         end
         
         
     elseif wallTemp >= desiredWallTemp + 0.1
         if volt2~= 2
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
             fprintf(handles.hComm.hAgilent, 'VOLT 2');
             volt2 = 2;
         end
     elseif wallTemp >= desiredWallTemp + 2
         if volt2~= 0
             fprintf(handles.hComm.hAgilent, 'INST:NSEL 2');
             fprintf(handles.hComm.hAgilent, 'VOLT 0');
             volt2 = 0;
         end
         
     end
     if (volt3 ~= handles.desired_peltier1_temp || volt4 ~= handles.desired_peltier2_temp || volt5 ~= handles.desired_peltier3_temp || volt6 ~= handles.desired_peltier4_temp)
         setPeltierTemp(handles.hComm, handles.desired_peltier1_temp, handles.desired_peltier2_temp, handles.desired_peltier3_temp, handles.desired_peltier4_temp);
         volt3 = handles.desired_peltier1_temp;
         volt4 = handles.desired_peltier2_temp;
         volt5 = handles.desired_peltier3_temp;
         volt6 = handles.desired_peltier4_temp;
     end
     
 else
     volt1 = 0;
     volt2 = 0;
 end
 
 
