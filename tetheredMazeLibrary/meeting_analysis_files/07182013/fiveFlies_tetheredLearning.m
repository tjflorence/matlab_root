cdfly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507220956_stimulusTest';
fly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507223423_stimulusTest';

fly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507211616_stimulusTest';
fly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507213431_stimulusTest';

fly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507173629_stimulusTest';
fly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507175949_stimulusTest';

fly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707171517_stimulusTest';
fly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707175559_stimulusTest';

fly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707150508_stimulusTest';
fly(5).tr2 = 'k';

for aa = 1:4
    
    cd(fly(aa).tr1)
    load('summaryVec.mat')
    fly(aa).tr1_data = summaryVec;
    
    cd(fly(aa).tr2)
    load('summaryVec.mat')
    fly(aa).tr2_data = summaryVec;    
    
end


cd(fly(5).tr1) 
load('summaryVec.mat')
fly(5).tr1_data = summaryVec;
fly(5).tr2_data = 5*ones(1,14);

 f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .5 .5])
 s1 = subplot(3,3,[1:2; 4:5])
 


colorSummaryMatrix = [fly(1).tr1_data fly(1).tr2_data;...
 fly(2).tr1_data fly(2).tr2_data;...
 fly(3).tr1_data fly(3).tr2_data;...
 fly(4).tr1_data fly(4).tr2_data;...
 fly(5).tr1_data fly(5).tr2_data]

colorSummaryMatrix = [colorSummaryMatrix 6*ones(5,2)]

imagesc(colorSummaryMatrix)
caxis([0 6])
axis equal off
cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        1 183 255; ...
        255 86  1; ...
        111 255 243;...
        255 145 111]
    hold on
    
z1 = scatter(29,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(30,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)

z1 = scatter(29,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(30,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)
text(30.5, 2.5, 'found target / correct choice')
text(30.5, 3.5, 'missed target / incorrect choice')

z1 = scatter(30,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(30.5, 4.5, 'dead')

text(.5, 0, 'train 1-10')
text(10.5,0, 'test 1')
text(14.5, 0, 'train 11-20')
text(24.5, 0, 'test 2')

text(-.5, 1, 'fly 1')
text(-.5, 2, 'fly 2')
text(-.5, 3, 'fly 3')
text(-.5, 4, 'fly 4')
text(-.5, 5, 'fly 5')

for aa = 1:4
   
    yval = aa+.5

    plot([0 28.5], [yval yval], 'Color', 'k')
end

           
colormap(flipud(cMap)./255)
hold on


 s2 = subplot(3,3, 7:8)
summaryPlotMatrix = [.4 .75 .8 .75;...
                          .2 .5  .5 .75;...
                          .4 .75 .4 .75;...
                          .7 .75 .5 1;...
                          .5 .75 nan nan]
 meanPerf = nanmean(summaryPlotMatrix);
 

 plot([0 5], [.5 .5], 'Color', 'k')
 
 
for aa = 1:5
    hold on
 plot([1:1:4], summaryPlotMatrix(aa,:), 'Color', [.5 .5 .5], 'LineWidth', 2)
 z1 = scatter([1:1:4], summaryPlotMatrix(aa,:),50);
 set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [.5 .5 .5])
end




plot(meanPerf, 'Color', 'r', 'LineWidth', 4)
z1 = scatter([1:1:4], meanPerf,50);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [1 0 0])
ylim([0 1])
xlim([.5 4.5])
ylabel('fraction correct')
set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'train_1', 'test_1', 'train_2', 'test_2'})
box off

title('experiment summary')

sizePlot = get(s1, 'Position')
set(s1, 'position', [sizePlot(1) .2 sizePlot(3)*2 sizePlot(4)*2])

sizePlot = get(s2, 'Position')
set(s2, 'position', [sizePlot(1) .4 sizePlot(3)*.75 sizePlot(4)])

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07182013/')
export_fig('thermal_maze_summary')
