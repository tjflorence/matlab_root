DL_wt(1).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-09/20130912102155_stimulusTest';
DL_wt(2).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-09/20130912121352_stimulusTest';
DL_wt(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-09/20130912151022_stimulusTest';
DL_wt(4).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412125541_stimulusTest';
DL_wt(5).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412143709_stimulusTest';
DL_wt(6).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412155151_stimulusTest';
DL_wt(7).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412173227_stimulusTest';
DL_wt(8).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-15/20131512140727_stimulusTest';
DL_wt(9).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-15/20131512162849_stimulusTest';

uas_ShiTS_x_48A08AD(1).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-10/20131012091753_stimulusTest';
uas_ShiTS_x_48A08AD(2).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-10/20131012102944_stimulusTest';
uas_ShiTS_x_48A08AD(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-10/20131012114557_stimulusTest';
uas_ShiTS_x_48A08AD(4).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-11/20131112141732_stimulusTest';
uas_ShiTS_x_48A08AD(5).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-11/20131112153046_stimulusTest';
uas_ShiTS_x_48A08AD(6).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-13/20131312110506_stimulusTest';
uas_ShiTS_x_48A08AD(7).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-13/20131312132836_stimulusTest';
uas_ShiTS_x_48A08AD(8).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-13/20131312143434_stimulusTest';

uasKir_DL_x_48A08AD(1).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-10/20131012193233_stimulusTest';
uasKir_DL_x_48A08AD(2).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-11/20131112200623_stimulusTest';
uasKir_DL_x_48A08AD(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-12/20131212175434_stimulusTest';
uasKir_DL_x_48A08AD(4).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-12/20131212193429_stimulusTest';
uasKir_DL_x_48A08AD(5).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-12/20131212211056_stimulusTest';
uasKir_DL_x_48A08AD(6).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412193228_stimulusTest';
uasKir_DL_x_48A08AD(7).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412204414_stimulusTest';
uasKir_DL_x_48A08AD(8).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412215812_stimulusTest';
uasKir_DL_x_48A08AD(9).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-12-14/20131412230717_stimulusTest';



DL_darkSpeed    = [];
DL_laneSpeed    = [];
DL_stripeSpeed  = [];
DL_integratedDarkTurn = [];
DL_straight = [];
for aa = 1:length(DL_wt)
   
    cd(DL_wt(aa).path)
    infoFile = dir('*info*');
    load(infoFile.name)
    
    cd('processed_files')
    
    insertVec_dark    = nan(1,38);
    insertVec_lane    = nan(1,38);
    insertVec_stripe  = nan(1,38);
    insertVec_darkInt = nan(1,38);
    insertStraight    = nan(1,38);
    
    trainingTrials  = dir('*trial*');
    testTrials      = dir('*TEST*');
    
    for bb = 1:20
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb)      = data.meanSpeed_z2;
        insertStraight(bb)      = data.straightness;
    end
    
    for bb = 1:4
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+20)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+20)     = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+20)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+20)     = data.meanSpeed_z2;
        insertStraight(bb+20)      = data.straightness;

    end
    
    for bb = 21:30
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+4)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+4)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+4)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+4)      = data.meanSpeed_z2;
        insertStraight(bb+4)      = data.straightness;

        
    end
 
    for bb = 5:8
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb+30)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+30)         = sum(abs(data.turnRate_dark_sm));
        insertVec_lane(bb+30)         = data.meanSpeed_z2;
        insertVec_stripe(bb+30)       = sum(abs(data.turnRate_stripe_sm));
        insertStraight(bb+30)      = data.straightness;

    
    end
    
    DL_darkSpeed = [DL_darkSpeed; insertVec_dark];
    DL_laneSpeed = [DL_laneSpeed; insertVec_lane];
    DL_stripeSpeed = [DL_stripeSpeed; insertVec_stripe];
    DL_integratedDarkTurn = [DL_integratedDarkTurn; insertVec_darkInt];
    DL_straight = [DL_straight; insertStraight];
    
end

shiTS_48A08AD_darkSpeed    = [];
shiTS_48A08AD_laneSpeed    = [];
shiTS_48A08AD_stripeSpeed  = [];
shiTS_48A08AD_integratedDarkTurn = [];
shiTS_48A08AD_straight = [];

for aa = 1:length(uas_ShiTS_x_48A08AD)
   
    cd(uas_ShiTS_x_48A08AD(aa).path)
    infoFile = dir('*info*');
    load(infoFile.name)
    
    cd('processed_files')
    
    insertVec_dark    = nan(1,38);
    insertVec_lane    = nan(1,38);
    insertVec_stripe  = nan(1,38);
    insertVec_darkInt = nan(1,38);
    insertStraight = nan(1,38);
    
    trainingTrials  = dir('*trial*');
    testTrials      = dir('*TEST*');
    
    for bb = 1:20
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb)      = data.meanSpeed_z2;
        insertStraight(bb)      = data.straightness;

    end
    
    for bb = 1:4
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+20)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+20)     = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+20)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+20)     = data.meanSpeed_z2;
        insertStraight(bb+20)      = data.straightness;

    end
    
    for bb = 21:30
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+4)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+4)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+4)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+4)      = data.meanSpeed_z2;
        insertStraight(bb+4)      = data.straightness;

        
    end
 
    for bb = 5:8
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb+30)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+30)         = sum(abs(data.turnRate_dark_sm));
        insertVec_lane(bb+30)         = data.meanSpeed_z2;
        insertVec_stripe(bb+30)       = sum(abs(data.turnRate_stripe_sm));
        insertStraight(bb+30)         = data.straightness;

        
    end
    
    shiTS_48A08AD_darkSpeed = [shiTS_48A08AD_darkSpeed; insertVec_dark];
    shiTS_48A08AD_laneSpeed = [shiTS_48A08AD_laneSpeed; insertVec_lane];
    shiTS_48A08AD_stripeSpeed = [shiTS_48A08AD_stripeSpeed; insertVec_stripe];
    shiTS_48A08AD_integratedDarkTurn = [shiTS_48A08AD_integratedDarkTurn; insertVec_darkInt];
    shiTS_48A08AD_straight = [shiTS_48A08AD_straight;insertStraight];
    
end

uasKir_48A08AD_darkSpeed    = [];
uasKir_48A08AD_laneSpeed    = [];
uasKir_48A08AD_stripeSpeed  = [];
uasKir_48A08AD_integratedDarkTurn = [];
uasKir_48A08AD_straight = [];
for aa = 1:length(uasKir_DL_x_48A08AD)
   
    cd(uasKir_DL_x_48A08AD(aa).path)
    infoFile = dir('*info*');
    load(infoFile.name)
    
    cd('processed_files')
    
    insertVec_dark    = nan(1,38);
    insertVec_lane    = nan(1,38);
    insertVec_stripe  = nan(1,38);
    insertVec_darkInt = nan(1,38);
    insertStraight = nan(1,38);
    
    trainingTrials  = dir('*trial*');
    testTrials      = dir('*TEST*');
    
    for bb = 1:20
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb)      = data.meanSpeed_z2;
            insertStraight(bb)      = data.straightness;

    end
    
    for bb = 1:4
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+20)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+20)     = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+20)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+20)     = data.meanSpeed_z2;
        insertStraight(bb+20)      = data.straightness;

    end
    
    for bb = 21:30
        load(trainingTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        insertVec_darkInt(bb+4)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+4)      = sum(abs(data.turnRate_dark_sm));
        insertVec_stripe(bb+4)    = sum(abs(data.turnRate_stripe_sm));
        insertVec_lane(bb+4)      = data.meanSpeed_z2;
        insertStraight(bb+4)      = data.straightness;
 
    end
 
    for bb = 5:8
        load(testTrials(bb).name)
        
        endDark = data.state_1_2_transition;
        
        insertVec_darkInt(bb+30)      = sum((data.turnRate_dark_sm));
        insertVec_dark(bb+30)         = sum(abs(data.turnRate_dark_sm));
        insertVec_lane(bb+30)         = data.meanSpeed_z2;
        insertVec_stripe(bb+30)       = sum(abs(data.turnRate_stripe_sm));           insertStraight(bb)      = data.straightness;
        insertStraight(bb+30)      = data.straightness;

        
    end
    
    uasKir_48A08AD_darkSpeed = [uasKir_48A08AD_darkSpeed; insertVec_dark];
    uasKir_48A08AD_laneSpeed = [uasKir_48A08AD_laneSpeed; insertVec_lane];
    uasKir_48A08AD_stripeSpeed = [uasKir_48A08AD_stripeSpeed; insertVec_stripe];
    uasKir_48A08AD_integratedDarkTurn = [uasKir_48A08AD_integratedDarkTurn; insertVec_darkInt];
    uasKir_48A08AD_straight = [uasKir_48A08AD_straight; insertStraight];
end

uasKir_48A08AD_laneSpeed;
shiTS_48A08AD_laneSpeed;
DL_laneSpeed;

errorbar(1:20, nanmean(DL_laneSpeed(1:20)), nanstd(DL_laneSpeed(1:20))/size(DL_laneSpeed,1), 'k')
errorbar(25:34, nanmean(DL_laneSpeed(25:34)), nanstd(DL_laneSpeed(25:34))/size(DL_laneSpeed,1), 'k')