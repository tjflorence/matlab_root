%% clean up before starting experiment
clear all
close all
delete(instrfind)
imaqreset
daqreset


%% enter notes
info.notes = '48A08AD x UAS-ShiTS; 4 days old, two diags, go left';

%% cd to most recent calibration file and load value
cd('C:\tempCalib\calibFile7353706542\')
calibFile = dir('processed_*');
load(calibFile.name)
info.ticksPerMM = calibInfo.mTickPerMM*1.5;

%% enter temperature values
% then creates a large matrix with thermal environment variables
info.arenaPowerLevels   = [1    2     3   4   5];    
info.edgePowerLevels    = [6    7];
info.setTemps           = [24 35 40];
[tempEnvStruct]         = makeRuschaEnv2(info);
info.tempEnvs           = tempEnvStruct;
envLength               = length(info.tempEnvs(1).left_go);

% enter a few parameters,     
info.time               = datestr(now,'yyyyddmmHHMMSS');
info.exName             = [info.time,'_stimulusTest'];
info.conditionName      = 'trial_';
info.mainDirectory      = 'C:\TJ\VR_Maze_Experiment_Data\y_Experiment';
info.preTest            = 60;%length of time before first trial;
info.preOnTime          = 30;
info.evidenceTime       = .01;
info.trialTime          = [300];
info.stripeFixTime      = [60];
info.XYstart            = [ 600,      900,    0 ];
info.preTrialStart      = [envLength/2 envLength/2 0 ];
info.numTrials          = 10;
info.checkEnv           = tempEnvStruct.both_go;
info.acquire_images     = 0;% grab video frames
info.rotGain            = .3; % rotation fudge factor. 
info.sampleRate         = 50;
info.addBG_texture      = 1;
% additional parameters specifying variations on the experiment protocol 
info.goLeft             = 0;
info.isControl          = 1;
info.doTestFlip         = 0;
info.skipStripe         = 0;
info.numReps            = 30;


if info.isControl == 1
   
    binaryVec = [zeros(1,info.numReps/2), ones(1,info.numReps /2)];
    randInds  = randperm(info.numReps);
    info.coolSpotLocation = binaryVec(randInds);
    
end

if info.doTestFlip == 1
 %   binaryVec = [zeros(1,2), ones(1,2)];
 %   randInds  = randperm(4);
 %   info.testFlipVec = binaryVec(randInds);
 
    info.testFlipVec = [1 1 1 1];
else
    info.testFlipVec = [0 0 0 0];
end 

% make tcp server, and write a "lights off"
tcp_handle = init_tcp();
Panel_tcp_com('all_off');


%% process pattern info
info.displayHeight      = 32;
info.displayWidth       = 96;
info.overSample         = 7;
pattern.Panel_map       = [12 8 4 11 7 3 10 6 2  9 5 1;...
                           24 20 16 23 19 15 22 18 14 21 17 13; ...
                           36 32 28 35 31 27 34 30 26 33 29 25; ...
                           48 44 40 47 43 39 46 42 38 45 41 37];
info.BitMapIndex        = process_panel_map(pattern);
info.NumPanels          = length(info.BitMapIndex);

%% make pattern structure
patternStruct = makePatternStruct;

%% Automatically generate directories
info.date=datestr(now,'yyyy-mm-dd');
info.directory=[info.mainDirectory, '\', info.date];
cd(info.mainDirectory);
mkdir(info.date);
cd(info.directory)
mkdir(info.exName);
cd(info.exName);
cd([info.directory '\' info.exName]);
save([info.exName, '-info_file'],'info');

% copy all files used to run the experiment
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\VR_laserPosition_train_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\VR_laserPosition_test_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\VR_laserPosition_pretrain_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\Tethered_Temp_Pref_Maze_Parallel_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\display_external_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\makePatternStruct.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\makeRuschaEnv2.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\make_frame_vector_faster2.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\sample_wall_positions_circ_elev_V4.m', [info.directory '\' info.exName])

%% initialize daq 
ao = daq.createSession ('ni');
ao.addAnalogOutputChannel('Dev1', [0], 'Voltage');
ao.addDigitalChannel('Dev1', 'Port1/Line0:2', 'OutputOnly');
ao.outputSingleScan([-4.99 1 0 0])
startTraining = info.skipStripe;

%% run selection trial to see if fly responds to pattern
preTrainNum = 1;
while startTraining == 0
    trialName = ['pre_selection_' num2str(preTrainNum)]

    [data_out] = VR_laserPosition_pretrain_tcp_all_one(info.arenaPowerLevels(4)*ones(1800,1800), info.stripeFixTime, info.exName,[trialName],info.directory,...
       [900,900,0],info.rotGain,info.sampleRate,info, info.acquire_images, ao);
    data = data_out;

        %% plot results for viewing
    subplot(2,1,1)
    imagesc(flipud(data.tempEnv))
    hold on
    plot(data.Xpos, data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off
    
%    plotAlignmentTrials(data)
    
    startTraining = input('continue training? 1 = yes');
    preTrainNum = preTrainNum+1;
    
    pause(1)
end
close all

%% now run test trial
preTestPref = 0;
while preTestPref == 0
    for testNum = 1:4
        trialName = ['env6_TEST00_' num2str(testNum)];

        flipThisTrial = info.testFlipVec(testNum);
        %% run test trial
        % analog out 1 and 2 high, trial running
        [data_out]=VR_laserPosition_test_tcp_all_one(tempEnvStruct.both_go_noCool, info.trialTime,info.exName,[trialName],info.directory,...
            info.XYstart,info.rotGain,info.sampleRate,info,ao,info.preOnTime,info.evidenceTime,info.checkEnv, flipThisTrial);
        % trial over, ao 1 high ao 2 low
    
        data = data_out;
        if testNum == 1
            imagesc(flipud(data.tempEnv))
        end
        hold on
        plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth',4)
        plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth',2)
        axis equal off
        title(trialName, 'interpreter', 'none')
        hold off
    
        pause(1)
    end
    
    preTestPref = input('continue training? 1 = yes');

end

%% Staged Training
trialNum = 0;
for stageNum = 5
    nextStage =  0;
    envRep = 0;
    
  for rep = 1:20
    %while nextStage == 0

        envRep = envRep+1;
        trialNum = trialNum+1;
    
        if envRep <10
            envRepString = ['0' num2str(envRep)];
        else
            envRepString = num2str(envRep);
        end
    
        if trialNum <10
            trialNumString = ['0' num2str(trialNum)];
        else
            trialNumString = num2str(trialNum);
        end
  
        trialName = ['env' num2str(stageNum) '_trial' trialNumString '_rep' envRepString]
        
        if info.isControl == 1
            
            if info.coolSpotLocation(trialNum) == 0
                envToUse = tempEnvStruct.left_go;
            elseif info.coolSpotLocation(trialNum) == 1
                envToUse = tempEnvStruct.right_go;
            end
        else
            if info.goLeft == 1
                envToUse = tempEnvStruct.left_go;
            else
                envToUse = tempEnvStruct.right_go;
            end
        end
 
    %% run experiment trial
        [data_out]  =   VR_laserPosition_train_tcp_all_one(envToUse, info.trialTime,info.exName,[trialName],info.directory,...
            info.XYstart,info.rotGain,info.sampleRate,info, ao,info.preOnTime,info.evidenceTime, info.checkEnv);
        data = data_out;

    %% plot results for viewing
    imagesc(flipud(envToUse))
    hold on
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off

    pause(1)
    %% input if fly should progress
%   nextStage = input('Ok to move on? 1 = yes');

    end

end



%% now run test trial
for testNum = 1:4
    trialName = ['env6_TESTA_' num2str(testNum)];

    flipThisTrial = info.testFlipVec(testNum);
    %% run test trial
    % analog out 1 and 2 high, trial running
    [data_out]=VR_laserPosition_test_tcp_all_one(tempEnvStruct.both_go_noCool, info.trialTime,info.exName,[trialName],info.directory,...
        info.XYstart,info.rotGain,info.sampleRate,info,ao,info.preOnTime,info.evidenceTime,info.checkEnv, flipThisTrial);
    % trial over, ao 1 high ao 2 low
    
    data = data_out;
    if testNum == 1
        imagesc(flipud(data.tempEnv))
    end
    hold on
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off
    
    pause(1)

end

%% Staged Training

for stageNum = 5
    nextStage =  0;
    
    for rep = 21:30
    %while nextStage == 0

        envRep = envRep+1;
        trialNum = trialNum+1;
    
        if envRep <10
            envRepString = ['0' num2str(envRep)];
        else
            envRepString = num2str(envRep);
        end
    
        if trialNum <10
            trialNumString = ['0' num2str(trialNum)];
        else
            trialNumString = num2str(trialNum);
        end
  
        trialName = ['env' num2str(stageNum) '_trial' trialNumString '_rep' envRepString]
        
        if info.isControl == 1
            
            if info.coolSpotLocation(trialNum) == 0
                envToUse = tempEnvStruct.left_go;
            elseif info.coolSpotLocation(trialNum) == 1
                envToUse = tempEnvStruct.right_go;
            end
        else
            if info.goLeft == 1
                envToUse = tempEnvStruct.left_go;
            else
                envToUse = tempEnvStruct.right_go;
            end
        end
 
    %% run experiment trial
        [data_out]  =   VR_laserPosition_train_tcp_all_one(envToUse, info.trialTime,info.exName,[trialName],info.directory,...
            info.XYstart,info.rotGain,info.sampleRate,info, ao,info.preOnTime,info.evidenceTime, info.checkEnv);
        data = data_out;

    %% plot results for viewing
    imagesc(flipud(envToUse))
    hold on
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off

    pause(1)
    %% input if fly should progress
%   nextStage = input('Ok to move on? 1 = yes');

    end

end

%% now run test trial
for testNum = 1:4
    trialName = ['env6_TESTB_' num2str(testNum)];

    flipThisTrial = info.testFlipVec(testNum);
    %% run test trial
    % analog out 1 and 2 high, trial running
    [data_out]=VR_laserPosition_test_tcp_all_one(tempEnvStruct.both_go_noCool, info.trialTime,info.exName,[trialName],info.directory,...
        info.XYstart,info.rotGain,info.sampleRate,info,ao,info.preOnTime,info.evidenceTime,info.checkEnv,  flipThisTrial);
    % trial over, ao 1 high ao 2 low
    
    data = data_out;
    if testNum == 1
        imagesc(flipud(data.tempEnv))
    end
    hold on
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off
    
    pause(1)

end

% turn off all analog outs, experiment complete
Panel_tcp_com('all_off')
ao.outputSingleScan([-4.99 0 0 0])
cd (['C:\'])
close_tcp;
