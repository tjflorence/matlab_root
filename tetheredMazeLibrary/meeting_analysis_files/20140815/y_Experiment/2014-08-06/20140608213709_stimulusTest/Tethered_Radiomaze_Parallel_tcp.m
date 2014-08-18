%% clean up before starting experiment
clear all
close all
delete(instrfind)
imaqreset
daqreset


%% enter notes
info.notes = '48A08AD x UAS-Kir; 6 days old; shifted';

%% cd to most recent calibration file and load value
%cd('C:\tempCalib\calibFile7353706542\')
%calibFile = dir('processed_*');
%load(calibFile.name)
info.ticksPerMM = 3.45;

%% enter temperature values
% then creates a large matrix with thermal environment variables
info.arenaPowerLevels   = [1    2     3   4   5];    
info.edgePowerLevels    = [6    7];
info.setTemps           = [24 35 40];
load('C:\tempEnv1.mat')
tempEnvStruct           = tempEnv;
info.tempEnvs           = tempEnvStruct;
envLength               = length(info.tempEnvs.train_to_11_pm);

% enter a few parameters,     
info.time               = datestr(now,'yyyyddmmHHMMSS');
info.exName             = [info.time,'_stimulusTest'];
info.conditionName      = 'trial_';
info.mainDirectory      = 'C:\TJ\VR_Maze_Experiment_Data\y_Experiment';
info.preTest            = 2*60;%length of time before first trial;
info.preOnTime          = 60;
info.evidenceTime       = .01;
info.trialTime          = [300];
info.stripeFixTime      = [60];
info.XYstart            = [715, 630, pi/3;...
                           1183, 890, pi];
info.preTrialStart      = [envLength/2 envLength/2 0 ];
%info.checkEnv_4pms      = tempEnvStruct.refEnv_flipped;
%info.checkEnv_8pms      = tempEnvStruct.refEnv;
info.acquire_images     = 0;% grab video frames
info.rotGain            = .4; % rotation fudge factor. 
info.sampleRate         = 50;
info.addBG_texture      = 1;
% additional parameters specifying variations on the experiment protocol 
info.goLeft             = 0;
info.randoStart         = 0;
info.isControl          = 0;
info.doTestFlip         = 1;
info.skipStripe         = 0;
info.numReps            = 30;

numReps = info.numReps;
%% take care of randomization vectors
if info.randoStart == 1
    binaryVec = [zeros(1,numReps/2), ones(1,numReps/2)];
    randInds  = randperm(numReps);
    info.start4pm = binaryVec(randInds);
else
    info.start4pm = ones(1, numReps);
end

if info.isControl == 1
    binaryVec = [zeros(1,numReps/2), ones(1,numReps/2)];
    randInds  = randperm(numReps);
    info.flipCoolSpot = binaryVec(randInds);
else
    info.flipCoolSpot = zeros(1, numReps);
end


if info.doTestFlip == 1
   binaryVec = [zeros(1,2), ones(1,2)];
   randInds  = randperm(4);
   info.testFlipVec = binaryVec(randInds);
 
   info.testFlipVec = [1 1 1 1];
else
    info.testFlipVec = [0 0 0 0];
end 

% make tcp server for data surround, and write a "lights off"
tcpipServer = tcpip('0.0.0.0',55000,'NetworkRole','Server');
dataSize    = 3.3333*ones(1,5);
s           = whos('dataSize');
set(tcpipServer,'OutputBufferSize',s.bytes);
disp('waiting for cxn')
fopen(tcpipServer);
disp('connected')
fwrite(tcpipServer, [1 0 0 0 1], 'double');


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
% %creates the pattern
% bars=repmat([ones(32,8),zeros(32,8)],1,2);
% stripes=repmat([ones(8,32);zeros(8,32)],2,1);
% diagonal=circshift(bars(1,:),[0,1]);
% for f=1:31
%     diagonal=[diagonal;circshift(diagonal(1,:),[0,f])];
% end
% 
% SBD = [bars stripes diagonal];
% SBD = circshift(rot90(SBD,2), [0 23] );
patternStruct = makePatternStructSBD;

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
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\Tethered_Radiomaze_Parallel_tcp.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\display_external_tcp_timerfcn.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\makePatternStructSBD.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\makeRadioactiveLand.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\make_frame_vector_faster2.m', [info.directory '\' info.exName])
copyfile('C:\MatlabRoot\treadmill-2013\parallel_async_mode\tcp_ip_method\sample_wall_positions_circ_elev_V4.m', [info.directory '\' info.exName])

%% initialize daq 
ao = daq.createSession ('ni');
ao.addAnalogOutputChannel('Dev2', [0], 'Voltage');
ao.addDigitalChannel('Dev2', 'Port1/Line0:2', 'OutputOnly');
ao.outputSingleScan([-4.99 1 0 0])
startTraining = info.skipStripe;

%% run selection trial to see if fly responds to pattern
preTrainNum = 1;
while startTraining == 0
    trialName = ['pre_selection_' num2str(preTrainNum)]

    [data_out] = VR_laserPosition_pretrain_tcp(info.arenaPowerLevels(4)*ones(1800,1800), info.stripeFixTime, info.exName,[trialName],info.directory,...
       [900,900,0],info.rotGain,info.sampleRate,info, info.acquire_images, ao, tcpipServer);
    data = data_out;

    %% plot results for viewing
    subplot(2,1,1)
    imagesc(flipud(data.tempEnv))
    set(gca, 'YDir', 'normal')
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

%% now run test trial
for testNum = 1:4
    trialName = ['env6_TEST00_' num2str(testNum)];

        flipThisTrial = info.testFlipVec(testNum);
        if flipThisTrial == 0
            refEnv      = tempEnvStruct.ref_from_7pm;
            startVec    = info.XYstart(1,:);
            testEnv     = tempEnvStruct.ref_from_7pm;
        elseif flipThisTrial == 1
            refEnv      = tempEnvStruct.ref_from_3pm;
            startVec    = info.XYstart(2,:);
            testEnv     = tempEnvStruct.ref_from_3pm;         
        end
        
        %% run test trial
        % analog out 1 and 2 high, trial running
        [data_out]=VR_laserPosition_train_tcp(testEnv, info.trialTime,info.exName,[trialName],info.directory,...
                                            startVec,info.rotGain,info.sampleRate,info,ao,info.preOnTime,...
                                            info.evidenceTime,refEnv, tcpipServer);
        % trial over, ao 1 high ao 2 low
    
        data = data_out;
        
        if testNum == 1
            imagesc(data.tempEnv)
        end
        
        set(gca, 'YDir', 'normal')
        
        hold on
        plot(data.Xpos, data.Ypos, 'Color', 'w', 'LineWidth',4)
        plot(data.Xpos, data.Ypos, 'Color', 'k', 'LineWidth',2)
        axis equal off
        
        title(trialName, 'interpreter', 'none')
        hold off
    
        ao.outputSingleScan([3 1 1 1])
        pause(1)
        
end
    
    
    preTestPref = input('continue training? 1 = yes');

end

%% Staged Training
trialNum = 0;
for stageNum = 5
    nextStage =  0;
    envRep = 0;
    
  for rep = 1:numReps
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
        
        %% handles case if start location is randomized
        if info.start4pm(envRep) == 1
            startVec    = info.XYstart(2,:);
            refEnv      = tempEnvStruct.ref_from_3pm;
        else
            startVec    = info.XYstart(1,:);
            refEnv       = tempEnvStruct.ref_from_7pm;
        end

        %% handles if cool spot location is randomized (uncoupled control)
        if info.flipCoolSpot(envRep) == 1
            envToUse    = tempEnvStruct.train_to_3_pm;
        else
            envToUse    = tempEnvStruct.train_to_11_pm;
        end
    %% run experiment trial
        [data_out]  =   VR_laserPosition_train_tcp(envToUse, info.trialTime, info.exName, trialName, info.directory,...
                        startVec, info.rotGain, info.sampleRate, info, ao,info.preOnTime,info.evidenceTime,...
                        refEnv, tcpipServer);
        data = data_out;


    ao.outputSingleScan([data.laserPower(data.count-5) 1 1 1])

    pause(5)
    % plot results for viewing
    imagesc(envToUse)
    set(gca, 'YDir', 'normal')
    hold on
    plot(data.Xpos, data.Ypos, 'Color', 'w', 'LineWidth',4)
    plot(data.Xpos, data.Ypos, 'Color', 'k', 'LineWidth',2)
    axis equal off
    title(trialName, 'interpreter', 'none')
    hold off
    
        



    
    
        

    end

end



%% now run test trial
for testNum = 1:4
    trialName = ['env6_TESTA_' num2str(testNum)];

        flipThisTrial = info.testFlipVec(testNum);
        if flipThisTrial == 0
            refEnv      = tempEnvStruct.ref_from_7pm;
            startVec    = info.XYstart(1,:);
            testEnv     = tempEnvStruct.ref_from_7pm;
        elseif flipThisTrial == 1
            refEnv      = tempEnvStruct.ref_from_3pm;
            startVec    = info.XYstart(2,:);
            testEnv     = tempEnvStruct.ref_from_3pm;         
        end
        
        %% run test trial
        % analog out 1 and 2 high, trial running
        [data_out]=VR_laserPosition_train_tcp(testEnv, info.trialTime,info.exName,[trialName],info.directory,...
                                            startVec,info.rotGain,info.sampleRate,info,ao,info.preOnTime,...
                                            info.evidenceTime,refEnv, tcpipServer);
        % trial over, ao 1 high ao 2 low
    
        data = data_out;
        
        if testNum == 1
            imagesc(data.tempEnv)
        end
        
        set(gca, 'YDir', 'normal')
        
        hold on
        plot(data.Xpos, data.Ypos, 'Color', 'w', 'LineWidth',4)
        plot(data.Xpos, data.Ypos, 'Color', 'k', 'LineWidth',2)
        axis equal off
        
        title(trialName, 'interpreter', 'none')
        hold off
    
        ao.outputSingleScan([3 1 1 1])
        pause(1)
        
end
    


% turn off all analog outs, experiment complete
fwrite(tcpipServer, [1 0 0 0 1], 'double');
ao.outputSingleScan([-4.99 0 0 0])
cd (['C:\'])

