close all

mean_48A08_ShiTS_L  = nanmean(uas_ShiTS_x_48A08AD_choicePerf_L);
SEM_48A08_ShiTS_L   = nanstd(uas_ShiTS_x_48A08AD_choicePerf_L)/sqrt(size(uas_ShiTS_x_48A08AD_choicePerf_L,1));

mean_48A08_ShiTS_R  = nanmean(uas_ShiTS_x_48A08AD_choicePerf_R);
SEM_48A08_ShiTS_R   = nanstd(uas_ShiTS_x_48A08AD_choicePerf_R)/sqrt(size(uas_ShiTS_x_48A08AD_choicePerf_R,1));


%% plots for grand summaries
f1 = figure('units', 'normalized', 'Position', [.1 .1 .4 .6], 'Color', 'w');
noiseTerm = .02*randn(20);



fill_1 = fill([4.5 5.5 5.5 4.5], [0 0 1 1], [.9 .9 .9]);
hold on
fill_2 = fill([7.5 8.5 8.5 7.5], [0 0 1 1], [.9 .9 .9]);

for aa = 1:18
    for bb = 1:8
        z1 = scatter(bb-.1+noiseTerm(aa), uas_ShiTS_x_48A08AD_choicePerf_L(aa,bb)+noiseTerm(21-aa), 50)
        set(z1, 'MarkerEdgeColor', [0 0 .5], 'MarkerFaceColor', [0 0 .5])       
    end
end

for aa = 1:20
    for bb = 1:8
        z1 = scatter(bb+.1+noiseTerm(aa), uas_ShiTS_x_48A08AD_choicePerf_R(aa,bb)+noiseTerm(21-aa), 50)
        set(z1, 'MarkerEdgeColor', [0 .5 0], 'MarkerFaceColor', [0 1 .5])       
    end
end


errorbar((1:8)-.1, mean_48A08_ShiTS_L, SEM_48A08_ShiTS_L, 'Color', 'b', 'LineWidth',3)
s1 = scatter((1:8)-.1, mean_48A08_ShiTS_L, 100, 'b');
set(s1, 'MarkerFaceColor', 'b')


errorbar((1:8)+.1, mean_48A08_ShiTS_R, SEM_48A08_ShiTS_R, 'Color', 'g', 'LineWidth',3)
s1 = scatter((1:8)+.1, mean_48A08_ShiTS_R, 100, 'g');
set(s1, 'MarkerFaceColor', 'g')

plot([0 10], [.5 .5], 'k')

xlim([.5 8.5])
ylim([0 1])
set(gca, 'XTick', [1 2 3 4 5 6 7 8], 'XTickLabel', {'tr 1-5', 'tr 6-10', 'tr 11-15', 'tr 16-20', 'testA', 'tr 21-25', 'tr 26-30', 'testB'})
ylabel('found cool zone / chose left')
rotateXLabels(gca(),45)

text(1, .1, '48A08AD x uas-ShiTS (L), n = 18', 'fontweight', 'bold', 'Color', 'g')
text(1, .05, '48A08AD x uas-ShiTS (R) , n = 20', 'fontweight', 'bold', 'Color', 'b')

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02122014/')
export_fig('summary_plot')