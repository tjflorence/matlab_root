%% experimental flies 
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

%% control flies
cfly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707134918_stimulusTest/';
cfly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707142558_stimulusTest/';

cfly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707150658_stimulusTest/';
cfly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707152637_stimulusTest/';

cfly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707154818_stimulusTest/';
cfly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707160916_stimulusTest/';

cfly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707200428_stimulusTest/';
cfly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707202503_stimulusTest/';

cfly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707204515_stimulusTest/';
cfly(5).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707210559_stimulusTest/';

cfly(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707215703_stimulusTest/';
cfly(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-27/20132707222039_stimulusTest/';

cfly(7).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-28/20132807113927_stimulusTest/';
cfly(7).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-28/20132807120432_stimulusTest/';

for aa = 1:11
    
    addVarStats_tetheredMaze(fly(aa).tr1)
    try
            addVarStats_tetheredMaze(fly(aa).tr2)
    catch
    end
    
end

for aa = 1:7
    
    addVarStats_tetheredMaze(cfly(aa).tr1)
 
    addVarStats_tetheredMaze(cfly(aa).tr2)
   
    
end

%% collect data for side preference
exp_sidePref    = nan(11,28);
c_sidePref      = nan(7,28);

for aa = 1:11
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(fly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.sidePrefIdx;
    end
 
    try
        cd(fly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.sidePrefIdx;
        end
    catch
    end
    
    exp_sidePref(aa, 1:28) = [tr1_vec tr2_vec];
    
end

for aa = 1:7
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(cfly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.sidePrefIdx;
    end
 
    try
        cd(cfly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.sidePrefIdx;
        end
    catch
    end
    
    c_sidePref(aa, 1:28) = [tr1_vec tr2_vec];
    
end

exp_sidePref_mean = nanmean(exp_sidePref);
c_sidePref_mean = nanmean(c_sidePref);

exp_sidePref_sem = nanstd(exp_sidePref)/sqrt(11);
c_sidePref_sem = nanstd(c_sidePref)/sqrt(7);

%% collect data for side preference
exp_sidePref_pc    = nan(11,28);
c_sidePref_pc      = nan(7,28);

for aa = 1:11
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(fly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.sidePrefIdx_postChoice;
    end
 
    try
        cd(fly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.sidePrefIdx_postChoice;
        end
    catch
    end
    
    exp_sidePref_pc(aa, 1:28) = [tr1_vec tr2_vec];
    
end

for aa = 1:7
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(cfly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.sidePrefIdx_postChoice;
    end
 
    try
        cd(cfly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.sidePrefIdx_postChoice;
        end
    catch
    end
    
    c_sidePref_pc(aa, 1:28) = [tr1_vec tr2_vec];
    
end

exp_sidePref_pc_mean = nanmean(exp_sidePref_pc);
c_sidePref_pc_mean = nanmean(c_sidePref_pc);

exp_sidePref_pc_sem = nanstd(exp_sidePref_pc)/sqrt(11);
c_sidePref_pc_sem = nanstd(c_sidePref_pc)/sqrt(7);


%% collect data for fraction in zone
exp_fracInZone    = nan(11,28);
c_fracInZone      = nan(7,28);

for aa = 1:11
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(fly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.fracTimeInLane;
    end
 
    try
        cd(fly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.fracTimeInLane;
        end
    catch
    end
    
    exp_fracInZone(aa, 1:28) = [tr1_vec tr2_vec];
    
end

for aa = 1:7
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(cfly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.fracTimeInLane;
    end
 
    try
        cd(cfly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.fracTimeInLane;
        end
    catch
    end
    
    c_fracInZone(aa, 1:28) = [tr1_vec tr2_vec];
    
end

exp_fracInZone_mean = nanmean(exp_fracInZone);
c_fracInZone_mean = nanmean(c_fracInZone);

exp_fracInZone_sem = nanstd(exp_fracInZone)/sqrt(11);
c_fracInZone_sem = nanstd(c_fracInZone)/sqrt(7);


%% collect data for time to cool spot
exp_pathToCoolSpot    = nan(11,28);
c_pathToCoolSpot      = nan(7,28);

for aa = 1:11
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(fly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.pathToCoolSpot;
    end
 
    try
        cd(fly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.pathToCoolSpot;
        end
    catch
    end
    
    exp_pathToCoolSpot(aa, 1:28) = [tr1_vec tr2_vec];
    
end

for aa = 1:7
    tr1_vec = nan(1,14);
    tr2_vec = nan(1,14);
    
    cd(cfly(aa).tr1)
    expFiles = dir('env*');
    for bb = 1:14
        load(expFiles(bb).name)
        tr1_vec(bb) = data.pathToCoolSpot;
    end
 
    try
        cd(cfly(aa).tr2)
        expFiles = dir('env*');
        for bb = 1:14
            load(expFiles(bb).name)
            tr2_vec(bb) = data.pathToCoolSpot;
        end
    catch
    end
    
    c_pathToCoolSpot(aa, 1:28) = [tr1_vec tr2_vec];
    
end

exp_pathToCoolSpot_mean = nanmean(exp_pathToCoolSpot);
c_pathToCoolSpot_mean = nanmean(c_pathToCoolSpot);

exp_pathToCoolSpot_sem = nanstd(exp_pathToCoolSpot)/sqrt(11);
c_pathToCoolSpot_sem = nanstd(c_pathToCoolSpot)/sqrt(7);


%% plot side preference
f1 = figure('color','w', 'units', 'normalized', 'Position', [.1 .1 .4 .2]);

plot([-50 50], [0 0], 'Color', 'k')

errorbar(.9:1:27.9, -exp_sidePref_mean, exp_sidePref_sem, 'Color','r', 'LineWidth', 3)
hold on 
z1 = scatter(.9:1:27.9,-exp_sidePref_mean, 75, 'r')
set(z1, 'MarkerFaceColor','r', 'MarkerEdgeColor', 'k')

errorbar(1.1:1:28.1, -c_sidePref_mean, c_sidePref_sem, 'Color','k', 'LineWidth', 3)
hold on 
z1 = scatter(1.1:1:28.1,-c_sidePref_mean, 75, 'k')
set(z1, 'MarkerFaceColor','k', 'MarkerEdgeColor', 'k')

xlim([.5 28.5])
ylim([-1 1])

%% plot side preference
f1 = figure('color','w', 'units', 'normalized', 'Position', [.1 .1 .4 .2]);

plot([-50 50], [0 0], 'Color', 'k')

errorbar(.9:1:27.9, -exp_sidePref_mean, exp_sidePref_sem, 'Color','r', 'LineWidth', 3)
hold on 
z1 = scatter(.9:1:27.9, -exp_sidePref_mean, 75, 'r')
set(z1, 'MarkerFaceColor','r', 'MarkerEdgeColor', 'k')

errorbar(1.1:1:28.1, -c_sidePref_mean, c_sidePref_sem, 'Color','k', 'LineWidth', 3)
hold on 
z1 = scatter(1.1:1:28.1, -c_sidePref_mean, 75, 'k')
set(z1, 'MarkerFaceColor','k', 'MarkerEdgeColor', 'k')

set(gca, 'XTick', [5,10,11,12,13,14,20,24,25, 26, 27, 28], 'XTickLabel', {'5', '10', 't1', 't2', 't3', 't4', '15', '20', 't1', 't2', 't3', 't4'})

plot([-50 50], [0 0], 'Color','k')
plot([10.5 10.5], [-2 2], 'k')
plot([14.5 14.5], [-2 2], 'k')
plot([24.5 24.5], [-2 2], 'k')
plot([28.5 28.5], [-2 2], 'k')
xlim([.5 28.5])
ylim([-1 1])

box off

title('side preference')
ylabel('side preference (right positive)')
xlabel('trial')

text(1.5, .95, 'exp flies: go right (10.5 flies)', 'Color', 'r')
text(1.5, .85, 'control flies: random (7 flies)')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07302013/')
export_fig('side_preference')

%% plot time to cool spot 
f1 = figure('color','w', 'units', 'normalized', 'Position', [.1 .1 .4 .2]);

errorbar(.9:1:27.9, exp_pathToCoolSpot_mean, exp_pathToCoolSpot_sem, 'Color','r', 'LineWidth', 3)
hold on 
z1 = scatter(.9:1:27.9,exp_pathToCoolSpot_mean, 75, 'r')
set(z1, 'MarkerFaceColor','r', 'MarkerEdgeColor', 'k')

errorbar(1.1:1:28.1, c_pathToCoolSpot_mean, c_pathToCoolSpot_sem, 'Color','k', 'LineWidth', 3)
hold on 
z1 = scatter(1.1:1:28.1,c_pathToCoolSpot_mean, 75, 'k')
set(z1, 'MarkerFaceColor','k', 'MarkerEdgeColor', 'k')

plot([-50 50], [0 0], 'Color','k')
set(gca, 'XTick', [5,10,11,12,13,14,20,24,25, 26, 27, 28], 'XTickLabel', {'5', '10', 't1', 't2', 't3', 't4', '15', '20', 't1', 't2', 't3', 't4'})

plot([10.5 10.5], [-50 10000], 'k')
plot([14.5 14.5], [-50 10000], 'k')
plot([24.5 24.5], [-50 10000], 'k')
plot([28.5 28.5], [-50 10000], 'k')

xlim([.5 28.5])
ylim([900 5500])

box off

title('path length to cool spot')
ylabel('path length (mm)')
xlabel('trial')

text(2, 5300, 'exp flies: go right (10.5 flies)', 'Color', 'r')
text(2, 5100, 'control flies: random (7 flies)')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07302013/')
export_fig('path_to_cool_spot')

%% plot frac in lanes 
f1 = figure('color','w', 'units', 'normalized', 'Position', [.1 .1 .4 .2]);

errorbar(.9:1:27.9, exp_fracInZone_mean, exp_fracInZone_sem, 'Color','r', 'LineWidth', 3)
hold on 
z1 = scatter(.9:1:27.9,exp_fracInZone_mean, 75, 'r')
set(z1, 'MarkerFaceColor','r', 'MarkerEdgeColor', 'k')

errorbar(1.1:1:28.1, c_fracInZone_mean, c_fracInZone_sem, 'Color','k', 'LineWidth', 3)
hold on 
z1 = scatter(1.1:1:28.1,c_fracInZone_mean, 75, 'k')
set(z1, 'MarkerFaceColor','k', 'MarkerEdgeColor', 'k')

xlim([.5 28.5])
ylim([.4 1])

box off

title('fraction in lane')
ylabel('fraction of trajectory in lane')
xlabel('trial')
plot([10.5 10.5], [-2 2], 'k')

set(gca, 'XTick', [5,10,11,12,13,14,20,24,25, 26, 27, 28], 'XTickLabel', {'5', '10', 't1', 't2', 't3', 't4', '15', '20', 't1', 't2', 't3', 't4'})

text(1.5, .5, 'exp flies: go right (10.5 flies)', 'Color', 'r')
text(1.5, .45, 'control flies: random (7 flies)')

plot([10.5 10.5], [-2 2], 'k')
plot([14.5 14.5], [-2 2], 'k')
plot([24.5 24.5], [-2 2], 'k')
plot([28.5 28.5], [-2 2], 'k')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07302013/')
export_fig('fraction_in_lane')

%% plot side preference post choice
f1 = figure('color','w', 'units', 'normalized', 'Position', [.1 .1 .4 .2]);

plot([-50 50], [0 0], 'Color', 'k')

errorbar(.9:1:27.9, -exp_sidePref_pc_mean, exp_sidePref_pc_sem, 'Color','r', 'LineWidth', 3)
hold on 
z1 = scatter(.9:1:27.9, -exp_sidePref_pc_mean, 75, 'r')
set(z1, 'MarkerFaceColor','r', 'MarkerEdgeColor', 'k')

errorbar(1.1:1:28.1, -c_sidePref_pc_mean, c_sidePref_pc_sem, 'Color','k', 'LineWidth', 3)
hold on 
z1 = scatter(1.1:1:28.1, -c_sidePref_pc_mean, 75, 'k')
set(z1, 'MarkerFaceColor','k', 'MarkerEdgeColor', 'k')

set(gca, 'XTick', [5,10,11,12,13,14,20,24,25, 26, 27, 28], 'XTickLabel', {'5', '10', 't1', 't2', 't3', 't4', '15', '20', 't1', 't2', 't3', 't4'})

plot([-50 50], [0 0], 'Color','k')
plot([10.5 10.5], [-2 2], 'k')
plot([14.5 14.5], [-2 2], 'k')
plot([24.5 24.5], [-2 2], 'k')
plot([28.5 28.5], [-2 2], 'k')
xlim([.5 28.5])
ylim([-1 1])

box off

title('side preference: post choice')
ylabel('side preference index (right positive)')
xlabel('trial')

text(1.5, .95, 'exp flies: go right (10.5 flies)', 'Color', 'r')
text(1.5, .85, 'control flies: random (7 flies)')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07302013/')
export_fig('side_preference_post_choice')