function  trial_data = acquire_motion(metaData)
%% declare global data structure
global trialData

%% unpack metadata
trialTime = metaData.trial_time;
acqFreq   = metaData.acq_freq;

%% initialize data structures
trialData.timeStamp = nan(1:(trialTime*acqFreq)+100);
trialData.Vfwd      = nan(1:(trialTime*acqFreq)+100);
trialData.Vss       = nan(1:(trialTime*acqFreq)+100);
trialData.Om        = nan(1:(trialTime*acqFreq)+100);
trialData.count     = 0;
 
%% connect to camera, usb serial mode
COMport = 'COM5';
%Connect to serial object
%Open serial port interface
%__________________________________________________________________
s = serial(COMport);
s.baudrate              = 1250000;
s.bytesavailablefcn     = {@baf}; %function called whenever data is available
s.bytesavailablefcncount= 48000/acqFreq; %12 bytes per sample, 4kSamples/sec = 48000 bytes per second.  20Hz=2400
s.bytesavailablefcnmode = 'byte';
s.inputbuffersize       = 50000;
fopen(s);

%Default to Vf,Vs,Om mode
fwrite(s,[246,0])
% removes any data from buffer
if s.bytesavailable>0
     fread(s,s.bytesavailable); 
end
 
%% start tracking
fwrite(s,[255,0]); % starts tracking acquisition
while trialData.count < (trialTime*acqFreq)+1;
    pause(.001) % waits for experiment to finish
end

% stops logging
fwrite(s,[254,0]);

% keep data to output
trial_data = trialData;

% clean up serial object
fclose(s);
delete(s);
end


%Bytes Available Function
function baf(obj,event)
global trialData
 
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
%Raw Data
Vfwd        = raw(zinds+2)-128;
Vss         = raw(zinds+3)-128;
Omega       = raw(zinds+4)-128;

trialData.count              =   data.count+1;
trialData.Om(data.count)     =   Omega;
trialData.Vfwd(data.count)   =   Vfwd;
trialData.Vss(data.count)    =   Vss;
end


