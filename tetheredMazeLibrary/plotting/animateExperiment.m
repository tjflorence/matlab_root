cd(directory)

mkdir('video_frames')

currentDir = pwd;

trainingFiles = dir('env*');
testFiles = dir('TEST*');

numTrainingFiles = length(trainingFiles);
numTestingFiles = length(testFiles);

stickLength = 10

cd('video_frames')


for aa = 1:numTrainingFiles
    f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.1 .1 .5 .3])

    load([currentDir '/' trainingFiles(aa).name])
    
    s1 = subplot(3,3,[1:2 4:5]);
    drawArena2(900, 900, 900,  1.5, data.pattern)
    hold on
    imagesc(data.tempEnv)
    hold on
    drawArena2(900, 900, 900,  1.5, data.pattern)

    %% plot previous trajectories
    if aa > 1
        
        for bb = 1:aa
            
            load([currentDir '/' trainingFiles(bb).name])
            hold on
            
            plot(data.Xpos(1:data.count), data.Ypos(1:data.count), 'LineWidth', 3, 'Color', [.7 .7 .7])
            
        end
        
    end
    
    %% this animates current trajectory with ball and stick
    load([currentDir '/' trainingFiles(aa).name])
    
    cMap = jet(256);
    diffMat = ones(size(cMap));
    diffMat = diffMat-cMap;
    diffMat = diffMat./2;
    
    onesMat = ones(size(cMap));
    cMap    = onesMat-diffMat;
    
    
    for aa = 1:10:data.count
        x2 = -50*cos(data.flyTheta(aa));
        y2 = -50*sin(data.flyTheta(aa));

        x2 = x2+data.Xpos(aa);
        y2 = y2+data.Ypos(aa);
    
        x1 = data.Xpos(aa);
        y1 = data.Ypos(aa);
    
        imagesc(data.tempEnv)
        set(gca, 'YDir', 'normal')
        colormap(cMap)
        
        
        hold on
        plot(data.Xpos(1:aa), data.Ypos(1:aa), 'Color', 'k', 'LineWidth', 2)
        plot([x1 x2], [y1 y2], 'LineWidth', 2, 'Color', 'k')
        z1 = scatter(x1,y1, 50);
        set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'k')
        hold off
        xlim([0 1800])
        ylim([0 1800])
        axis equal off
        drawnow
        pause(.01)
    end
    
    
   
    s2 = subplot(3,3,[3]);
    drawArena2(900, 900, 900,  2.5, data.pattern)
    hold on
    imagesc(data.tempEnv)
    outFrame = 
    hold on
    drawArena2(900, 900, 900,  2.5, data.pattern)
    
    s2 = subplot(3,3,[6])
    
end