function hComm = initialize_pl()

PLControl_user_settings;

%initalize serial port for agilent power supply
hAgilent = serial(serial_port_for_Agilent_Power);

% setup relevant object properties
set(hAgilent, 'StopBits', 2);
% connect to the instrument
PS3649a = icdevice('agilent_e3649a.mdd', hAgilent);
connect(PS3649a);

fprintf(hAgilent, 'INST:NSEL 1');
fprintf(hAgilent,'VOLT 10');
fprintf(hAgilent, 'INST:NSEL 2');
fprintf(hAgilent,'VOLT 10');
fprintf(hAgilent,'OUTP OFF');


%Step 1. Create an NI session object and an analog input 'Voltage' channel on cDAQ1Mod1:
hNICRio = daq.createSession('ni');
hNICRio. Rate = 2;
%hNICRio.DurationInSeconds = 1000;
hNICRio.IsContinuous = true;

%Step 2. Add the listener for the DataAvailable event and assign it to the variable lh:
hNICRio.addAnalogInputChannel('cDAQ1Mod1', 0:3, 'Thermocouple');
hNICRio.Channels(1).ThermocoupleType = 'J';
hNICRio.Channels(1).Units = 'Celsius';
hNICRio.Channels(2).ThermocoupleType = 'J';
hNICRio.Channels(2).Units = 'Celsius';
hNICRio.Channels(3).ThermocoupleType = 'J';
hNICRio.Channels(3).Units = 'Celsius';
hNICRio.Channels(4).ThermocoupleType = 'J';
hNICRio.Channels(4).Units = 'Celsius';

%Step 3. Create a simple callback function to plot the acquired data and save it as plotData.m in your working directory:
%Here, src is the session object for the listener and event is a daq.DataAvailableInfo object containing the data and associated timing information.

%intialize for the peltier controller
hOven1 = serial(serial_port_for_Oven_Controller1);
set(hOven1, 'BaudRate', 19200, 'Terminator', {94 13} );
fopen(hOven1);
%disable output 
send_TEM_serial_command(hOven1, '00', '1d','00000000');

hOven2 = serial(serial_port_for_Oven_controller2);
set(hOven2, 'BaudRate', 19200, 'Terminator', {94 13} );
fopen(hOven2);
%disable output 
send_TEM_serial_command(hOven2, '00', '1d','00000000');

hOven3 = serial(serial_port_for_Oven_controller3);
set(hOven3, 'BaudRate', 19200, 'Terminator', {94 13} );
fopen(hOven3);
%disable output 
send_TEM_serial_command(hOven3, '00', '1d','00000000');

hOven4 = serial(serial_port_for_Oven_controller4);
set(hOven4, 'BaudRate', 19200, 'Terminator', {94 13} );
fopen(hOven4);
%disable output 
send_TEM_serial_command(hOven4, '00', '1d','00000000');

hComm.hAgilent = hAgilent;
hComm.hNICRio = hNICRio;
hComm.hOven1 = hOven1;
hComm.hOven2 = hOven2;
hComm.hOven3 = hOven3;
hComm.hOven4 = hOven4;
hComm.PS3649a = PS3649a;

%load bias camera control gui
if exist(biasFile,'file')
    dos([biasFile,'&']);
end

ip = '127.0.0.1';
port = 5010;
flea3 = BiasControl(ip,port);

rps = flea3.connect();

if ~rps.success
    hComm.camera = 0;
    warndlg('There is a issue to connect the camera, No camera for the experiment');
else
    hComm.camera = 1;
    hComm.flea3 = flea3;
end

flea3.initializeCamera(frameRate,'ufmf');

hComm.hPControl = PControl;