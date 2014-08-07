close all

DL_prediction;
uas_ShiTS_x_48A08AD_prediction;
uasKir_DL_x_48A08AD_prediction;

labelSize = .05;
noiseSize = .05;

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.2 .2 .4 .6])

plot([0 1], [0 1], 'k')
hold on

%% DL
for aa = 1:size(DL_prediction,1)
    
    noiseTerm = noiseSize*randn(1);
    
    s1 = scatter(DL_prediction(aa,1)+noiseTerm, DL_prediction(aa,2)+noiseTerm, 100,'k');
    set(s1, 'MarkerFaceColor', [.5 .5 .5])
    
    hold on
    
   % plot([DL_prediction(aa,1)+noiseTerm, DL_prediction(aa,1)+labelSize+noiseTerm,], [DL_prediction(aa,2)+noiseTerm, DL_prediction(aa,2)+labelSize+noiseTerm], 'k')
    
   % text(DL_prediction(aa,1)+labelSize+noiseTerm, DL_prediction(aa,2)+labelSize+noiseTerm, ['DL ' num2str(aa)])
end

%% shibire
for aa = 1:size(uas_ShiTS_x_48A08AD_prediction,1)
    
    noiseTerm = noiseSize*randn(1);
    
    s1 = scatter(uas_ShiTS_x_48A08AD_prediction(aa,1)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+noiseTerm, 100,'k');
    set(s1, 'MarkerFaceColor', 'r')
    
    hold on
    
 %   plot([uas_ShiTS_x_48A08AD_prediction(aa,1)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm,], [uas_ShiTS_x_48A08AD_prediction(aa,2)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm], 'r')
    
 %   text(uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm, ['DL ' num2str(aa)])
end

xlim([-.1 1.1])
ylim([-.1 1.1])
axis equal

%% kir
for aa = 1:size(uasKir_DL_x_48A08AD_prediction,1)
    
    noiseTerm = noiseSize*randn(1);
    
    s1 = scatter(uasKir_DL_x_48A08AD_prediction(aa,1)+noiseTerm, uasKir_DL_x_48A08AD_prediction(aa,2)+noiseTerm, 100,'k');
    set(s1, 'MarkerFaceColor', 'b')
    
    hold on
    
 %   plot([uas_ShiTS_x_48A08AD_prediction(aa,1)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm,], [uas_ShiTS_x_48A08AD_prediction(aa,2)+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm], 'r')
    
 %   text(uas_ShiTS_x_48A08AD_prediction(aa,1)-labelSize+noiseTerm, uas_ShiTS_x_48A08AD_prediction(aa,2)+labelSize+noiseTerm, ['DL ' num2str(aa)])
end

xlim([-.1 1.1])
ylim([-.1 1.1])
axis equal

set(gca, 'XTick', [0 .25 .5 .75 1], 'YTick', [0 .25 .5 .75 1])

text(0, 1+.05, 'DL, n = 9', 'fontweight', 'bold', 'Color', 'k')
text(0, .95+.05, '48A08AD x uas-ShiTS, n = 8', 'fontweight', 'bold', 'Color', 'r')
text(0, .9+.05, '48A08AD x DL+; tubP-gal80ts; uas-Kir2.1,  n = 9', 'fontweight', 'bold', 'Color', 'b')
axis equal

xlabel('test A performance (fraction correct)')
ylabel('test B performance (fraction correct)')

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/12122013/')
export_fig('predict_test_performance')