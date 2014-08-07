function plotMultiExperimentSummary(dirStruct, printDir, figName)


numExps = length(dirStruct);

distTraveled = nan(numExps, 11);
z2_speed = nan(numExps, 11);
fracz_z2 = nan(numExps, 11);
transSucP  = nan(numExps, 11);

homeDir = pwd;

%% collect data to plot
for aa = 1:length(dirStruct)

    cd(dirStruct(aa).directory)
    dataFiles = dir('mazeTrial*');
    
    for bb = 1:11
    
        load(dataFiles(bb).name)
        
        distTraveled(aa,bb) = data.totalDistMoved;
        z2_speed(aa,bb)     = data.meanSpeed_z2;
        fracz_z2(aa,bb)     = data.fracTimeInT2;
        transSucP(aa,bb)    = data.transitionSuccessProbability;
            

        
    end
    
end


cd(printDir)

f1 = figure('Color','w','Units', 'normalized', 'Position', [.1 .1 .5 .7])
%% subplot 1: cumuluative distance traveled
    h1 = subplot(4,1,1)
    for aa = 1:length(dirStruct)
       for bb = 1:11
           x_jitter  = .08*randn(1,1);
           z1 = scatter(bb+x_jitter, distTraveled(aa,bb),200);
           set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[.5 .5 .5],'LineWidth',3)
           hold on
       end
    end
    
    meanDistTraveled = nanmean(distTraveled);
    z2 = scatter(1:1:11,meanDistTraveled, 200)
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'LineWidth',3)
    plot(meanDistTraveled, 'Color','r', 'LineWidth', 2)
    xlim([.5 11.5])
    ylim([0 12000])
    xlabel('trial')
    ylabel('distance (mm)')
    
    title('total distance walked', 'FontSize', 15)
    

%% subplot 2: z2 speed
h2 = subplot(4,1,2)
   for aa = 1:length(dirStruct)
       for bb = 1:11
           x_jitter  = .08*randn(1,1);
           z1 = scatter(bb+x_jitter, z2_speed(aa,bb),200);
           set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[.5 .5 .5],'LineWidth',3)
           hold on
       end
    end
    
    mean_z2_speed = nanmean(z2_speed);
    z2 = scatter(1:1:11,mean_z2_speed, 200)
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'LineWidth',3)
    plot(mean_z2_speed, 'Color','r', 'LineWidth', 2)
    xlim([.5 11.5])
    ylim([0 30])
    xlabel('trial')
    ylabel('speed (mm/sec)')

    title('mean speed', 'FontSize', 15)

%% subplot 3: fraction in z3    
h3 = subplot(4,1,3)
   for aa = 1:length(dirStruct)
       for bb = 1:11
           x_jitter  = .08*randn(1,1);
           z1 = scatter(bb+x_jitter, fracz_z2(aa,bb),200);
           set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[.5 .5 .5],'LineWidth',3)
           hold on
       end
    end
    
    mean_fracZ2Speed = nanmean(fracz_z2);
    z2 = scatter(1:1:11,mean_fracZ2Speed, 200)
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'LineWidth',3)
    plot(mean_fracZ2Speed, 'Color','r', 'LineWidth', 2)
    xlim([.5 11.5])
    ylim([0 1])
    xlabel('trial')
    ylabel('fraction in z2')
    
    title('fraction in z2', 'FontSize', 15)

    
%% subplot 4: fraction     
h4 = subplot(4,1,4)
   for aa = 1:length(dirStruct)
       for bb = 1:11
           x_jitter  = .08*randn(1,1);
           z1 = scatter(bb+x_jitter, transSucP(aa,bb),200);
           set(z1, 'MarkerEdgeColor','k','MarkerFaceColor',[.5 .5 .5],'LineWidth',3)
           hold on
       end
    end
    
    mean_transSucP = nanmean(transSucP);
    z2 = scatter(1:1:11,mean_transSucP, 200)
    set(z2, 'MarkerEdgeColor','k','MarkerFaceColor',[1 0 0],'LineWidth',3)
    plot(mean_transSucP, 'Color','r', 'LineWidth', 2)
    xlim([.5 11.5])
    ylim([0 1])
    xlabel('trial')
    ylabel('transition success probability')
    
    title('transition success', 'FontSize', 15)

    
    cd(printDir)
    export_fig(figName)
    
    close all