f1 = figure('color', 'w', 'units', 'normalized')

survivalTimes_280 = [66 28 25 23 14 76 3 9 26 12 45];
survivalTimes_300 = [30 25 27]

bins = histc(flySurvivalTimes, linspace(1,80,9));

b1 = bar(bins, 'BarWidth', [.95], 'EdgeColor', 'k', 'FaceColor', [104 210 255]./255 )

set(gca, 'XTickLabel', {'0-9', '10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79', ' '}, 'FontSize', 20)
rotateXLabels(gca, 45)
set(gca, 'YTick', [0:2:4])
ylim([0 4.5])
xlabel('survival time (min)')
ylabel('# flies')

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07112014/')
export_fig('survival_times', '-pdf')