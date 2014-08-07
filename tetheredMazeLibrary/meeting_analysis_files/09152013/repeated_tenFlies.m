%% old experimental flies 
fly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507220956_stimulusTest';
fly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507223423_stimulusTest';

fly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507211616_stimulusTest';
fly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507213431_stimulusTest';

fly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507173629_stimulusTest';
fly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-15/20131507175949_stimulusTest';

fly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707171517_stimulusTest';
fly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707175559_stimulusTest';

fly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-17/20131707150508_stimulusTest';
fly(5).tr2 = 'k';

fly(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-19/20131907162346_stimulusTest/';
fly(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-19/20131907164713_stimulusTest/';

fly(7).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207123723_stimulusTest/';
fly(7).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207125902_stimulusTest/';

fly(8).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207144008_stimulusTest/';
fly(8).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-22/20132207150130_stimulusTest/';

fly(9).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307124335_stimulusTest/';
fly(9).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307130435_stimulusTest/';

fly(10).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307142231_stimulusTest/';
fly(10).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-23/20132307144136_stimulusTest/';

fly(11).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-25/20132507151133_stimulusTest/';
fly(11).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-07-25/20132507153314_stimulusTest/';

%% new experimental flies 
%% experimental flies -- after stripe fixation trigger

nfly(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209173123_stimulusTest/';
nfly(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209175118_stimulusTest/';

nfly(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209191116_stimulusTest/';
nfly(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209193229_stimulusTest/';

nfly(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209200253_stimulusTest/';
nfly(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-12/20131209202137_stimulusTest/';

nfly(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309110921_stimulusTest/';
nfly(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309113258_stimulusTest/';

nfly(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309132432_stimulusTest/';
nfly(5).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309134546_stimulusTest/';

nfly(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309155809_stimulusTest/';
nfly(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309161956_stimulusTest/';

nfly(7).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309164330_stimulusTest/';
nfly(7).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-09-13/20131309171027_stimulusTest/';

%% experiment flies
for aa = 1:11
    
    cd(fly(aa).tr1)
    load('summaryVec.mat')
    fly(aa).tr1_data = summaryVec;
    
    try
    cd(fly(aa).tr2)
    load('summaryVec.mat')
    fly(aa).tr2_data = summaryVec;    
    catch
        fly(aa).tr2_data = 5*ones(1,14);
    end

end


cd(fly(5).tr1) 
load('summaryVec.mat')
fly(5).tr1_data = summaryVec;
fly(5).tr2_data = 5*ones(1,14);

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .5 .5])
s1 = subplot(3,7,[1:2, 4:5])
 
 colorSummaryMatrix = nan(11,28);

for aa = 1:11
    colorSummaryMatrix(aa,:) = [fly(aa).tr1_data fly(aa).tr2_data];
end

colorSummaryMatrix = [colorSummaryMatrix 6*ones(11,2)]

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
text(30.5, 2.5, 'found target / chose right')
text(30.5, 3.5, 'missed target / chose left')

z1 = scatter(30,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(30.5, 4.5, 'dead')

text(.5, 0, 'train 1-10')
text(10.5,0, 'test 1')
text(14.5, 0, 'train 11-20')
text(24.5, 0, 'test 2')

for aa = 1:11
    text(-.7, aa, ['fly ' num2str(aa)])
end

for aa = 1:11
   
    yval = aa+.5

    plot([0 28.5], [yval yval], 'Color', 'k')
end
text(-2, 9.5, 'previous flies', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on

s2 = subplot(7,3,[7:8,10:11])
%% control flies
for aa = 1:7
    
    cd(nfly(aa).tr1)
    load('summaryVec.mat')
    nfly(aa).tr1_data = summaryVec;
    
    
    cd(nfly(aa).tr2)
    load('summaryVec.mat')
    nfly(aa).tr2_data = summaryVec;    
 
end



% f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .5 .5])
% s1 = subplot(3,3,[1:2; 4:5])
control_colorSummaryMatrix = nan(7,30);

for aa = 1:7
    control_colorSummaryMatrix(aa,:) = [nfly(aa).tr1_data nfly(aa).tr2_data 6*ones(1,2)];
end

%control_colorSummaryMatrix = [control_colorSummaryMatrix 6*ones(7,2)]

imagesc(control_colorSummaryMatrix)
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
text(30.5, 2.5, 'found target / chose right')
text(30.5, 3.5, 'missed target / chose left')

z1 = scatter(30,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(30.5, 4.5, 'dead')

text(.5, 0, 'train 1-10')
text(10.5,0, 'test 1')
text(14.5, 0, 'train 11-20')
text(24.5, 0, 'test 2')

for aa = 1:7
    text(-.7, aa, ['fly ' num2str(aa)])
end

for aa = 1:7
   
    yval = aa+.5

    plot([0 28.5], [yval yval], 'Color', 'k')
end

text(-2, 7.5, '+ stripe fix', 'rotation', 90)
           
colormap(flipud(cMap)./255)
hold on

s3 = subplot(3,7, 18:20)
summaryPlotMatrix = [.4 .75 .8 .75;...
                          .2 .5  .5 .75;...
                          .4 .75 .4 .75;...
                          .7 .75 .5 1;...
                          .5 .75 nan nan;...
                          .3 0 .5 .75;...
                          .9 .5 .6 .75;...
                          .9 1 .9 .75;...
                          .4 0 .5 .25
                          .9 .5 .9 1
                          .3 .75 .5 .75]
 meanPerf = nanmean(summaryPlotMatrix);
 
 control_summaryPlotMatrix = [.9  .75 .9 .75;... 1
                              .8  .75 .8 .25;... 2
                              .6  .75 .9  1;... 3
                              .5  .25 .8  .75;... 4
                              .7  .25 .9  .75;... 5
                              .3  .75  .7  1;... 6
                              .7  .25  .8  .75] ...7
                              
 control_meanPerf = nanmean(control_summaryPlotMatrix);


 plot([0 5], [.5 .5], 'Color', 'k')
 expOffset = .2;

 controloffSet = 0;

 
 
for aa = 1:11
    hold on
    rando = .15+.02*randn(1);
    
 plot([1:1:4]-expOffset+rando, summaryPlotMatrix(aa,:), 'Color', [1 170/255 165/255], 'LineWidth', 2)
 z1 = scatter([1:1:4]-expOffset+rando, summaryPlotMatrix(aa,:),50);
 set(z1, 'MarkerEdgeColor', [.5 .5 .5], 'MarkerFaceColor', [1 170/255 165/255])
end

plot(meanPerf, 'Color', 'r', 'LineWidth', 8)

for aa = 1:7
    hold on
    rando = .15+.02*randn(1);
    
 plot([1:1:4]-controloffSet+rando, control_summaryPlotMatrix(aa,:), 'Color', [.5 .5 .5], 'LineWidth', 2)
 z1 = scatter([1:1:4]-controloffSet+rando, control_summaryPlotMatrix(aa,:),50);
 set(z1, 'MarkerEdgeColor', [.5 .5 .5], 'MarkerFaceColor', [.5 .5 .5])
end
plot(meanPerf, 'Color', 'r', 'LineWidth', 8)
plot(control_meanPerf, 'Color', 'k', 'LineWidth', 4)
z1 = scatter([1:1:4], control_meanPerf,100);
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'k')



plot(control_meanPerf, 'Color', 'k', 'LineWidth', 8)

z1 = scatter([1:1:4], meanPerf,100);
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [1 0 0])
ylim([0 1])
xlim([.5 4.5])
ylabel('found cool spot / choose right')
set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'train_1', 'test_1', 'train_2', 'test_2'})
box off

title('experiment summary')

%sizePlot = get(s1, 'Position')
%set(s1, 'position', [sizePlot(1) .2 sizePlot(3)*2 sizePlot(4)*2])

sizePlot = get(s2, 'Position')
set(s2, 'position', [sizePlot(1) sizePlot(2)-.03 sizePlot(3)*1.105 sizePlot(4)*1.3])

sizePlot = get(s3, 'Position')
set(s3, 'position', [sizePlot(1)-.35 sizePlot(2)+.1 sizePlot(3)*1.5 sizePlot(4)*.8])
text(4.2,.9, 'previous flies (N = 10.5)', 'FontWeight', 'bold', 'Color', 'r')
text(4.2,.8, '+ stripe fix trigger  (N = 7)', 'FontWeight', 'bold', 'Color', 'k')


cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/09152013/')
export_fig('fix_vs_no_thermal_maze_summary')
