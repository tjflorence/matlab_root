%% script to write tcp data to
%  testing tcp connection for parallel frame data

% make tcp client
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
dataSize    = zeros(1,5);
s           = whos('dataSize');
set(tcpipServer,'OutputBufferSize',s.bytes);
disp('waiting for cxn')
fopen(tcpipServer);
disp('connected')

% choose frame rate
frameRate = 30;

% dummy data to write to port
expVal      = [zeros(1,50) ones(1,950)];
yData       = zeros(1,1000);
Theta       = zeros(1,1000);
xData       = linspace(-.9,.9,1000);
patternCode = [ones(1,300) 2*ones(1,300) 3*ones(1,400)];

for aa = 1:length(yData)
   
    dataToWrite = [expVal(aa) xData(aa) yData(aa) Theta(aa) patternCode(aa)];
    fwrite(tcpipServer, dataToWrite, 'double');
    pause(.001)
    
end

fclose(tcpipServer)