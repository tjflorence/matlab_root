
uas_ShiTS_x_48A08AD(1).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-22/20142201221002_stimulusTest';
uas_ShiTS_x_48A08AD(2).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-23/20142301122831_stimulusTest';
uas_ShiTS_x_48A08AD(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-23/20142301150531_stimulusTest';
uas_ShiTS_x_48A08AD(3).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-24/20142401114156_stimulusTest';
uas_ShiTS_x_48A08AD(4).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-24/20142401130151_stimulusTest';
uas_ShiTS_x_48A08AD(5).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-30/20143001134351_stimulusTest';
uas_ShiTS_x_48A08AD(6).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-01-30/20143001145327_stimulusTest';
uas_ShiTS_x_48A08AD(7).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-10/20141002175745_stimulusTest';
uas_ShiTS_x_48A08AD(8).path = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2014-02-10/20141002190813_stimulusTest';



figname = 'stripe_fix_l'
pathStruct = uas_ShiTS_x_48A08AD;

for aa = 1:30
stripeFixData(aa).norm_fix_mat = [];
end

for aa = 1:length(pathStruct)
    cd(pathStruct(aa).path)
   
    cd('processed_files')
    trainingTrials = dir('*env5*');
    
    for bb = 1:length(trainingTrials)
        load(trainingTrials(bb).name)
        
        data = normalizeStripeFix(data);
        %save(trainingTrials(bb).name);
        
        if aa == 1
            stripeFixData(bb).norm_fix_mat = data.normalizedFix;
        else
            stripeFixData(bb).norm_fix_mat = [stripeFixData(bb).norm_fix_mat; data.normalizedFix];
        end
        
 
    end
    
end

f1 = figure('units', 'normalized', 'Position', [.1 .1 .4 .6], 'Color', 'w');


for aa = 1:30
   
    stripeFixData(aa).mean_fix = circ_mean(stripeFixData(aa).norm_fix_mat);
    hold on
    
    plot(stripeFixData(aa).mean_fix, 'color', [aa/30 0 1-(aa/30)], 'LineWidth', 2)
end

xlabel('norm. time stripe fix (~ 5sec)')
ylabel('theta (-pi/2:pi/2)')
ylim([-.384 .384])

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02122014/')
export_fig(figname)