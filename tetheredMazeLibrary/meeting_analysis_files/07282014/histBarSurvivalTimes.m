f1 = figure('color', 'w', 'units', 'normalized', 'Position', [.1 .1 .5 .5])

flySurvivalTimes_280 = [66 28 25 23 14 76 3 9 26 12 45];
flySurvivalTimes_300 = [31 25 28 38 20 23 78 50 65];

bins_280 = histc(flySurvivalTimes_280, linspace(1,80,9));
bins_300 = histc(flySurvivalTimes_300, linspace(1,80,9));


b1 = bar( [bins_280' bins_300'], 'stack', 'BarWidth', [.95], 'EdgeColor', 'k')
set(b1(1), 'FaceColor', [73 165 255]./255)
set(b1(2), 'FaceColor', [255 55 60]./255)

set(gca, 'XTickLabel', {'0-9', '10-19', '20-29', '30-39', '40-49', '50-59', '60-69', '70-79', ' '}, 'FontSize', 20)
rotateXLabels(gca, 45)
set(gca, 'YTick', [0:2:8])
ylim([0 8.5])
xlabel('useful behavior time (min)')
ylabel('# flies')

box off


legend('280 mOms', '300 mOsm')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07282014/')
export_fig('useful behavior time', '-pdf')