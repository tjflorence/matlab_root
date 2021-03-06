%% experimental flies -- before stripe fix 
fly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507220956_stimulusTest';
fly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507223423_stimulusTest';

fly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507211616_stimulusTest';
fly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507213431_stimulusTest';

fly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507173629_stimulusTest';
fly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507175949_stimulusTest';

fly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707171517_stimulusTest';
fly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707175559_stimulusTest';

fly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707150508_stimulusTest';
fly(5).tr2 = 'k';

fly(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-19/20131907162346_stimulusTest/';
fly(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-19/20131907164713_stimulusTest/';

fly(7).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207123723_stimulusTest/';
fly(7).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207125902_stimulusTest/';

fly(8).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207144008_stimulusTest/';
fly(8).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207150130_stimulusTest/';

fly(9).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307124335_stimulusTest/';
fly(9).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307130435_stimulusTest/';

fly(10).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307142231_stimulusTest/';
fly(10).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307144136_stimulusTest/';

fly(11).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-25/20132507151133_stimulusTest/';
fly(11).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-25/20132507153314_stimulusTest/';

%% experimental flies -- after stripe fixation trigger

nfly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209173123_stimulusTest/';
nfly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209175118_stimulusTest/';

nfly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209191116_stimulusTest/';
nfly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209193229_stimulusTest/';

nfly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209200253_stimulusTest/';
nfly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209202137_stimulusTest/';

nfly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309110921_stimulusTest/';
nfly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309113258_stimulusTest/';

nfly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309132432_stimulusTest/';
nfly(5).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309134546_stimulusTest/';

nfly(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309155809_stimulusTest/';
nfly(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309161956_stimulusTest/';

nfly(7).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309164330_stimulusTest/';
nfly(7).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309171027_stimulusTest/';

for aa = 1:11
    
        addVarStats_tetheredMaze(fly(aa).tr1)
        try
            addVarStats_tetheredMaze(fly(aa).tr2)
        catch
            
        end
end

for aa = 1:7
    
        addVarStats_tetheredMaze_prePhases(nfly(aa).tr1)
        addVarStats_tetheredMaze_prePhases(nfly(aa).tr2)

end


%% grab frames for old flies

for aa = 1:28
    oflies(aa).turn_rate_5 = nan(11,100);
end

for aa = 1:11

    cd(fly(aa).tr1)
    dataFiles = dir('env*');
    
    for bb = 1:14
        load(dataFiles(bb).name)
        oflies(bb).turn_rate_5(aa,:) = data.turnRate_CL_sm(1:100);
    end
    
    
    try
        cd(fly(aa).tr2)
        dataFiles = dir('env*');
        for bb = 15:28
            load(dataFiles(bb-14).name)
            oflies(bb).turn_rate_5(aa,:) = data.turnRate_CL_sm(1:100);
        end
    catch
    end

end

for aa = 1:28
    oflies(aa).inst_std = nanstd(oflies(aa).turn_rate_5);
end




%% grab frames for new flies

for aa = 1:28
    nflies(aa).turn_rate_5 = nan(7,100);
end

for aa = 1:7

    cd(nfly(aa).tr1)
    dataFiles = dir('env*');
    
    for bb = 1:14
        load(dataFiles(bb).name)
        try
        nflies(bb).turn_rate_5(aa,:) = data.turnRate_vis_sm(1:100);
        catch
        nflies(bb).turn_rate_5(aa,1:length(data.turnRate_vis_sm)) = data.turnRate_vis_sm(1:end);
        end
    end
    
    
    cd(nfly(aa).tr2)
    dataFiles = dir('env*');
    
    for bb = 15:28
        load(dataFiles(bb-14).name)
        try
        nflies(bb).turn_rate_5(aa,:) = data.turnRate_vis_sm(1:100);
        catch
        nflies(bb).turn_rate_5(aa,1:length(data.turnRate_vis_sm)) = data.turnRate_vis_sm(1:end);
        end
    end
 

end

for aa = 1:28
    nflies(aa).inst_std = nanstd(nflies(aa).turn_rate_5);
end



f1 = figure('Color', 'w', 'Units', 'normalized', 'Position', [.05 .05 .9 .9]);
for aa = 1:28
    
    plot([-500 500], [0 0], 'k')
    hold on
    plot([0 0], [-1000 1000], 'k', 'LineWidth', 2)
    plot([-1000 1000], [-pi -pi], 'k', 'LineWidth', 2)    
    

    s1 = subplot(4,7,aa)
    h1 = ciplot(nanmean(oflies(aa).turn_rate_5)-oflies(aa).inst_std, nanmean(oflies(aa).turn_rate_5)+oflies(aa).inst_std, 1:length(nanmean(oflies(aa).turn_rate_5)+oflies(aa).inst_std), [86 60 255]./255)
    set(h1, 'FaceAlpha', .5)
    hold on
    plot(nanmean(oflies(aa).turn_rate_5), 'Color',[86 60 255]./255,  'LineWidth', 1.5)
 
    
    h1 = ciplot(nanmean(nflies(aa).turn_rate_5)-nflies(aa).inst_std, nanmean(nflies(aa).turn_rate_5)+nflies(aa).inst_std, 1:length(nanmean(nflies(aa).turn_rate_5)+nflies(aa).inst_std), [255 171 60]./255)
    set(h1, 'FaceAlpha', .5)
    hold on
    plot(nanmean(nflies(aa).turn_rate_5), 'Color', [255 171 60]./255, 'LineWidth', 2)   
    
    set(gca, 'XTick', [0 20 40 60 80 100], 'XTickLabel', {'0', '1', '2', '3', '4', '5'})
    
    box off
    
    xlim([0 100])
    ylim([-pi pi])
    
    if aa == 1
        
     text(-10, 6, 'stripe fix trigger, n = 7', 'FontSize', 20, 'Color', [255 171 60]./255, 'FontWeight', 'Bold' )
     text(-10, 5, 'no stripe fix trigger, n = 11', 'FontSize', 20, 'Color',[86 60 255]./255,'FontWeight', 'Bold' )
        
    end
    
    ylabel('turn rate (rad/sec)')
    xlabel('time (sec)')
    
    if aa == 11 || aa == 12 || aa == 13 || aa == 14
        titleText = 'test ';
        trialNum = num2str(aa-10);
    elseif aa == 25 || aa == 26 || aa == 27 || aa == 28
        titleText = 'test ';
        trialNum = num2str(aa-20);
    else
        titleText = 'train '
        trialNum = num2str(aa);
    end
    
    title([titleText trialNum],  'FontSize', 20, 'FontWeight', 'Bold')
    
    drawnow
    
    plot([-500 500], [0 0], 'k')
    hold on
    plot([0 0], [-1000 1000], 'k', 'LineWidth', 2)
    plot([-1000 1000], [-pi -pi], 'k', 'LineWidth', 2)   

    
end

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/09152013/')
export_fig('early_turn_analysis', '-png')
