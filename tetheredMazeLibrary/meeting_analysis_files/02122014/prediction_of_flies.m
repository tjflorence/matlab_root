close all



labelSize = .05;
noiseSize = .02;

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.2 .2 .4 .6])

plot([0 1], [0 1], 'k')
hold on

noiseTerm = noiseSize*randn(20);


%% shibire
for aa = 1:size(uas_ShiTS_x_48A08AD_prediction_L,1)
    
    
    s1 = scatter(uas_ShiTS_x_48A08AD_prediction_L(aa,1)+noiseTerm(aa), uas_ShiTS_x_48A08AD_prediction_L(aa,2)+noiseTerm(21-aa), 100,'k');
    set(s1, 'MarkerFaceColor', 'b', 'MarkerEdgeColor', [0 0 .5])
    
    hold on
    
 %   plot([uas_ShiTS_x_48A08AD_prediction(aa,1)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm,], [uas_ShiTS_x_48A08AD_prediction(aa,2)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm], 'r')
    
 %   text(uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm, ['DL ' num2str(aa)])
end

%% shibire
for aa = 1:size(uas_ShiTS_x_48A08AD_prediction_R,1)
    
    
    s1 = scatter(uas_ShiTS_x_48A08AD_prediction_R(aa,1)+noiseTerm(aa), uas_ShiTS_x_48A08AD_prediction_R(aa,2)+noiseTerm(21-aa), 100,'k');
    set(s1, 'MarkerFaceColor', 'g', 'MarkerEdgeColor', [0 .5 0])
    
    hold on
    
 %   plot([uas_ShiTS_x_48A08AD_prediction(aa,1)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm,], [uas_ShiTS_x_48A08AD_prediction(aa,2)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm], 'r')
    
 %   text(uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm, ['DL ' num2str(aa)])
end

xlim([0 1.1])
ylim([0 1.1])
axis equal


set(gca, 'XTick', [0 .25 .5 .75 1], 'YTick', [0 .25 .5 .75 1])

text(0, 1+.05, '48A08AD x uas-ShiTS, n = 18', 'fontweight', 'bold', 'Color', 'b')
text(0, .95+.05, '48A08AD x uas-ShiTS, n = 20', 'fontweight', 'bold', 'Color', 'g')
axis equal

xlabel('test A performance (fraction correct)')
ylabel('test B performance (fraction correct)')

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02122014/')
export_fig('predict_test_performance')