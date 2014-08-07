f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .5 .3])

s1 = subplot(1,2,1)
load('/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-25/20132507151133_stimulusTest/env5_trial05_rep05.mat')

imagesc(data.tempEnv)
set(gca, 'YDir', 'normal')
colormap(gray)
axis equal off
box off
caxis([-4.7 -2.3])

freezeColors

title('previous maze config')

s2 = subplot(1,2,2)
load('/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-03/20130309205951_stimulusTest/env5_trial05_rep05.mat')

imagesc(data.tempEnv)
caxis([-4.4 -2.5])
colormap(gray)
set(gca, 'YDir', 'normal')
axis equal off
box off
freezeColors

title('current maze config')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/09052013')

export_fig('old_vs_new_maze', '-png')