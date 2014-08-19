%% do pid control for thermal simulation
% clean up everyrthing from before
clear all
close all
delete(instrfind)
try
    stop(thermalCam)
catch
end
imaqreset
daqreset

load('C:\thermal_data\diffInds.mat')

% create unique filename, set up save directory
metaData.time = datestr(now, 'yyyyddmmHHMMSS');
metaData.fileName = [metaData.time '_thermImgData'];
metaData.date = datestr(now, 'yyyy-mm-dd');
cd('C:\thermal_data\')
mkdir(metaData.date)
cd(['C:\thermal_data\' metaData.date])
mkdir(metaData.fileName)
cd(metaData.fileName)
copyfile('C:\matlabroot\thermal_imaging\PID_control_phys.m', pwd)

%% these variables need to be declared before experiment starts
trialNum    = 1;
preTrialNum = 1;
resetTrial = 0;
runGetInds = 0;
lastSetTemp = 24;
isStarted = 0;

%% create camera and daq object
% first, thermal cam
thermalCam = videoinput('gige');
% second, daq obj
daqObj = daq.createSession('ni');
daqObj.addAnalogInputChannel('Dev1', [0], 'Voltage');
daqObj.addDigitalChannel('Dev1', 'Port1/Line0:2', 'InputOnly' );
daqObj.addAnalogOutputChannel('Dev1', [0:1], 'Voltage');
daqOut = daqObj.inputSingleScan;
digital_0 = daqOut(2);
digital_1 = daqOut(3);
digital_2 = daqOut(4);

%% create first thermal object
thermalObj = flyTempObj();

%% pause until primary matlab is ready
disp('waiting for signal from other matlab')
while digital_0 == 0

    daqObj.outputSingleScan([-4.99 0])
    daqOut = daqObj.inputSingleScan;
    digital_0 = daqOut(2);
    digital_1 = daqOut(3);
    digital_2 = daqOut(4);
    pause(.01)
end

%% before starting everything, 
daqObj.outputSingleScan([-3.5 5])
disp('run thermal experiment')
startTime = tic;

%% following loop runs while experiment is true (d0 ==1)
while digital_0 == 1
    
    % read from daq
    daqOut = daqObj.inputSingleScan();
    digital_0 = daqOut(2);
    digital_1 = daqOut(3);
    digital_2 = daqOut(4);
    
    %% following loop controls while a trial is running
    while digital_1 == 1
     
        % set this to save trial when we are done with tria
        resetTrail = 1;
    
        % if we haven't acquired the correct pixel inds, do so now
        if digital_2 == 0 && runGetInds == 0
            selectFlyThermalInds(thermalCam);
            pause(.1)
            load('C:\thermal_data\diffInds.mat')
            runGetInds = 1;
        end   
        
        % start thermal camera if it isn't started
        if isStarted == 0
            start(thermalCam)
            isStarted = 1;
        end
        
        % read from daq, parse output
        daqOut = daqObj.inputSingleScan;
        setTempIdx   = round(daqOut(1));
        if setTempIdx < 1
            setTempIdx = 1;
        end
        digital_0 = daqOut(2);
        digital_1 = daqOut(3);
        digital_2 = daqOut(4);
        
        % read from thermal camera
        thermalFrame = getsnapshot(thermalCam);
        temps_C      = (thermalFrame*thermalObj.thermCalc(1)) + thermalObj.thermCalc(2);
        sortedTemps  = flipud(sort((double(temps_C(diffInds)))));
        hotThird     = sortedTemps(1:ceil(numDiffInds*.3));
        measuredTemp = mean(hotThird);
        
        % read measured and set temp data into thermal object, and
        % calculate output
        thermObj.advance();
        thermObj.read_stemp(setTempIdx);
        thermObj.read_mtemp(measuredTemp);
        thermObj.calc_error();
        thermObj.calc_output();
        
        % put output on daq
        daqObj.outputSingleScan(thermObj.current_output);
        
        pause(.005)
    end
    
    if resetTrial == 1
        stop(thermalCam)
        isStarted   = 0;
        runGetInds  = 0;
        
        
        if digital_2 == 0
            save_name = ['preTrial_0' num2str(preTrialNum)];
            preTrialNum = preTrialNum + 1;
        elseif trialNum < 10
            save_name = ['tempTrial_0' num2str(trialNum)];
            trialNum = trialNum + 1;
        else
            save_name = ['tempTrial_' num2str(trialNum)];
            trialNum = trialNum + 1;
        end
        
        close all
        
        %% plot and save
        thermObj.simple_plot();
        thermObj.saveData(save_name);
        
        %% re-set memory
        thermObj = flyTempObj();
        
        resetTrial = 0;
    end
    
    
    daqObj.outputSingleScan([-3.5 5])

    
end

daqObj.outputSingleScan([-4.99])
stop(thermalCam)

cd('C:\')
