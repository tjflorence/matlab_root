
%% create daq object
daqObj = daq.createSession('ni');
daqObj.addAnalogOutputChannel('Dev1', [0:1], 'Voltage');
% daq AO_0 is laser power
% daq AO_1 is thermistor control

% set experiment params
numReps = 5;
timeOn = 120;
timeOff = 120;
laserPowerOn = -3.3;
laserPowerOff = -4.99;
thermistorOn = 5;
thermistorOff = 0;

%%
disp('****************************')
disp('     running experiment    ')
disp('****************************')
for aa = 1:numReps
    
    disp('============================')
    disp(['running trial ' num2str(aa) '/' num2str(numReps)])
    disp('heating elements ON')    
   
    daqObj.outputSingleScan([laserPowerOn thermistorOn])
    pause(timeOn)

    disp('heating elements OFF')    
    
    daqObj.outputSingleScan([laserPowerOff thermistorOff])
    pause(timeOff)
    
    disp(['trial ' num2str(aa) 'over'])
    disp('============================')

    
end