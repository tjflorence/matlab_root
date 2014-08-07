load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_vertical_time_1.mat')
time1_data_v = calibStruct.rawVals;

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_vertical_time_10.mat')
time2_data_v = calibStruct.rawVals;

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_vertical_time_100.mat')
time3_data_v = calibStruct.rawVals;

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_horizontal_time_1.mat')
time1_data_h = calibStruct.rawVals;

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_horizontal_time_10.mat')
time2_data_h = calibStruct.rawVals;

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/04072014/calibData_horizontal_time_100.mat')
time3_data_h = calibStruct.rawVals;


f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .4 .4])


for aa = 1:numel(time1_data_h)
    z1 = scatter(1+ .15*randn(1), time1_data_h(aa)/2, 300, 'r')
    set(z1, 'markerFaceColor', ['r'], 'markeredgecolor', 'k')
    hold on
end

for aa = 1:numel(time2_data_h)
    z1 = scatter(2+.15*randn(1), time2_data_h(aa)/2, 300, 'r')
    set(z1, 'markerFaceColor', 'r', 'markeredgecolor', 'k')
    hold on
end

for aa = 1:numel(time3_data_h)
    z1 = scatter(3+.15*randn(1), time3_data_h(aa)/2, 300, 'r')
    set(z1, 'markerFaceColor', 'r', 'markeredgecolor', 'k')
    hold on
end

ylim([2.5 5])
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'1' '10' '100'}, 'FontSize', 30, 'YTick', [3 4 5])
xlabel('seconds per trial')
ylabel('calibration value (ticks/mm)')
title('Roll (Vss)')

z1 = scatter(1, 4.2, 's')
set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')


export_fig('calibration_values', '-pdf')
