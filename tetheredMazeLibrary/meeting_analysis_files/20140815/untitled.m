
temp_fig_1 = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140815/thermal_data/2014-08-06/20140608214018_thermImgData/preTrial_05.mat';
traj_fig_1 = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140815/y_Experiment/2014-08-06/20140608213709_stimulusTest/env6_TEST00_1.mat';

temp_fig_2 = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140815/thermal_data/2014-08-06/20140608214018_thermImgData/preTrial_07.mat';
traj_fig_2 = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140815/y_Experiment/2014-08-06/20140608213709_stimulusTest/env6_TEST00_3.mat';

load(temp_fig_1)
load(traj_fig_1)
f1 = figure('Color', 'w', 'units', 'normalized','Position', [.01 .01 .6 .6]);
for aa = 6:tempData.count-5
    tempData.measuredTemp(aa) = mean(tempData.measuredTemp(aa-5:aa+5));
end

timeStamp = data.timeStamp(data.count)-data.timeStamp(1);
xvals = linspace(1,timeStamp, tempData.count);

hold on
plot(xvals, tempData.measuredTemp(1:tempData.count), 'color', 'r', 'lineWidth', 2)
plot(xvals, tempData.setPoint(1:tempData.count), 'color', 'b', 'lineWidth', 2)

xlim([0 180])
ylim([15 40])

box off
set(gca, 'XTick', [60 120 180], 'Ytick', [20 30 40], 'FontSize', 36)
xlabel('time (s)', 'FontSize', 40)
ylabel('temp. (°C)', 'FontSize', 40)

text(150, 40, 'measured temp', 'fontsize', 20, 'fontweight', 'bold', 'color', 'r')
text(150, 38.5, 'set temp', 'fontsize', 20, 'fontweight', 'bold', 'color', 'b')

export_fig('temp_fig_1', '-pdf')

load(temp_fig_2)
load(traj_fig_2)
f1 = figure('Color', 'w', 'units', 'normalized','Position', [.01 .01 .6 .6]);
for aa = 6:tempData.count-5
    tempData.measuredTemp(aa) = mean(tempData.measuredTemp(aa-5:aa+5));
end

timeStamp = data.timeStamp(data.count)-data.timeStamp(1);
xvals = linspace(1,timeStamp, tempData.count);

hold on
plot(xvals, tempData.measuredTemp(1:tempData.count), 'color', 'r', 'lineWidth', 2)
plot(xvals, tempData.setPoint(1:tempData.count), 'color', 'b', 'lineWidth', 2)

xlim([0 180])
ylim([15 40])

box off
set(gca, 'XTick', [60 120 180], 'Ytick', [20 30 40], 'FontSize', 36)
xlabel('time (s)', 'FontSize', 40)
ylabel('temp. (°C)', 'FontSize', 40)

text(150, 40, 'measured temp', 'fontsize', 20, 'fontweight', 'bold', 'color', 'r')
text(150, 38.5, 'set temp', 'fontsize', 20, 'fontweight', 'bold', 'color', 'b')

export_fig('temp_fig_2', '-pdf')
