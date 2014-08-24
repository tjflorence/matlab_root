load('/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140821/flir_data.mat')

f1 = figure('Color', 'w', 'units', 'normalized')
closeup = Frame1309(40:100, 95:219)

s1 = subplot(2,1,1)
i1 = imagesc(closeup)
axis equal off

colormap(cool(2^8))
caxis([20 30])

c1 = colorbar('YTick', [20 25 30], 'YTickLabel', { '20 °C     ', '25 °C        ', '30 °C     '}, 'FontSize', 20 )
c_pos = get(c1, 'Position');
disp(c_pos)

a1 = get(s1, 'Position')
set(s1, 'Position', [a1(1)-.1, a1(2) a1(3) a1(4)])
set(c1, 'Position', [c_pos(1)-.2, c_pos(2)+.01, c_pos(3), c_pos(4)-.01])

axis tight

cd('/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140821/')
export_fig('thermal_image.pdf', '-pdf')


s2 = subplot(2,1,2)
plot(linspace(0,1, 171-139+1), Frame1309(63,139:171), 'r', 'LineWidth', 2)
a2 = get(s2, 'Position')
set(s2, 'Position', [a2(1)-.03, a2(2)+.01, a2(3)-.25, a2(4)])
hold on


xlim([0 1])
ylim([24 30])

xlabel('norm. body position', 'FontSize', 20)
ylabel('temp (°C)', 'FontSize', 20)


set(gca, 'Xtick', [.25 .5 .75], 'YTick', [25 28], 'FontSize', 20)

   ah1=axes('position',[0.08,.46,.235,.35],'visible','off'); % <- select your pos...
     line([.1,.9],[.1,.9],'parent',ah1,'linewidth', .9, 'Color', 'k', 'LineStyle', '--');
     
   ah1=axes('position',[0.41 ,.46,.235,.35],'visible','off'); % <- select your pos...
     line(-[.1,.9],[.1,.9],'parent',ah1,'linewidth',.9, 'Color', 'k', 'LineStyle', '--');

hold on
box off

export_fig('thermal_img+plot.pdf', '-pdf')