function simplePlotTetheredMaze(directory)
%% this function will produce simple plots quickly
% for easy, immediate review of experiments

cd(directory)
homeDir = pwd;

try
    rawFiles = dir('*RAW*');
    delete(rawFiles.name)
catch
    disp('no raw files') 
end

% make simple plot dir
mkdir('simple_plots')
cd('simple_plots')

simplePlotDir = pwd;

cd(homeDir)
filesToPlot = dir('env*');
testFile = dir('TESTA*');
pretestFile = dir('TEST00*');



ironCMAP = [46 255 224;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            227 26 28;...
            227 26 28;...
            227 26 28;...
            177 0 38; ...
            255 255 255];
ironCMAP = (ironCMAP./255);

% ironCMAP = [46 255 224;...
%             255 237 160;...
%             254 217 118;...
%             254 178 76;...
%             253 141 60;...
%             252 78  42;...
%             227 26 28;...
%             177 0 38; ...
%             255 255 255];
% ironCMAP = (ironCMAP./255);



% plot trial files
for aa = 1:length(filesToPlot)
    
    cd(homeDir)
    load(filesToPlot(aa).name)
    f1 = figure('Color', 'w', 'Units', 'normalized', 'Position', [.1 .1 .5 .7]);
    
    for xx = 1:1800
        for yy = 1:1800
        
        if sqrt( (xx-900)^2 + (yy-900)^2 ) > 900
            data.tempEnv(yy,xx) = 7;
        end
    end
    end
    
    imagesc(data.tempEnv)
    colormap(ironCMAP)
    set(gca,'YDir','normal')
    hold on
 
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
    
    
    s1 = scatter(data.Xpos(find(data.trial_state==4, 1,'first')), data.Ypos(find(data.trial_state==4, 1,'first')), 200)
    set(s1, 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k')
    
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
   % drawArena(900, 900, 900, data.pattern)
    
    axis equal off
    
    title([filesToPlot(aa).name], 'interpreter', 'none', 'FontSize',20)
    
    cd(simplePlotDir)
    export_fig(['simple_plot_' filesToPlot(aa).name])
    
    close all
end

% plot test files
for aa = 1:length(testFile)
    
    cd(homeDir)
    load(testFile(aa).name)

    f1 = figure('Color', 'w', 'Units', 'normalized', 'Position', [.1 .1 .5 .7]);
    
        for xx = 1:1800
        for yy = 1:1800
        
        if sqrt( (xx-900)^2 + (yy-900)^2 ) > 900
            data.tempEnv(yy,xx) = 7;
        end
        end
        end
        
    imagesc(data.tempEnv)
    colormap(ironCMAP)
    set(gca,'YDir','normal')

    hold on
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
        
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
   %     drawArena(900, 900, 900, data.pattern)

       s1 = scatter(data.Xpos(find(data.trial_state==4, 1,'first')), data.Ypos(find(data.trial_state==4, 1,'first')), 200)
    set(s1, 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k')
    
    
    axis equal off
    
    title([testFile(aa).name], 'interpreter', 'none', 'FontSize', 20)
    
    cd(simplePlotDir)
    export_fig(['simple_plot_' testFile(aa).name])
    
    close all
end

for aa = 1:length(pretestFile)
    
    cd(homeDir)
    load(pretestFile(aa).name)

    f1 = figure('Color', 'w', 'Units', 'normalized', 'Position', [.1 .1 .5 .7]);
    
        for xx = 1:1800
        for yy = 1:1800
        
        if sqrt( (xx-900)^2 + (yy-900)^2 ) > 900
            data.tempEnv(yy,xx) = 7;
        end
        end
        end
    
    imagesc(data.tempEnv)
    colormap(ironCMAP)
    set(gca,'YDir','normal')

    hold on
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
    plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
        
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
   %     drawArena(900, 900, 900, data.pattern)

       s1 = scatter(data.Xpos(find(data.trial_state==4, 1,'first')), data.Ypos(find(data.trial_state==4, 1,'first')), 200)
    set(s1, 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k')
    
    
    axis equal off
    
    title([testFile(aa).name], 'interpreter', 'none', 'FontSize', 20)
    
    cd(simplePlotDir)
    export_fig(['simple_plot_' testFile(aa).name])
    
    close all
end