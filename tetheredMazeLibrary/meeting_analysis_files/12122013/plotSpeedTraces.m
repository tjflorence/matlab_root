uasKir_48A08AD_laneSpeed;
shiTS_48A08AD_laneSpeed;
DL_laneSpeed;

close all

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.2 .2 .8 .8])

fill_1 = fill([20.5 24.5 24.5 20.5], [0 0 100 100], [.9 .9 .9]);
hold on
fill_2 = fill([34.5 38.5 38.5 34.5], [0 0 100 100], [.9 .9 .9]);


noiseTerms = .2*randn(3);
%% DL
errorbar((1:20)+noiseTerms(1), nanmean(DL_laneSpeed(:,1:20)), nanstd(DL_laneSpeed(:,1:20))/sqrt(size(DL_laneSpeed,1)), 'k', 'LineWidth', 2)
hold on
s1 = scatter((1:20)+noiseTerms(1), nanmean(DL_laneSpeed(:,1:20)),75, 'k');
set(s1, 'MarkerFaceColor', 'k')

errorbar((25:34)+noiseTerm(1), nanmean(DL_laneSpeed(:,25:34)), nanstd(DL_laneSpeed(:,25:34))/sqrt(size(DL_laneSpeed,1)), 'k', 'LineWidth', 2)
s1 = scatter((25:34)+noiseTerm(1), nanmean(DL_laneSpeed(:,25:34)),75, 'k');
set(s1, 'MarkerFaceColor', 'k')

%% 48A08AD_shi
errorbar((1:20)+noiseTerms(2), nanmean(shiTS_48A08AD_laneSpeed(:,1:20)), nanstd(shiTS_48A08AD_laneSpeed(:,1:20))/sqrt(size(shiTS_48A08AD_laneSpeed,1)), 'r', 'LineWidth', 2)
hold on
s1 = scatter((1:20)+noiseTerms(2), nanmean(shiTS_48A08AD_laneSpeed(:,1:20)),75, 'r');
set(s1, 'MarkerFaceColor', 'r')

errorbar((25:34)+noiseTerms(2), nanmean(shiTS_48A08AD_laneSpeed(:,25:34)), nanstd(shiTS_48A08AD_laneSpeed(:,25:34))/sqrt(size(shiTS_48A08AD_laneSpeed,1)), 'r', 'LineWidth', 2)
s1 = scatter((25:34)+noiseTerms(2), nanmean(shiTS_48A08AD_laneSpeed(:,25:34)),75, 'r');
set(s1, 'MarkerFaceColor', 'r')

%% 48A08AD_kir
errorbar((1:20)+noiseTerms(3), nanmean(uasKir_48A08AD_laneSpeed(:,1:20)), nanstd(uasKir_48A08AD_laneSpeed(:,1:20))/sqrt(size(uasKir_48A08AD_laneSpeed,1)), 'b', 'LineWidth', 2)
hold on
s1 = scatter((1:20)+noiseTerms(3), nanmean(uasKir_48A08AD_laneSpeed(:,1:20)),75, 'b');
set(s1, 'MarkerFaceColor', 'b')

errorbar((25:34)+noiseTerms(3), nanmean(uasKir_48A08AD_laneSpeed(:,25:34)), nanstd(uasKir_48A08AD_laneSpeed(:,25:34))/sqrt(size(uasKir_48A08AD_laneSpeed,1)), 'b', 'LineWidth', 2)
s1 = scatter((25:34)+noiseTerms(3), nanmean(uasKir_48A08AD_laneSpeed(:,25:34)),75, 'b');
set(s1, 'MarkerFaceColor', 'b')

box off

ylim([15 100])
xlim([.5 38.5])
set(gca, 'XTick', [5 10 15 20 25 30 34], 'XTickLabel', {'5', '10', '15', '20', '21', '26', '30'})
ylabel(['walking speed within lane (mm/sec)'])

text(2, 100.05, 'DL, n = 9', 'fontweight', 'bold', 'Color', 'k')
text(2, 97, '48A08AD x uas-ShiTS, n = 8', 'fontweight', 'bold', 'Color', 'r')
text(2, 94, '48A08AD x DL+; tubP-gal80ts; uas-Kir2.1,  n = 9', 'fontweight', 'bold', 'Color', 'b')

xlabel('training trial number')


cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/12122013/')
export_fig('fly walking speed')