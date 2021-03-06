function plotTrialTemp(directory)
%% plots alignment trials, if they exist


color1 = [255 237 160];
color2 = [240 59  32];


R = linspace(color1(1), color2(1), 256);
G = linspace(color1(2), color2(2), 256);
B = linspace(color1(3), color2(3), 256);


cMAP = ([R' G' B']./255);

cd(directory)
tempDir = dir('*_temps');
trajectoryFiles = dir('env*');

try
    cd(tempDir.name)
catch err
    disp('no temperature directory. did you copy over files? ')
end

tempFilesToPlot = dir('trial_*');
numFiles = length(tempFilesToPlot);

for aa = 1:numFiles
    load([directory '/' trajectoryFiles(aa).name])
    load(tempFilesToPlot(aa).name)
    
    numTrialSamples = data.count;
    numTempSamples = tempData.count;
 
    trialToTempCF = numTempSamples/numTrialSamples;
    data.tempAtThatTime = zeros(1,data.count);
    for bb = 1:data.count
        roundedIdx = ceil(bb*trialToTempCF);
        if roundedIdx > numTempSamples
            roundedIdx = numTempSamples;
        end
        data.tempAtThatTime(bb) = tempData.temps(roundedIdx);
    end
    
    f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .6 .3]);
    
    s1 = subplot(1,4,1)
    set(s1, 'Position', [.05 .05 .25 .8150])
    hold on
    radius = length(data.tempEnv)/2;
    imagesc(data.tempEnv)
    hold on
    set(gca,'YDir', 'normal')
    colormap(gray)
    alpha(.35)
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',7)
    axis equal off
    freezeColors
    
    p1 = cline(data.Xpos(1:data.count), data.Ypos(1:data.count), data.tempAtThatTime)
    map3=pmkmp(256);
    colormap(map3);
    %colormap(cMAP)
    set(p1, 'LineWidth',5)
    caxis([25 45])
    c1 = colorbar('YTick', [25 35 45], 'YTickLabel', {'25�C    ', '35�C    ', '45�C    '})
    set(get(c1,'Ylabel'), 'String', ['temperature'], 'Rotation', [270])
    initpos = get(c1,'Position');
    set(c1, ...
   'Position',[initpos(1)+.04 initpos(2)+initpos(4)*0.25 ...
      initpos(3)*0.5 initpos(4)*0.5])
    

    title(['temperature plot ' trajectoryFiles(aa).name(1:end-4)], 'interpreter', 'none')

    
    s2 = subplot(1,4,2:4)
    pos2 = get(s2, 'Position')
    set(s2, 'Position', [pos2(1)+.05 pos2(2)+.05 pos2(3)-.05 pos2(4)-.20])
    
    plot(data.timeStamp(1:data.count), data.setTemps(1:data.count), 'LineWidth', 3, 'Color', 'k')
    hold on
    plot(tempData.timeStamp(1:tempData.count), tempData.temps(1:tempData.count), 'LineWidth', 3, 'Color', 'r')

    ylim([20 50])
    ylabel('temperature (�C)')
    xlim([0 120])
    xlabel('time (sec)')
    box off
    axis on
    
    text(5, 48, 'Set Temperature', 'Color', 'k', 'FontWeight', 'Bold')
    text(5, 47, 'Actual Temperature', 'Color', 'r', 'FontWeight', 'Bold')

    plot([0 0], [20 50], 'Color', 'k')
    plot([0 300], [0 0], 'Color', 'k')
    export_fig(['temperature_plot_' trajectoryFiles(aa).name(1:end-4)], '-png')
    
    close all
    
end

