
uas_ShiTS_x_48A08AD(1).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-23/20142301164927_stimulusTest';
uas_ShiTS_x_48A08AD(2).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-23/20142301180244_stimulusTest';
uas_ShiTS_x_48A08AD(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-24/20142401140918_stimulusTest';
uas_ShiTS_x_48A08AD(4).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-24/20142401163323_stimulusTest';
uas_ShiTS_x_48A08AD(5).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-24/20142401173402_stimulusTest';
uas_ShiTS_x_48A08AD(6).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-25/20142501185532_stimulusTest';
uas_ShiTS_x_48A08AD(7).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-25/20142501231002_stimulusTest';
uas_ShiTS_x_48A08AD(8).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-26/20142601201707_stimulusTest';
uas_ShiTS_x_48A08AD(9).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-28/20142801152749_stimulusTest';
uas_ShiTS_x_48A08AD(10).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-28/20142801164058_stimulusTest';
uas_ShiTS_x_48A08AD(11).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-29/20142901142426_stimulusTest';
uas_ShiTS_x_48A08AD(12).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-29/20142901165417_stimulusTest';
uas_ShiTS_x_48A08AD(13).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-04/20140402134656_stimulusTest';
uas_ShiTS_x_48A08AD(14).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-05/20140502144405_stimulusTest';
uas_ShiTS_x_48A08AD(15).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-05/20140502171518_stimulusTest';
uas_ShiTS_x_48A08AD(16).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-06/20140602171731_stimulusTest';
uas_ShiTS_x_48A08AD(17).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-07/20140702145545_stimulusTest';
uas_ShiTS_x_48A08AD(18).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-08/20140802180731_stimulusTest';
uas_ShiTS_x_48A08AD(19).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-09/20140902144755_stimulusTest';
uas_ShiTS_x_48A08AD(20).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-09/20140902173357_stimulusTest';

uas_ShiTS_x_48A08AD_choicePerf_R = [];
uas_ShiTS_x_48A08AD_fracTime_R = [];
uas_ShiTS_x_48A08AD_matrix_R = [];
uas_ShiTS_x_48A08AD_prediction_R = [];


for aa = 1:length(uas_ShiTS_x_48A08AD);

    cd(uas_ShiTS_x_48A08AD(aa).path)
    load('summaryData.mat')
    
    hitsToParse     = summaryData.outcomeVec;
    fracCold        = summaryData.fracTimeCold;
    
    train_b1       = hitsToParse(1:5);
    train_b2       = hitsToParse(6:10);
    train_b3       = hitsToParse(11:15);
    train_b4       = hitsToParse(16:20);
    
    test_A         = hitsToParse(21:24);
    
    train_b5       = hitsToParse(25:29);
    train_b6       = hitsToParse(30:34);
    
    test_B         = hitsToParse(35:38);
    
    train_b1_frac  = length(find(train_b1==1))/5;
    train_b2_frac  = length(find(train_b2==1))/5;
    train_b3_frac  = length(find(train_b3==1))/5;
    train_b4_frac  = length(find(train_b4==1))/5;
    
    test_A_frac    = length(find(test_A==3))/4;
    
    train_b5_frac  = length(find(train_b5==1))/5; 
    train_b6_frac  = length(find(train_b6==1))/5; 
    
    test_B_frac    = length(find(test_B==3))/4;
    
    choiceBlockSummary = [train_b1_frac train_b2_frac train_b3_frac train_b4_frac test_A_frac train_b5_frac train_b6_frac test_B_frac];
    
    uas_ShiTS_x_48A08AD_choicePerf_R    = [uas_ShiTS_x_48A08AD_choicePerf_R; choiceBlockSummary];
    uas_ShiTS_x_48A08AD_fracTime_R      = [uas_ShiTS_x_48A08AD_fracTime_R; summaryData.fracTimeCold];
    uas_ShiTS_x_48A08AD_matrix_R        = [uas_ShiTS_x_48A08AD_matrix_R; summaryData.outcomeVec];
    uas_ShiTS_x_48A08AD_prediction_R    = [uas_ShiTS_x_48A08AD_prediction_R; [test_A_frac test_B_frac]];

end

%% experiment flies
uas_ShiTS_x_48A08AD_insertVec           = 7*ones(length(uas_ShiTS_x_48A08AD),50);
uas_ShiTS_x_48A08AD_insertVec_spread    = uas_ShiTS_x_48A08AD_insertVec;
uas_ShiTS_x_48A08AD_performance         = nan(length(uas_ShiTS_x_48A08AD), 4);
uas_ShiTS_x_48A08AD_fracCool            = nan(length(uas_ShiTS_x_48A08AD), 28);

for aa = 1:length(uas_ShiTS_x_48A08AD)
    
    cd(uas_ShiTS_x_48A08AD(aa).path)

    load('summaryData.mat')
    

    uas_ShiTS_x_48A08AD_insertVec(aa,1:20)     = summaryData.outcomeVec(1:20);
    uas_ShiTS_x_48A08AD_insertVec(aa,22:25)    = summaryData.outcomeVec(21:24);
    uas_ShiTS_x_48A08AD_insertVec(aa,27:36)    = summaryData.outcomeVec(25:34);
    uas_ShiTS_x_48A08AD_insertVec(aa,38:41)    = summaryData.outcomeVec(35:38);
    

end

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .9 .9])

imagesc(uas_ShiTS_x_48A08AD_insertVec)
caxis([0 6])
axis equal off
%cMap = [255 255 255; ...
%        150 150 150; ...
%        150 150 150; ...
%        1 183 255; ...dark orange
%        255 86  1; ...dark blue
%        111 255 243;...light blue
%        255 145 111]... light orange

cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...dark blue
        1 183 255; ...dark orange
        255 145 111;... light orange
        111 255 243];...light blue
        
    
    hold on
    
z1 = scatter(44,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(45,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)

z1 = scatter(44,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(45,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)
text(45.5, 2.5, 'found target / chose right')
text(45.5, 3.5, 'missed target / chose left')

z1 = scatter(45,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(45.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(21.5,0, 'test 1')
text(26.5, 0, 'train 11-20')
text(37.5, 0, 'test 2')

for aa = 1:length(uas_ShiTS_x_48A08AD)
    text(-1, aa, ['fly ' num2str(aa)])
end

for aa = 1:length(uas_ShiTS_x_48A08AD)
   
    yval = aa+.5

    plot([0 41.5], [yval yval], 'Color', 'k')
end
text(-2, 13, 'right lane cool', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02122014/')
export_fig('right_go')


