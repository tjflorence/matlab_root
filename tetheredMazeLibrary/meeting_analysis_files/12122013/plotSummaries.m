close all

mean_DL_wt  = nanmean(DL_wt_choicePerf);
SEM_DL_wt   = nanstd(DL_wt_choicePerf)/sqrt(size(DL_wt_choicePerf,1));

mean_19C10_kir  = nanmean(uasKir_DL_x_19C10DBD_choicePerf);
SEM_19C10_kir   = nanstd(uasKir_DL_x_19C10DBD_choicePerf)/sqrt(size(uasKir_DL_x_19C10DBD_choicePerf,1));

mean_48A08_kir  = nanmean(uasKir_DL_x_48A08AD_choicePerf);
SEM_48A08_kir   = nanstd(uasKir_DL_x_48A08AD_choicePerf)/sqrt(size(uasKir_DL_x_48A08AD_choicePerf,1));

mean_48A08_ShiTS  = nanmean(uas_ShiTS_x_48A08AD_choicePerf);
SEM_48A08_ShiTS   = nanstd(uas_ShiTS_x_48A08AD_choicePerf)/sqrt(size(uas_ShiTS_x_48A08AD_choicePerf,1));

mean_19C10_ShiTS  = nanmean(uas_ShiTS_x_19C10DBD_choicePerf);
SEM_19C10_ShiTS   = nanstd(uas_ShiTS_x_19C10DBD_choicePerf)/sqrt(size(uas_ShiTS_x_19C10DBD_choicePerf,1));


%% plots for grand summaries
f1 = figure('units', 'normalized', 'Position', [.1 .1 .6 .6], 'Color', 'w');
noiseTerm = .15*randn(5);

fill_1 = fill([4.5 5.5 5.5 4.5], [0 0 1 1], [.9 .9 .9]);
hold on
fill_2 = fill([7.5 8.5 8.5 7.5], [0 0 1 1], [.9 .9 .9]);

errorbar((1:8)+noiseTerm(1), mean_DL_wt, SEM_DL_wt, 'Color', 'k', 'LineWidth',3)
s1 = scatter((1:8)+noiseTerm(1), mean_DL_wt, 100, 'k');
set(s1, 'MarkerFaceColor', 'k')


errorbar((1:8)+noiseTerm(4), mean_48A08_kir, SEM_48A08_kir, 'Color', 'b', 'LineWidth',3)
s1 = scatter((1:8)+noiseTerm(4), mean_48A08_kir, 100, 'b');
set(s1, 'MarkerFaceColor', 'b')


errorbar((1:8)+noiseTerm(5), mean_48A08_ShiTS, SEM_48A08_ShiTS, 'Color', 'r', 'LineWidth',3)
s1 = scatter((1:8)+noiseTerm(5), mean_48A08_ShiTS, 100, 'r');
set(s1, 'MarkerFaceColor', 'r')

plot([0 10], [.5 .5], 'k')

xlim([.5 8.5])

set(gca, 'XTick', [1 2 3 4 5 6 7 8], 'XTickLabel', {'tr 1-5', 'tr 6-10', 'tr 11-15', 'tr 16-20', 'testA', 'tr 21-25', 'tr 26-30', 'testB'})
ylabel('found cool zone / chose left')
rotateXLabels(gca(),45)

text(.8, .3, 'DL, n = 9', 'fontweight', 'bold', 'Color', 'k')
text(.8, .25, '48A08AD x uas-ShiTS, n = 8', 'fontweight', 'bold', 'Color', 'r')
text(.8, .2, '48A08AD x DL+; tubP-gal80ts; uas-Kir2.1,  n = 9', 'fontweight', 'bold', 'Color', 'b')

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/12122013/')
export_fig('summary_plot')