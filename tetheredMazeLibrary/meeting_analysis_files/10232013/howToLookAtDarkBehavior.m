f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .6 .2])
s1 = subplot(1,2,1)

b1 = fill(linspace(-.15,.15, 41),n, [.5 .5 .5])
set(b1, 'FaceAlpha', .5)
hold on
plot(linspace(-.15,.15, 41),n, 'k', 'LineWidth', 2)
ylabel('normalized counts')
xlabel('dTheta (rad)')
xlim([-.15 .15])
title('instantaneous turn histogram')

s1 = subplot(1,2,2)
pos = get(s1, 'Position');
set(s1, 'Position', [pos(1) pos(2)+pos(1)/2 pos(3) pos(4)/4])
cmap = pmkmp(50);
colormap(cmap);
imagesc(n)
axis  off
title('intantaneous heatmap')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/10232013/')
export_fig('looking_at_dark_behavior')