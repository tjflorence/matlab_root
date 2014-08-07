function plotPreTest(directory)

ironCMAP = [
            255 237 160;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            177 0 38];
ironCMAP = (ironCMAP./255);

    
%% step 1: go to file directory, collect file names
    cd(directory)
    homeDir = pwd;
    
    infoFile = dir('*info*');
    load(infoFile.name)
    
    lastInd = strfind(infoFile.name, '-info_file.mat');
    strName = infoFile.name(1:lastInd-1)
    
    
    try
        rawFiles = dir('*RAW*');
        delete(rawFiles.name)
    catch
        disp('no raw files') 
    end


    % collect file names
    pretestFiles   = dir('*TEST00*');
    
    % determine the maximum number of env repetitions for the set of envs
%    numVec = [num_env1 num_env2 num_env3 num_env4 num_env5 num_env6];
%    maxTrialNum = max(numVec);
    
    % ready folder for printing fig
    mkdir('experiment_summary')
    cd('experiment_summary')
    printDir = pwd;
    
    
    f1 = figure('Color', 'w', 'Units', 'normalized','Position', [.01 .01 .7 .7]);
    

    %% trials 1-5     
    for aa = 1:4
        cd(homeDir)
       
        h1 = subplot(3,5, aa ); 
        load(pretestFiles(aa).name)
        imagesc(flipud(data.tempEnv))
        maxVal = max(max(data.tempEnv));
        minVal = min(min(data.tempEnv));
        caxis([minVal maxVal])
        
        colormap(ironCMAP)
        alpha(.35)
       
      %  alpha(.5)
        hold on
        plot(data.Xpos, 1800-data.Ypos, 'Color', 'w', 'LineWidth', 3);
        plot(data.Xpos, 1800-data.Ypos, 'Color', 'k', 'LineWidth', 2.5);
        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off   
       
        if aa == 1
            
           text(-1100, 1200, 'pretest ', 'FontSize', 20, 'Rotation', 90)

        end        
    end 
    
    annotation('line', [.15 .9], [1-0.33 1-0.33] , 'Color', [0 0 0], 'LineWidth', 2)
   % drawnow
    


    annotation('textbox', [.1 .9 .1 .1], 'String', strName, 'interpreter', 'none', 'EdgeColor', [1 1 1], 'FontSize', 15); 
    
    cd(printDir)
    export_fig('pretest_trials', '-png')    
end