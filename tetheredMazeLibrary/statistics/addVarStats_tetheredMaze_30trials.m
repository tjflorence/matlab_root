function addVarStats_tetheredMaze_30trials(directory)
%% add additional stats to tethered data files
% note: I want to be organized. each additional var should have its own
% function. This will lend modularity 
global info

    cd(directory)
    homeDir = pwd;
    
    mkdir('processed_files')
    saveDir = [homeDir '/processed_files/'];
    
    infoFile = dir('*info*');
    load(infoFile.name)
    
  

    try
        rawFiles = dir('*RAW*');
        delete(rawFiles.name)
    catch
        disp('no raw files') 
    end

    trialDataFiles  = dir('*trial*');
    testDataFiles   = dir('*TEST*');
    
    summaryData.outcomeVec      = nan(1,30);
    summaryData.fracTimeCold    = nan(1,30);

%% add vars to trial data
    for aa = 1:20
        load(trialDataFiles(aa).name)
       
        data = calcExecuteTime(data);
        data = calcDistance(data);
        data = calcSpeed(data);
        
        data = calcTrialState(data,info);    

        data = normalizeLaserPower(data);
        data = calcTimeInZones(data, info,aa);
      %  data = calcSafeZoneStats(data, info);
       % data = calcEdgeStats(data);
        %data = calcSafeZoneStats(data, info);
       % data = calcSidePrefence(data,info);
 
        data = assignOutcomeCode(data, info, aa);
        
        summaryData.outcomeVec(aa)       = data.outcomeCode;
        summaryData.fracTimeCold(aa)     = data.fracTimeInCold;
 
       % alignedSpeedTraces = calcEdgeAlignedSpeedTraces(data,info);
        
        save([saveDir 'processed_' trialDataFiles(aa).name], 'data')
        clear data
    end

    for aa = 21:24
        
        load(testDataFiles(aa-20).name)
       
        data = calcExecuteTime(data);
        data = calcDistance(data);
        data = calcSpeed(data);
        
        data = calcTrialState(data,info);    

        data = normalizeLaserPower(data);
        data = calcTimeInZones(data, info,aa);
        data = calcSafeZoneStats(data, info);
      %  data = calcEdgeStats(data);
       % data = calcSafeZoneStats(data, info);
        data = calcSidePrefence(data,info);
 
        data = assignOutcomeCode(data, info, aa);
        
        summaryData.outcomeVec(aa)       = data.outcomeCode;
        summaryData.fracTimeCold(aa)     = data.fracTimeInCold;
 
      %  alignedSpeedTraces = calcEdgeAlignedSpeedTraces(data,info);
        
        save([saveDir 'processed_' testDataFiles(aa-20).name], 'data')
        clear data

    end

    for aa = 25:34
        load(trialDataFiles(aa-4).name)
       
        data = calcExecuteTime(data);
        data = calcDistance(data);
        data = calcSpeed(data);
        
        data = calcTrialState(data,info);    

        data = normalizeLaserPower(data);
        data = calcTimeInZones(data, info,aa);
       % data = calcSafeZoneStats(data, info);
       % data = calcEdgeStats(data);
        data = calcSafeZoneStats(data, info);
        data = calcSidePrefence(data,info);
 
        data = assignOutcomeCode(data, info, aa);
        
        
        summaryData.outcomeVec(aa)       = data.outcomeCode;
        summaryData.fracTimeCold(aa)     = data.fracTimeInCold;
 
     %   alignedSpeedTraces = calcEdgeAlignedSpeedTraces(data,info);
        
        save([saveDir 'processed_' trialDataFiles(aa-4).name], 'data')
        clear data
        
    end

    for aa = 35:38
        
        load(testDataFiles(aa-30).name)
       
        data = calcExecuteTime(data);
        data = calcDistance(data);
        data = calcSpeed(data);
        
        data = calcTrialState(data,info);    

        data = normalizeLaserPower(data);
        data = calcTimeInZones(data, info,aa);
        data = calcSafeZoneStats(data, info);
        data = calcEdgeStats(data);
        data = calcSafeZoneStats(data, info);
        data = calcSidePrefence(data,info);
 
        data = assignOutcomeCode(data, info, aa);
        
        summaryData.outcomeVec(aa)       = data.outcomeCode;
        summaryData.fracTimeCold(aa)     = data.fracTimeInCold;
 
     %   alignedSpeedTraces = calcEdgeAlignedSpeedTraces(data,info);
        
        save([saveDir 'processed_' testDataFiles(aa-30).name], 'data')
    %    save('summaryData', 'summaryData')
        clear data
        
    end    

end


function [data] = calcExecuteTime( data )
%% function calculates execute times for frame rate
    data.executeTime = nan(1,data.count);
    
    data.executeTime(1) = data.timeStamp(1);
    for ii = 2:data.count
        
        data.executeTime(ii) = data.timeStamp(ii)-data.timeStamp(ii-1);
    
    end
    
    data.executeTime_mean = nanmean(data.executeTime);
    data.mean_Hz = 1/data.executeTime_mean;

end

function data = calcDistance(data )
%% calculates distance moved in each frame
    data.distanceMoved = nan(1,data.count);
    
    data.distanceMoved(1) = 0;
    for ii = 2:data.count
       
        data.distanceMoved(ii) = pdist([data.Xpos(ii) data.Ypos(ii) ;  data.Xpos(ii-1) data.Ypos(ii-1)]);
        
    end
    
    data.cumDistMoved = cumsum(data.distanceMoved);
    data.totalDistMoved = data.cumDistMoved(end);
    
    data.radius = pdist([data.Xpos(1) data.Ypos(1) ; data.Xpos(data.count) data.Ypos(data.count)]);
    data.straightness = data.radius/data.totalDistMoved;

end

function data = calcSpeed(data)
%% calculates speed on a perframe basis
% then smoothes speed with 500ms second moving avg
% then finds speed within each temp zone
global info

    data.speed_perframe = nan(1,data.count);
    for ii = 1:data.count
       data.speed_perframe(ii) = data.distanceMoved(ii)/data.executeTime(ii); 
    end

   % now smooth. 20 fps means window should be 10 fr 
    data.speed_500ms_sm = smooth(data.speed_perframe, 20);
   % sometimes this fcn gives neg values. that's impossible. fix. 
    data.speed_500ms_sm(data.speed_500ms_sm<0) = 0;
    
    z1_inds = find(data.laserPower==info.arenaPowerLevels(1));
    z2_inds = find(data.laserPower==info.arenaPowerLevels(2));
    z3_inds = find(data.laserPower==info.arenaPowerLevels(3));
    edgeInds = find(data.laserPower>info.arenaPowerLevels(3));
    
    
    if ~isempty(z1_inds)
        data.meanSpeed_z1 = mean(data.speed_500ms_sm(z1_inds));
    else
        data.meanSpeed_z1 = nan;
    end
    
    if ~isempty(z2_inds)
        data.meanSpeed_z2 = mean(data.speed_500ms_sm(z2_inds));
    else
        data.meanSpeed_z2 = nan;
    end

    if ~isempty(z3_inds)
        data.meanSpeed_z3 = mean(data.speed_500ms_sm(z3_inds));
    else
        data.meanSpeed_z3 = nan;
    end

    if ~isempty(edgeInds)
        data.meanSpeed_edge = mean(data.speed_500ms_sm(edgeInds));
    else
        data.meanSpeed_edge = nan;
    end    
end


function data = normalizeLaserPower(data)
%% simple - laser power is -5:5
% want laser power 0-10
global info

    data.laserPower(1) = info.arenaPowerLevels(2);
    data.laserPower_normalized = data.laserPower(1:data.count)+5;
    
    data.setTemps = zeros(1,data.count);
    
    for aa = 1:data.count
       if data.laserPower(aa) > info.arenaPowerLevels(1)-.1 || data.laserPower(aa) < info.arenaPowerLevels(1) 
           data.setTemps(aa) = 24;
       end
       
       if data.laserPower(aa) > info.arenaPowerLevels(2)-.1
           data.setTemps(aa) = 32;
       end
       
       if data.laserPower(aa) > info.arenaPowerLevels(3) -.1
           data.setTemps(aa) = 35;
       end
        
       if data.laserPower(aa) > info.arenaPowerLevels(4) -.1
           data.setTemps(aa) = 37;
       end
        
       if data.laserPower(aa) > info.arenaPowerLevels(5) -.1
           data.setTemps(aa) = 40;
       end
      
       
       if data.laserPower(aa)> info.edgePowerLevels(1) -.1
           data.setTemps(aa) = 42;
       end
       
    end

end

function [data, info] = calcTimeInZones(data, info, trialNum)
%% calculate time in temp1, temp2, temp3
    
    temp1 = info.arenaPowerLevels(1);
    temp2 = info.arenaPowerLevels(2);
    temp3 = info.arenaPowerLevels(3);
    temp4 = info.arenaPowerLevels(4);
    temp5 = info.arenaPowerLevels(5);
    
    % calculate time in lane & time outside lane
    data.frameInLane = zeros(1,data.count);
    for zz = 1:data.count
       
        if data.laserPower(zz) < temp5
           
            data.frameInLane(zz) = 1;
            
        end
        
    end
    data.fracTimeInLane = sum(data.frameInLane)/data.count;
    data.fracTimeOutsideLane = 1-data.fracTimeInLane;
    
    % calculate time to cold spot
    coldIdx = find(data.laserPower<temp2,1,'first');
    if ~isempty(coldIdx)
        data.timeToCoolSpot = data.timeStamp(coldIdx)-data.timeStamp(data.state_4_idx(1));
    else
        data.timeToCoolSpot = nan;
    end
    
    % calculate path length to cold spot
    if ~isempty(coldIdx)
        data.pathToCoolSpot = data.cumDistMoved(coldIdx);
    else
        data.pathToCoolSpot = nan;
    end
    
    % find fraction of time in cool zone
   if (trialNum < 21) || ( (trialNum > 24) && (trialNum < 35) )
        numColdFrames       = length(find(data.laserPower < temp2));
        data.fracTimeInCold = numColdFrames / data.count;
    else
        data.fracTimeInCold = nan;
    end

    
end

function data = calcEdgeStats(data)
global info
    transitionWindow = 40; % define the interval over which the transition probability is examined
    halfTransitionWindow = transitionWindow/2; % how far to look before and after

    data.changeTempZones = zeros(1,data.count);
    % find edge transition points
    for ii = 2:data.count
        if (data.laserPower(ii)~=data.laserPower(ii-1)) && (data.laserPower(ii)<(info.arenaPowerLevels(3)+.05))
            data.changeTempZones(ii)=1;
        end
    end
    
    transitionInds = find(data.changeTempZones==1); % find the index of the transitions
    
    if ~isempty(transitionInds)
        numTransitions = numel(transitionInds); % how many transitions are there
        transitionSuccess =[];
        for jj = 1:numTransitions % iterate over each transition
        
            currentTransitionInd = transitionInds(jj);
            if (currentTransitionInd > halfTransitionWindow) && (abs(currentTransitionInd-data.count)>halfTransitionWindow) %% if the transition is within the window to observer
                laserPowerBefore = data.laserPower(currentTransitionInd-halfTransitionWindow);
                laserPowerAfter = data.laserPower(currentTransitionInd+halfTransitionWindow);
            
                if laserPowerAfter > laserPowerBefore %% if, 500 msec after the transition, the laser power is higher -- then the transition failed
                    transitionSuccess = [transitionSuccess ; 0];
                else % or, if the laser is equal to or less than before the transition, the edge was obeyed
                    transitionSuccess = [transitionSuccess; 1];
                end
            
            end
        
        end
   
    sumTransSuccess = sum(transitionSuccess);
    calcTransTotals=  length(transitionSuccess);
    
    data.transitionSuccessProbability = sumTransSuccess/calcTransTotals;
    data.transitionFailProbability = 1-data.transitionSuccessProbability;
    data.numTransitions = numTransitions;
    
    else
      data.transitionSuccessProbability = nan;
      data.transitionFailProbability = nan;
      data.numTransitions = 0;
    end

end


function  data = calcSafeZoneStats(data, info)
    %% this function calculates stats concerning safe zone behavior
    indFoundSafeZone = find(data.laserPower==info.arenaPowerLevels(1),1, 'first');
    
    if ~isempty(indFoundSafeZone)
        
        data.foundSafeZone = 1;
        data.timeToSafeZone = indFoundSafeZone/data.count*300;
    else
        
        data.foundSafeZone = 0;
        data.timeToSafeZone = nan;
        
    end
end

function alignedSpeedTraces = calcEdgeAlignedSpeedTraces(data,info)
%% for every contact with the edge, this function collects speed data 1
%% second before and 1 second after. 


    transitionWindow = 40; % define the interval over which the transition probability is examined
    halfTransitionWindow = transitionWindow/2; % how far to look before and after

    data.changeTempZones = zeros(1,data.count);
    % find edge transition points
    for ii = 2:data.count
        if( data.laserPower(ii)~=data.laserPower(ii-1))  && (data.laserPower(ii)<(info.arenaPowerLevels(3)+.05))
            data.changeTempZones(ii)=1;
        end
    end
    
    transitionInds = find(data.changeTempZones==1); % find the index of the transitions
    numTransitions = numel(transitionInds); % how many transitions are there
    
    if ~isempty(transitionInds)
    for jj = 1:numTransitions % iterate over each transition
        
        currentTransitionInd = transitionInds(jj);
        if (currentTransitionInd > halfTransitionWindow) && (abs(currentTransitionInd-data.count)>halfTransitionWindow) %% if the transition is within the window to observer
  
            alignedSpeedTraces(jj).speed =  data.speed_500ms_sm((currentTransitionInd-halfTransitionWindow):...
                (currentTransitionInd+halfTransitionWindow));
            
            
            laserPowerBefore = data.laserPower(currentTransitionInd-halfTransitionWindow);
            laserPowerAfter = data.laserPower(currentTransitionInd+halfTransitionWindow);
            
            if laserPowerAfter > laserPowerBefore %% if, 500 msec after the transition, the laser power is higher -- then the transition failed
                alignedSpeedTraces(jj).success = 0;
            else % or, if the laser is equal to or less than before the transition, the edge was obeyed
                alignedSpeedTraces(jj).success = 1;
            end
            
        end
        
    end
    else
        alignedSpeedTraces(1).success = nan;
        alignedSpeedTraces(1).speed = nan;
    end

    if ~exist('alignedSpeedTraces', 'var')
      alignedSpeedTraces(1).success = nan;
      alignedSpeedTraces(1).speed = nan;
    end
   
    

end

function  data = calcSidePrefence(data,info)
%% calculates left or right side preference

data.frameSidePreference = zeros(1,data.count);

    for zz = 1:data.count
    
        if data.Ypos(zz) < 900
            data.frameSidePreference(zz) = -1;
        else
            data.frameSidePreference(zz) = 1;
        end
        
        
    end
    
    data.sidePrefIdx = sum(data.frameSidePreference)/data.count;
    
    data.sidePrefPostChoice  = nan(1,data.count);

    for zz = 1:data.count
    
        if data.Xpos(zz) > 960
            if data.Ypos(zz) < 800
                data.sidePrefPostChoice(zz) = -1;
            elseif data.Ypos(zz) > 1000
                data.sidePrefPostChoice(zz) = 1;
            end
     	end
        
    end
   data.sidePrefIdx_postChoice = nansum(data.sidePrefPostChoice)/(nansum(abs(data.sidePrefPostChoice)));



end

function data = calcTrialState(data,info)

    %% grab indices of zone times
    data.trial_state(1)     =   1;
    state1_start            =   1;
    state1_end              =   find(data.trial_state==1, 1, 'last');
    data.state_1_idx        =   [state1_start state1_end];  %index in dark
    
    state2_start            =   find(data.trial_state==2, 1, 'first');
    state2_end              =   find(data.trial_state==2, 1, 'last');
    data.state_2_idx        =   [state2_start state2_end];
    
    state3_start            =   find(data.trial_state==3, 1, 'first');
    state3_end              =   find(data.trial_state==3, 1, 'last');
    data.state_3_idx        =   [state3_start state3_end];   
    
    state4_start            =   find(data.trial_state==4, 1, 'first');
    state4_end              =   find(data.trial_state==4, 1, 'last');
    data.state_4_idx        =   [state4_start state4_end];
    
    %% for each zone, convert into fictive trajectories
    % first, trajectories in the dark
    data.Xpos_dark          =   zeros(1,state1_end-state1_start);
    data.Ypos_dark          =   zeros(1,state1_end-state1_start);
    data.Theta_dark         =   zeros(1,state1_end-state1_start);
    
    data.Xpos_dark(1)       =   info.XYstart(1,1);
    data.Ypos_dark(1)       =   info.XYstart(1,2);
    data.flyTheta_dark(1)   =   info.XYstart(1,3);
    
    for aa = 2:length(data.Xpos_dark)
        data.flyTheta_dark(aa)      =   mod(data.flyTheta_dark(aa-1) + ((sum(data.Omega(state1_start+aa))/data.ticks_per_radian) * data.rotGain),2*pi);
        [Xfwd,Yfwd]                 =   pol2cart(data.flyTheta_dark(aa),sum(data.Vfwd(state1_start+aa)));
        [Xss,Yss]                   =   pol2cart(data.flyTheta(state1_start+aa)-(pi/2),sum(data.Vss(state1_start+aa))); 
        
        data.Xpos_dark(aa)          =   (data.Xpos(aa-1)+round(Xfwd+Xss));
        data.Ypos_dark(aa)          =   (data.Ypos(aa-1)+round(Yfwd+Yss));
    end
    
    data.flyTheta_dark              =   mod(data.flyTheta_dark+pi, 2*pi);  
    data.dTheta_dark                =   zeros(1, length(data.flyTheta_dark));
    for aa = 2:length(data.flyTheta_dark)
        
        dTheta = data.flyTheta_dark(aa)-data.flyTheta_dark(aa-1);
        
        if abs(dTheta) > pi
           if dTheta > 0
               dTheta = dTheta-(2*pi);
           else
              dTheta = dTheta+(2*pi);
           end
           
        end
        
        
        data.dTheta_dark(aa)          =  dTheta;
    
    end
    
    data.dTheta_dark_sm       =   smooth(data.dTheta_dark, 10);
    data.turnRate_dark_sm     =   data.dTheta_dark_sm/(.025);

    % second, trajectories during stripe fixation
    data.Xpos_stripe          =   zeros(1,state2_end-state2_start);
    data.Ypos_stripe          =   zeros(1,state2_end-state2_start);
    data.Theta_stripe         =   zeros(1,state2_end-state2_start);
    
    data.Xpos_stripe(1)       =   info.XYstart(1,1);
    data.Ypos_stripe(1)       =   info.XYstart(1,2);
    data.flyTheta_stripe(1)   =   info.XYstart(1,3);
    
    for aa = 2:length(data.Xpos_stripe)
        data.flyTheta_stripe(aa)      =   mod(data.flyTheta_stripe(aa-1) + ((sum(data.Omega(state2_start+aa))/data.ticks_per_radian) * data.rotGain),2*pi);
        [Xfwd,Yfwd]                 =   pol2cart(data.flyTheta_stripe(aa),sum(data.Vfwd(state2_start+aa)));
        [Xss,Yss]                   =   pol2cart(data.flyTheta(state2_start+aa)-(pi/2),sum(data.Vss(state1_start+aa))); 

        data.Xpos_stripe(aa)          =   (data.Xpos(aa-1)+round(Xfwd+Xss));
        data.Ypos_stripe(aa)          =   (data.Ypos(aa-1)+round(Yfwd+Yss));
    end    

    data.flyTheta_stripe                 =   mod(data.flyTheta_stripe+pi, 2*pi);  
    data.dTheta_stripe                  =   zeros(1, length(data.flyTheta_stripe));
    for aa = 2:length(data.flyTheta_stripe)
        
        dTheta = data.flyTheta_stripe(aa)-data.flyTheta_stripe(aa-1);
        if abs(dTheta) > pi
           if dTheta > 0
               dTheta = dTheta-(2*pi);
           else
              dTheta = dTheta+(2*pi);
           end
           
        end
        
        
        data.dTheta_stripe(aa)          =  dTheta;
    
    end
 
    data.dTheta_stripe_sm       =   smooth(data.dTheta_stripe, 10);
    data.turnRate_stripe_sm     =   data.dTheta_stripe_sm/(.025);

    
    % third, trajectories during image flash
    data.Xpos_flash          =   zeros(1,state3_end-state3_start);
    data.Ypos_flash          =   zeros(1,state3_end-state3_start);
    data.Theta_flash         =   zeros(1,state3_end-state3_start);
    
    data.Xpos_flash(1)       =   info.XYstart(1,1);
    data.Ypos_flash(1)       =   info.XYstart(1,2);
    data.flyTheta_flash(1)   =   info.XYstart(1,3);
    
    for aa = 2:length(data.Xpos_flash)
        data.flyTheta_flash(aa)      =   mod(data.flyTheta_flash(aa-1) + ((sum(data.Omega(state3_start+aa))/data.ticks_per_radian) * data.rotGain),2*pi);
        [Xfwd,Yfwd]                 =   pol2cart(data.flyTheta_flash(aa),sum(data.Vfwd(state3_start+aa)));
        [Xss,Yss]                   =   pol2cart(data.flyTheta(state3_start+aa)-(pi/2),sum(data.Vss(state1_start+aa))); 
        
        data.Xpos_flash(aa)          =   (data.Xpos(aa-1)+round(Xfwd+Xss));
        data.Ypos_flash(aa)          =   (data.Ypos(aa-1)+round(Yfwd+Yss));
    end     
    
    data.flyTheta_flash                 =   mod(data.flyTheta_flash+pi, 2*pi);  
    data.dTheta_flash                   =   zeros(1, length(data.flyTheta_flash));
    for aa = 2:length(data.flyTheta_flash)
        
        dTheta = data.flyTheta_flash(aa)-data.flyTheta_flash(aa-1);
        if abs(dTheta) > pi
           if dTheta > 0
               dTheta = dTheta-(2*pi);
           else
              dTheta = dTheta+(2*pi);
           end
           
        end
        
        
        data.dTheta_flash(aa)          =  dTheta;
    
    end

    data.dTheta_flash_sm       =   smooth(data.dTheta_flash, 10);
    data.turnRate_flash_sm     =   data.dTheta_flash_sm/(.025);

    % fourth, extract turn rates from closed loop

    data.flyTheta_CL                 =   mod(data.flyTheta(state4_start:data.count)+pi, 2*pi);     
    data.dTheta_CL                   =   zeros(1, length(data.flyTheta_CL ));
    for aa = 2:length(data.flyTheta_CL)
        
        dTheta = data.flyTheta_CL(aa)-data.flyTheta_CL(aa-1);
        if abs(dTheta) > pi
           if dTheta > 0
               dTheta = dTheta-(2*pi);
           else
              dTheta = dTheta+(2*pi);
           end
           
        end
        
        
        data.dTheta_CL(aa)          =  dTheta;
    end
    
    data.dTheta_CL_sm                  = smooth(data.dTheta_CL, 10);
    data.turnRate_CL_sm                = data.dTheta_CL_sm/(.025);
    data.speed_CL_sm                  =  data.speed_500ms_sm(state4_start:data.count);

    %% find turn rates for entire time the display is visible
    data.dTheta_vis                     = [data.dTheta_flash data.dTheta_CL(2:end)]; % skip 1 because will be = 0
    data.dTheta_vis_sm                  = smooth(data.dTheta_vis, 10);
    data.turnRate_vis_sm                = data.dTheta_vis_sm/(.025);
    
    
end

function data = assignOutcomeCode(data, info, trialNum)
%% pattern code is as follows:
%  training:
%  0 = miss
%  1 = found
%  test:
%  2 = choose left
%  3 = choose right
%  4 = no choice

if (trialNum < 21) || ( (trialNum > 24) && (trialNum < 35) )
    
    numFramesInCoolSpot = length(find( data.laserPower < (info.arenaPowerLevels(1)+0.1)) );
    data.timeInCoolZone = numFramesInCoolSpot/40;
    
    if data.timeInCoolZone < 5
        data.outcomeCode = 0;
    else
        data.outcomeCode = 1;
    end
    
else
    
    lastX = data.Xpos(data.count);
    lastY = data.Ypos(data.count);
    
    lastLaser = data.checkEnv(lastY, lastX);
    
    if lastLaser < (info.arenaPowerLevels(1)+0.1) %% if the fly made a choice, assign a side code
       
        if lastY > 900
            
            data.outcomeCode = 2; %% chose left
        else
            
            data.outcomeCode = 3; %% chose right
        end
        
    else  %% if fly scooted or did not make a choice
        
        data.outcomeCode = 4; 
        
    end
    
end


end