%% 20hz flies
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


%% 40hz flies 
fly(1).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410130504_stimulusTest';
fly(1).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410134944_stimulusTest';

fly(2).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410143753_stimulusTest';
fly(2).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410150813_stimulusTest';

fly(3).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410161247_stimulusTest/';
fly(3).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410165257_stimulusTest/';

fly(4).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510101225_stimulusTest/';
fly(4).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510110517_stimulusTest/';

fly(5).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510145208_stimulusTest/';
fly(5).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510153114_stimulusTest/';

fly(6).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610204018_stimulusTest/';
fly(6).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610212518_stimulusTest/';

fly(7).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610225626_stimulusTest/';
fly(7).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610233853_stimulusTest/';


fracTimeOutsideLane_20hz = nan(7,28);
fracTimeOutsideLane_40hz = nan(7,28);

for aa = 1:7

    cd(nfly(aa).tr1)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        fracTimeOutsideLane_20hz(aa,bb) = data.fracTimeInLane;
    end
    
    cd(nfly(aa).tr2)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        fracTimeOutsideLane_20hz(aa,bb+14) = data.fracTimeInLane;
    end        
    

end

for aa = 1:7

    cd(fly(aa).tr1)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        fracTimeOutsideLane_40hz(aa,bb) = data.fracTimeInLane;
    end
    
    cd(fly(aa).tr2)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        fracTimeOutsideLane_40hz(aa,bb+14) = data.fracTimeInLane;
    end        
    

end

mean_20hz = nanmean(fracTimeOutsideLane_20hz);
mean_40hz = nanmean(fracTimeOutsideLane_40hz);

f1 = figure('Color','w', 'Units', 'normalized', 'position', [.1 .1 .4 .2])
b1 = fill([10.5 14.5 14.5  10.5], [0 0 1 1 ], [.5 .5 .5])
set(b1, 'FaceAlpha', .3)

hold on

b2 = fill([24.5 28.5 28.5  24.5], [0 0 1 1 ], [.5 .5 .5])
set(b2, 'FaceAlpha', .3)


hold on

for aa = 1:7
    for bb = 1:28
        
        z1 = scatter(bb+(.01*randn(1)), fracTimeOutsideLane_20hz(aa,bb), 50);
        set(z1, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [.5 .5 .5])
        hold on
        
    end
end

errorbar(.9:1:27.9, mean_20hz,nanstd(fracTimeOutsideLane_20hz)/sqrt(7) ,'Color', 'k', 'LineWidth', 3)

for aa = 1:7
    for bb = 1:28
        
        z1 = scatter(bb+(.01*randn(1)+.1), fracTimeOutsideLane_40hz(aa,bb), 50);
        set(z1, 'MarkerEdgeColor', [0 0 0], 'MarkerFaceColor', [1 0 0])
        hold on
        
    end
end

errorbar(1.1:28.1, mean_40hz,nanstd(fracTimeOutsideLane_40hz)/sqrt(7), 'Color', 'r', 'LineWidth', 3)

plot([-20 40], [.5 .5], 'Color', 'k', 'LineWidth', 5)
plot([.5 .5], [-500 500], 'Color', 'k', 'LineWidth', 5)


box off

ylim([.5 1.01])
xlim([.5 28.5])


title('fraction of time inside lane')
ylabel('frac inside lane (0-1)')
xlabel('trial no.')

text(25, .58, '20hz simulation', 'FontWeight', 'bold', 'Color', 'k')
text(25, .6, '40hz simulation', 'FontWeight', 'bold', 'Color', 'r')


cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/10232013/')
export_fig('fracInLane_20hz_v_40hz')