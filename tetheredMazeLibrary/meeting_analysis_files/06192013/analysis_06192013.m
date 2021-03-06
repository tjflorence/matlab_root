eighthInch(1).path = '/Users/tj_florence/Desktop/data/2013-06-19/20131906121950_stimulusTest/';
eighthInch(2).path = '/Users/tj_florence/Desktop/data/2013-06-19/20131906101821_stimulusTest/';
eighthInch(3).path = '/Users/tj_florence/Desktop/data/2013-06-18/20131806175036_stimulusTest/';

sixthInch(1).path = '/Users/tj_florence/Desktop/data/2013-06-20/20132006082748_stimulusTest/';
%sixthInch(2).path = '/Users/tj_florence/Desktop/data/2013-06-19/20131906180036_stimulusTest/';
sixthInch(2).path = '/Users/tj_florence/Desktop/data/2013-06-19/20131906162523_stimulusTest/';
sixthInch(3).path = '/Users/tj_florence/Desktop/data/2013-06-19/20131906140344_stimulusTest/';

gradStart(1).path = '/Users/tj_florence/Desktop/data/2013-06-20/20132006101354_stimulusTest/';
gradStart(2).path = '/Users/tj_florence/Desktop/data/2013-06-20/20132006115032_stimulusTest/';
gradStart(3).path = '/Users/tj_florence/Desktop/data/2013-06-20/20132006154021_stimulusTest/';

%for aa = 1

 %   addVarStats_tetheredMaze(eighthInch(aa).path)
 %   simplePlotTetheredMaze(eighthInch(aa).path)
 %   plotTrialSummary_tetheredMaze(eighthInch(aa).path)
 %   plotExperimentSummary(eighthInch(aa).path)
    
%end

for aa = 1:4

    addVarStats_tetheredMaze(sixthInch(aa).path)
    simplePlotTetheredMaze(sixthInch(aa).path)
    plotTrialSummary_tetheredMaze(sixthInch(aa).path)
    plotExperimentSummary(sixthInch(aa).path)
    
end

for aa = 1:2

    addVarStats_tetheredMaze(gradStart(aa).path)
    simplePlotTetheredMaze(gradStart(aa).path)
    plotTrialSummary_tetheredMaze(gradStart(aa).path)
    plotExperimentSummary(gradStart(aa).path)
    
end

for aa = 1

    addVarStats_tetheredMaze(allGrad(aa).path)
    simplePlotTetheredMaze(allGrad(aa).path)
    plotTrialSummary_tetheredMaze(allGrad(aa).path)
    plotExperimentSummary(allGrad(aa).path)
    
end


eightIn_summary = collectExpLevelVars(eighthInch);
sixIn_summary = collectExpLevelVars(sixthInch);
gradStart_summary = collectExpLevelVars(gradStart);
allGrad_summary = collectExpLevelVars(allGrad);



gradStart_mean = nanmean(gradStart_summary.fracHot);
eigthIn_mean = nanmean(eightIn_summary.fracHot);
sixIn_mean = nanmean(sixIn_summary.fracHot);

xVec = 1:1:24;

f1 = figure('Color','w', 'units', 'normalized', 'Position', [.1 .1 .7 .4])
hold on
plot(xVec-.1, gradStart_mean, 'Color', 'k', 'LineWidth', 3)
plot(eigthIn_mean, 'Color', 'b', 'LineWidth', 3)
plot(xVec+.1, sixIn_mean, 'Color', 'r', 'LineWidth', 3)

for aa = 1:3
   z1 = scatter(xVec-.1, gradStart_summary.fracHot(aa,:),50)
   set(z1, 'MarkerFaceColor', [0 0 0], 'MarkerEdgeColor', [0 0 0])
   
   z2 = scatter(xVec, eightIn_summary.fracHot(aa,:),50)
   set(z2, 'MarkerFaceColor', [0 0 1],'MarkerEdgeColor', [0 0 1])
   
   z3 = scatter(xVec, sixIn_summary.fracHot(aa,:),50)
   set(z3, 'MarkerFaceColor', [1 0 0], 'MarkerEdgeColor', [1 0 0])   
end

ylim([0 1])
xlim([.5 24.5])


text(24.5, gradStart_mean(end), 'gradient env', 'Color', 'k', 'FontSize', 10)
text(24.5, eigthIn_mean(end), '4/5 in. lane', 'Color', 'b', 'FontSize', 10)
text(24.5, sixIn_mean(end), '3/5 in. lane', 'Color', 'r', 'FontSize', 10)

plot([4.5 4.5], [0 1], 'k:', 'LineWidth', 3)
plot([8.5 8.5], [0 1], 'k:', 'LineWidth', 3)
plot([12.5 12.5], [0 1], 'k:', 'LineWidth', 3)
plot([16.5 16.5], [0 1], 'k:', 'LineWidth', 3)
plot([20.5 20.5], [0 1], 'k:', 'LineWidth', 3)

text(1, .95, 'distance 1', 'FontSize', 13)
text(5, .95, 'distance 2', 'FontSize', 13)
text(9, .95, 'distance 3', 'FontSize', 13)
text(13, .95, 'distance 4', 'FontSize', 13)
text(17, .95, 'distance 5', 'FontSize', 13)
text(21, .95, 'test', 'FontSize', 13)

ylabel('fraction of trial outside lane', 'FontSize', 17)
xlabel('trial number', 'FontSize', 17)

title('Fraction Outside Lane', 'FontSize', 20)

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/06192013/')
export_fig('frac_out_different_envs', '-pdf')