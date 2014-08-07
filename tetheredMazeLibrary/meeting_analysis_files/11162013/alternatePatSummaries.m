symPat_insertVec = symPat_insertVec(1:7,:);
symPat_insertVec(3,28) = 2;
symPat_insertVec(3,21) = 0;

f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .9 .9]);
imagesc(symPat_insertVec)
caxis([0 6])
axis equal off
cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...dark blue
        1 183 255; ...dark orange        
        111 255 243;...
        255 145 111]
    hold on
    
z1 = scatter(33,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(34,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)

z1 = scatter(33,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(34,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)
text(34.5, 2.5, 'found target / chose left')
text(34.5, 3.5, 'missed target / chose right')

z1 = scatter(33,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(34.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(11.5,0, 'test 1')
text(16.5, 0, 'train 11-20')
text(27.5, 0, 'test 2')

for aa = 1:length(symPat)
    text(-1, aa, ['fly ' num2str(aa)])
end

for aa = 1:length(symPat)
   
    yval = aa+.5

    plot([0 31.5], [yval yval], 'Color', 'k')
end
text(-2, 5, 'left lane cool', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013')
export_fig('symPat_summary')

f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .9 .9]);

imagesc(noisePat_insertVec)
caxis([0 6])
axis equal off
cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...dark blue
        1 183 255; ...dark orange        
        111 255 243;...
        255 145 111]
    hold on
    
z1 = scatter(33,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(34,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)

z1 = scatter(33,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(34,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)
text(34.5, 2.5, 'found target / chose left')
text(34.5, 3.5, 'missed target / chose right')

z1 = scatter(33,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(34.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(11.5,0, 'test 1')
text(16.5, 0, 'train 11-20')
text(27.5, 0, 'test 2')

for aa = 1:length(noisePat)
    text(-1, aa, ['fly ' num2str(aa)])
end

for aa = 1:length(noisePat)
   
    yval = aa+.5

    plot([0 31.5], [yval yval], 'Color', 'k')
end
text(-2, 4.5, 'left lane cool', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013')
export_fig('noisePat')


%% hit summary
f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .6 .9]);
leftGo_hitStd = nanstd(leftGo_performance)/sqrt(20);
noisePat_hitStd = nanstd(noisePat_performance)/sqrt(4);
symPat_hitStd = nanstd(symPat_performance)/sqrt(7);

plot([-100 100], [.5 .5], 'Color', 'k')
xlim([.75 4.25])
ylim([0 1.1])

hold on

z1 = scatter(1:4, nanmean(leftGo_performance), 200)
set(z1, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'b', 'LineWidth', 4)
hold on
errorbar( nanmean(leftGo_performance), leftGo_hitStd, 'b', 'LineWidth', 4)

z2 = scatter(1:4, nanmean(noisePat_performance), 200)
set(z2, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', 'k', 'LineWidth', 4)
hold on
errorbar( nanmean(noisePat_performance), noisePat_hitStd, 'k', 'LineWidth', 4)

z3 = scatter(1.1:4.1, nanmean(symPat_performance), 200)
set(z3, 'MarkerFaceColor', 'none', 'MarkerEdgeColor', [1 0 0], 'LineWidth', 4)
hold on
errorbar( 1.1:4.1, nanmean(symPat_performance), symPat_hitStd,'Color',  [1 0 0], 'LineWidth', 4)

set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'train block 1' 'test block 1' 'train block 2' 'test block 2'}, 'YTick', [.25 .5 .75 1])
ylabel('found cool zone / chose left')

box off

title('alternate pattern summary')
text(1, .95, 'diagonal pattern (n = 21)', 'color', [0 0 1], 'FontWeight', 'bold')
text(1, .92, 'symmetric pattern (n = 7)', 'color', 'r', 'FontWeight', 'bold')
text(1, .89, 'noise pattern (n = 4)', 'color', 'k', 'FontWeight', 'bold')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013/')
export_fig('altPat_hit_summary')