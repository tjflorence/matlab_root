function [data_out] = VR_laserPosition_pretrain_tcp(input_tempEnv, experimentLength, exName,fileName,directory,XYstart,rotGain,sampleRate,info_input,acquire_images,ao_obj, tcpInput)
%% treadmill_laser_closed_loop(experimentLength,pat,exName,fileName,directory,XYstart,rotGain,sampleRate,acquire_images,stopEarly,stopEarlyPause,info)
%
%experimentLength is the length of the experiment in seconds
%
%pat is the pattern to be displayed.  must be same size as displayHeight
%and displayWidth setting (both hard coded).
%
%arenaPower is the power setting for fly when it is being heated.
%Acceptable values are 0-10.
%
%edgePower is the power setting for the fly when it is approaching the edge
%of the arena.  Acceptable values are 0-10.
%
%exName is the name of the experiment.  All files will be saved in a folder of
%this name.
%
%fileName is the name for each file saved in exName folder.
%
%directory is the main directory for data to be saved to.
%
%targetXY are the X and Y coordinate(s) of the cool spot(s).  It is defined as [xmin1,xmax1,ymin1,ymax1;xmin2,xmax2,ymin2,ymax2; etc].
%
%
%arenaSize is the radius of the arena in mm.
%
%XYstart are the starting coordinates of the fly
%
%note, slope of temp gradients is hard coded as data.tempGrad
%
% calibration 16 ticks = 0.0376 inches = 0.955 mm


%laser power set to max.  Temperature ~ 22.236 + (6.486*power) where power is
%0-10.

%Cleanup any open serial interfaces or instances of this program


global data
global info
global init
global ao
global timer1
global tempEnv
global tcp

tcp = tcpInput;
tempEnv= input_tempEnv;
info = info_input;
data.main_directory=directory;
data.name=exName;
data.fileName=fileName;
data.tempEnv = tempEnv;

data.experimentLength=experimentLength; %in seconds
data.sampleRate=sampleRate; %in Hz
data.ballDiameter=9; % ball diameter in mm

data.displayHeight=32; % display height in pixels
data.displayWidth=96; % display width in pixels
data.overSample=7; % how many rays to cast for each pixel
data.row_compression=0;
data.gs_val=3;
data.acquire_images=acquire_images;

data.XYstart=XYstart;
data.XYstart(3)=abs(data.XYstart(3));
data.ticks_per_mm=info.ticksPerMM;
data.ticks_per_radian=(data.ballDiameter/2)*data.ticks_per_mm; % radius * ticks per mm
data.rotGain=rotGain;
data.arenaRadius = length(tempEnv)/2;
data.arenaWidth = length(tempEnv);

%% process pattern info
pattern.row_compression = data.row_compression; % kind of a hack, but then can use old code for process_panel_map
pattern.Panel_map = [12 8 4 11 7 3 10 6 2  9 5 1; 24 20 16 23 19 15 22 18 14 21 17 13; 36 32 28 35 31 27 34 30 26 33 29 25; 48 44 40 47 43 39 46 42 38 45 41 37];
data.BitMapIndex = process_panel_map(pattern);


%% initialize some things
    init.count=0;
    init.pat=zeros(data.displayHeight,data.displayWidth);
    init.num_angle_samples = data.displayWidth*data.overSample;
    init.height_vec = 1:1:data.displayHeight;
    init.sizeExp = [64 672];
    init.numPanels = length(data.BitMapIndex);
    
    init.thetaVal = 0:(2*pi)/init.num_angle_samples:2*pi - (1/init.num_angle_samples);
    init.one_quarter = (init.num_angle_samples/4);
    init.thetaVal = [init.thetaVal(init.one_quarter + 1:end) init.thetaVal(1:init.one_quarter)];
    % theta starts at behind then goes counterclockwise, so flip this - 
    init.thetaVal = fliplr(init.thetaVal);
    init.lengthThetaVal = length(init.thetaVal);
    init.Init_x_circle_pos = zeros(1,length(init.thetaVal));
    init.Init_y_circle_pos = zeros(1,length(init.thetaVal));
    init.Init_ray_dist = zeros(1,init.lengthThetaVal);
    
    init.frame_pat = zeros(24,24);
    

%%
%initialized analog output for laser
ao = ao_obj;

 data.count=1;
 data.Xpos=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.Xpos(data.count)=data.XYstart(1);
 data.Ypos=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.Ypos(data.count)=data.XYstart(2);
 data.flyTheta=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.flyTheta(data.count)=data.XYstart(3);
 data.laserPower=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.laserPower(data.count)=0;
 data.outsideArena=zeros(round(1.2*data.sampleRate*data.experimentLength),1);
 data.timeStamp=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.syncTag=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.videoFrame=nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.ball_tracking_framerate = nan(round(1.2*data.sampleRate*data.experimentLength),1);
 data.OOB_frames = 0;
 data.deadEnd_frames = 0;
 data.edgeFrames = 0;
 data.safeFrames = 0;
 data.povGain = .75;
 

%% connect to camera, usb serial mode
COMport = 'COM7';
%Connect to serial object
%Open serial port interface
%__________________________________________________________________
s=serial(COMport);%<------------------------------------------------COM PORT DEFINITION
%------------------------------------------------------------------
s.baudrate=1250000;
s.bytesavailablefcn={@baf}; %function called whenever data is available
s.bytesavailablefcncount=48000/sampleRate; %12 bytes per sample, 4kSamples/sec = 48000 bytes per second.  20Hz=2400
s.bytesavailablefcnmode='byte';
s.inputbuffersize=50000;
fopen(s);
%Default to Vf,Vs,Om mode
fwrite(s,[246,0])
% removes any data from buffer
if s.bytesavailable>0
     fread(s,s.bytesavailable); 
end

%starts logging
disp('beginning stripe fix sync')



fwrite(tcp, [1 0 0 0 1],'double' )
ao.outputSingleScan([-4.99 1 1 0])
disp('we are go')

fwrite(s,[255,0]); % starts tracking acquisition
timer1      =   tic;
while (toc(timer1) < data.experimentLength) && (data.OOB_frames < (info.sampleRate*60)) && (data.deadEnd_frames<(info.sampleRate*60)) && (data.edgeFrames < (info.sampleRate*10))  && (data.safeFrames < (info.sampleRate*60))
    pause(.001) % waits for experiment to finish
end

fwrite(tcp, [1 0 0 0 1], 'double')
ao.outputSingleScan([-4.99 1 0 0])
disp('trial over')
    
% stops logging
fwrite(s,[254,0]);
fclose(s);
fclose('all');
delete(s);


% saves things
data_out = data;
cd([directory '\' exName])
save(data.fileName, 'data');

end

   


%Bytes Available Function
function baf(obj,event)

global ao
global info
global timer1
global data
global tempEnv
global tcp

%% gets data from ball tracker
%Sometimes this event gets called with no data available... for whatever reason, if so, return
if obj.bytesavailable<obj.bytesavailablefcncount
    disp('returned')
    return
end

% pull the data out of the buffer
raw     =   fread(obj,obj.bytesavailablefcncount);

%12 bytes per sample, only the first byte of the packet is ever zero
zinds   =   find(raw==0);

%Check the input stream for appropriate packets.  If the stream contains malformed packets, then restart the interface
if sum(diff(zinds)~=12)>1||(obj.bytesavailablefcncount-zinds(end)+1)~=12
    disp('Packets Dropped, Resetting')
    fwrite(obj,[254,0])
    if obj.bytesavailable>0
            fread(obj,obj.bytesavailable); 
    end
    fwrite(obj,[255,0]);
    return
end

%Extract the data relative to the packet header indices
ind     =  raw(zinds+1);
md      =  min(diff(ind));

%Respond to errors in the packet index.  If the packet count jumps more than 1 (255 to 1 counts as 1) then restart interface (missing packets)
if(max(diff(ind))>1)||~(md==1||md==-254)
    disp('Packets Dropped, Resetting 1')
    fwrite(obj,[254,0])
    
    if obj.bytesavailable>0
            fread(obj,obj.bytesavailable); 
    end
    
    fwrite(obj,[255,0]);
    return
end

%Raw Data, make motion data signed around zero
raw(zinds+2) = raw(zinds+2)-128;
raw(zinds+3) = raw(zinds+3)-128;
raw(zinds+4) = raw(zinds+4)-128;
raw(zinds+5) = raw(zinds+5)-128;

%Extract Motion Data from stream
x0          =  raw(zinds+2);
y0          =  raw(zinds+3);
x1          =  raw(zinds+4);
y1          =  raw(zinds+5);

%integration rotation
Vfwd        =  sum(x0)*.7071; 
Vss         =  sum(y0)*.7071;
Omega       =  sum(x1)/2;

data.count                  =  data.count+1;
data.flyTheta(data.count)   =  mod(data.flyTheta(data.count-1)+((sum(Omega)/data.ticks_per_radian)*data.rotGain),2*pi);
[Xfwd,Yfwd]                 =  pol2cart(data.flyTheta(data.count),sum(Vfwd));
[Xss,Yss]                   =  pol2cart(data.flyTheta(data.count)-(pi/2),sum(Vss)); 

 %% update X and Y positions (in tick positions)
data.Xpos(data.count)       =  ((data.Xpos(data.count-1)+round(Xfwd+Xss)));
data.Ypos(data.count)       =  (data.Ypos(data.count-1)+round(Yfwd+Yss));

% deals with case where fly exits virtual arena
if sqrt((data.Xpos(data.count)-data.arenaRadius)^2 + (data.Ypos(data.count)-data.arenaRadius)^2) >= data.arenaRadius
   data.Xpos(data.count)=data.Xpos(data.count-1); 
   data.Ypos(data.count)=data.Ypos(data.count-1);
   data.outsideArena(data.count)=1;
end

% make normalized location values for perspective calculation. range is
% -10:10
normalizedX = (data.Xpos(data.count)-data.arenaRadius)/data.arenaRadius;
normalizedY = (data.Ypos(data.count)-data.arenaRadius)/data.arenaRadius;

%% updates the laser. now is as simple as lookup table of environment values
laserPower                  = tempEnv(data.Ypos(data.count), data.Xpos(data.count));
data.laserPower(data.count) = laserPower;

%% write data to other instances
fwrite(tcp, [1 normalizedX normalizedY data.flyTheta(data.count) 2], 'double')
ao.outputSingleScan([laserPower 1 1 0])

if laserPower > info.arenaPowerLevels(4)
    data.OOB_frames = data.OOB_frames+1;
end

if data.Ypos(data.count)>1000 && data.Xpos(data.count)>950
   data.deadEnd_frames = data.deadEnd_frames+1;
end

if laserPower > info.arenaPowerLevels(5)
    data.edgeFrames = data.edgeFrames+1;
end

if laserPower < info.arenaPowerLevels(2)
    data.safeFrames = data.safeFrames+1;
end

%% 

%% checks frame rate
data.timeStamp(data.count)=toc(timer1);

end       



       
