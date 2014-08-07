function plotAlignmentTrials_angleHist(directory)
%% plots alignment trials, if they exist

cd(directory)

%try
%    cd('alignment')
%catch err
%    disp('no "pre_selection" folder. run "processVR_experiment.m first" ')
%    mkdir('alignment')
%    cd('alignment')
%end

alignmentTrialsToPlot = dir('pre_selection*');
numFiles = length(alignmentTrialsToPlot);

for aa = 1:numFiles

    load(alignmentTrialsToPlot(aa).name)
    f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .6 .3]);
    
    s1 = subplot(2,4,[1:2, 5:6])
    sizePlot = get(s1, 'Position')
  %  set(s1, 'Position', [sizePlot(1)-.1 sizePlot(2) sizePlot(3) sizePlot(4)])
    
    hold on
    radius = length(data.tempEnv)/2;
    
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',7)
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'g',5)
    hold on
    plot_arc(-.0833*pi, .0833*pi,radius,radius,radius,5,'k');
    plot(data.Xpos(1:data.count), data.Ypos(1:data.count),'k', 'LineWidth', 3)
    axis equal off
    title('arena (8 in. diameter)', 'interpreter', 'none')

    
    s2 = subplot(2,4,3:4)
    sizePlot = get(s2, 'Position')
    box off
   % set(s2, 'Position', [sizePlot(1)-.12 sizePlot(2)+.15 sizePlot(3)+.2 sizePlot(4)-.4])
    
    %theta  = linspace(0,2*pi,100);
    %r      = sin(2*theta) .* cos(2*theta);
    %r_max  = 1;
    %h_fake = rose(theta,r_max*ones(size(theta)));
    %hold on;
    %set(h_fake, 'Visible', 'Off');


    
    
    rotatedValues = mod(data.flyTheta(1:data.count)+pi, 2*pi);
    plot(data.timeStamp(1:data.count),rotatedValues-pi, 'Color', 'k', 'LineWidth',2)
    ylim([-3.14 3.14])
    set(gca, 'YTick', [-pi -pi/2 0 pi/2 pi], 'YTickLabel', {'-pi' '-pi/2' '0' 'pi/2' 'pi'})
    ylabel('theta')
    xlabel('time (sec)')
    xlim([0 60])
    title('theta vs. time')
    box off
    
    s3 = subplot(2,4,7:8)
    box off
    
    deltaTheta = zeros(1,data.count);

    [n,xout] = histc(rotatedValues-pi, linspace(-pi,pi, 41))
    n = n/data.count;
    area(linspace(-pi,pi, 41),n,'LineWidth', 2, 'EdgeColor', 'k', 'FaceColor', [.7 .7 .7])
    xlim([-pi pi])
    xlabel('theta')
    ylabel('normalized counts')
    title('orientation histogram')
    box off
    
    export_fig(['plot_' alignmentTrialsToPlot(aa).name(1:end-4)], '-pdf')
    
end

close all

