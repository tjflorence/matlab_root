function plotTrialSummary_tetheredMaze(directory)


    cd(directory)
    homeDir = pwd;
    
    infoFile = dir('*info*');
    load(infoFile.name)
    
 
    try
        rawFiles = dir('*RAW*');
        delete(rawFiles.name)
    catch
        disp('no raw files') 
    end


    trialDataFiles = dir('env*');
    testDataFiles = dir('TEST*');

    delete('trial_summaries')
    mkdir('trial_summaries')
    cd('trial_summaries')
    
    printDir = pwd;
    
for ii = 1:length(trialDataFiles)
    cd(homeDir)
    load(trialDataFiles(ii).name)
        
    
    f1 = figure('Units', 'normalized', 'Position', [.1 .1 .5 .7])

    %% subplot 1: trajectory plot    
    h1 = subplot(6,5, [1:2,6:7])

    
    imagesc(data.tempEnv)
    colormap(gray)
    hold on
    plot(data.Xpos, data.Ypos, 'Color', 'w', 'LineWidth', 5);
    plot(data.Xpos, data.Ypos, 'Color', 'r', 'LineWidth', 2);
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
    axis equal off
    
    title([trialDataFiles(ii).name], 'interpreter', 'none', 'FontSize',20)
    
%% subplot 2: mean walking speed per temperature zone
h2 = subplot(6,5, [3,8])
    z1 = scatter(1,data.meanSpeed_z1,200);    
    set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[0 .5 .5],'LineWidth',3)
    
    hold on
    
    z2 = scatter(2,data.meanSpeed_z2,200);    
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1,1,51/255],'LineWidth',3)
    
    z3 = scatter(3,data.meanSpeed_z3,200);    
    set(z3, 'MarkerEdgeColor','k','MarkerFaceColor',[1,102/255,0],'LineWidth',3)
    
    z4 = scatter(4,data.meanSpeed_edge,200);    
    set(z4, 'MarkerEdgeColor','k','MarkerFaceColor',[1,0,0],'LineWidth',3)
    
    xlim([.5 4.5])
    ylim([0 50])
    
    set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'safe', 'z1', 'z2','edge'})
    xlabel('temperature zone')
    ylabel('walking speed (mm/sec)')
    title('Mean Walking Speed per Zone')

%% subplot 3: fraction of time in each temperature zone
    h3 = subplot(6,5, [4,9])
    z1 = scatter(1,data.fracTimeInT1,200);    
    set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[0 .5 .5],'LineWidth',3)
    
    hold on
    
    z2 = scatter(2,data.fracTimeInT2,200);    
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1,1,51/255],'LineWidth',3)
    
    z3 = scatter(3,data.fracTimeInT3,200);    
    set(z3, 'MarkerEdgeColor','k','MarkerFaceColor',[1,102/255,0],'LineWidth',3)
    
    z4 = scatter(4,data.fracTimeOnEdge,200);    
    set(z4, 'MarkerEdgeColor','k','MarkerFaceColor',[1,0,0],'LineWidth',3)
    
    xlim([.5 4.5])
    ylim([0 1])
    
    set(gca, 'XTick', [1 2 3 4], 'XTickLabel', {'safe', 'z1', 'z2','edge'})
    xlabel('temperature zone')
    ylabel('fraction of trial')
    title('Fraction Spent in Zone')
    
%% subplot 4: straighness
    h4 = subplot(6,5, [5,10])
    
    plot([1 1], [0 data.straightness], 'Color', 'r', 'LineWidth',2)
    hold on
    z2 = scatter(1,data.straightness,200);    
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1,0,0],'LineWidth',3)

    
    xlim([.5 1.5])
    ylim([0 1])
    
    set(gca, 'XTick', [1 2 ], 'XTickLabel', {' ', ' '})
    xlabel('straightness')
    ylabel('straightness (0-1)')
    title(['Trajectory Straightness'] )
    
    
%% subplot 5: walking speed
    h5 = subplot(6,5, [11:15])
    plot(data.timeStamp(1:data.count), data.speed_500ms_sm, 'LineWidth', 2, 'Color', 'k')
    xlim([0 300])
    ylim([0 200])
    
    ylabel('speed (mm/sec)')
    title('Inst Speed')
    
%% subplot 6: instantaneous speed 
    h6 = subplot(6,5,[16:20])
    plot(data.timeStamp(1:data.count), data.laserPower_normalized, 'LineWidth', 2, 'Color', 'r')
    xlim([0 300])
    ylim([0 5])
    
    ylabel('laser power (0-10, au)')
    title('Laser Power')
    
%% subplot 7: culmulative distance moved
    h7 = subplot(6,5, [21:25])
    plot(data.timeStamp(1:data.count), data.cumDistMoved, 'LineWidth', 2, 'Color', 'k')
    xlim([0 300])
    ylim([0 9000])
    
    xlabel('time (s)')
    ylabel('cumulative distance moved (mm)')
    title('cumulative distance moved')

%% subplot 8: edge-aligned speed traces, success    
    h8 = subplot(6,5, [26:27])
    cmap = hsv(length(alignedSpeedTraces));
    for aa = 1:length(alignedSpeedTraces)
        if alignedSpeedTraces(aa).success == 1
        plot( alignedSpeedTraces(aa).speed, 'Color', cmap(aa,:), 'LineWidth', 2)
        hold on
        end
    end
    xlim([0 40])
    ylim([0 150])
    set(gca, 'XTick', [0 20 40], 'XTickLabel', {'-1' '0' '+1'})
    xlabel('time (s)')
    ylabel('speed (mm/sec)')
    plot([20 20], [-300 300], 'k:', 'LineWidth', 2)
    title('edge-aligned speed traces (success)')

%% subplot 9" edge-aligned speed traces, failure
    h9 = subplot(6,5, [29:30])
    for aa = 1:length(alignedSpeedTraces)
        if alignedSpeedTraces(aa).success == 0
        plot( alignedSpeedTraces(aa).speed, 'Color', cmap(aa,:), 'LineWidth', 2)
        hold on
        end
    end
    xlim([0 40])
    ylim([0 150])
    set(gca, 'XTick', [0 20 40], 'XTickLabel', {'-1' '0' '+1'})
    xlabel('time (s)')
    ylabel('speed (mm/sec)')
    plot([20 20], [-300 300], 'k:', 'LineWidth', 2)
    title('edge-aligned speed traces (failure)')
    
    cd(printDir)
    if ii<10
        export_fig(['trial_summary_0' num2str(ii)])
    else
        export_fig(['trial_summary_' num2str(ii)])
    end
    close all
    


end