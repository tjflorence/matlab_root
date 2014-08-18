function plotExperimentSummary_15trials(directory)


ironCMAP = [46 255 224;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            227 26 28;...
            227 26 28;...n
            227 26 28;...
            177 0 38; ...
            255 255 255];
ironCMAP = (ironCMAP./255);



% ironCMAP = [46 255 224;...
%             255 237 160;...
%             254 217 118;...
%             254 178 76;...
%             227 26 28;...
%             227 26 28;...
%             227 26 28;...
%             177 0 38; ...
%             255 255 255];
% ironCMAP = (ironCMAP./255);

    
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
    trialDataFiles  = dir('*trial*');
    pretestData   = dir('*TEST00*');
    posttestData   = dir('*TESTA*');
    
    % determine the maximum number of env repetitions for the set of envs
%    numVec = [num_env1 num_env2 num_env3 num_env4 num_env5 num_env6];
%    maxTrialNum = max(numVec);
    
    % ready folder for printing fig
    mkdir('experiment_summary')
    cd('experiment_summary')
    printDir = pwd;
    
    
    f1 = figure('Color', 'w', 'Units', 'normalized','Position', [.01 .01 .7 .7]);
    

    %% pretest trajectories     
    for aa = 1:4
        cd(homeDir)
       
        h1 = subplot(3,5, aa ); 
        load(pretestData(aa).name)
        imagesc(flipud(data.tempEnv))
        maxVal = max(max(data.tempEnv));
        minVal = min(min(data.tempEnv));
        caxis([minVal maxVal])
        
        colormap(ironCMAP)
        alpha(.35)
       
      %  alpha(.5)
        hold on
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 2)

        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off   
       
        if aa == 1
            
           text(-1100, 1200, 'pretest ', 'FontSize', 20, 'Rotation', 90)

        end        
    end 
    
    %% trials 1-5     
    for aa = 6:10
        cd(homeDir)
        
        training_num = aa-5;
       
        h1 = subplot(3,5, aa ); 
        load(trialDataFiles(training_num).name)
        imagesc(flipud(data.tempEnv))
        maxVal = max(max(data.tempEnv));
        minVal = min(min(data.tempEnv));
        caxis([minVal maxVal])
        
        colormap(ironCMAP)
        alpha(.35)
       
      %  alpha(.5)
        hold on
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 2)

        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off   
       
        if aa == 1
            
           text(-1100, 1200, '1 to 5 ', 'FontSize', 20, 'Rotation', 90)

        end        
    end 
    
    annotation('line', [.15 .9], [1-0.33 1-0.33] , 'Color', [0 0 0], 'LineWidth', 2)
   % drawnow
    

    
    %% trials 6-10
    for aa = 11:15
        cd(homeDir)
       
        training_num = aa-5;
        
        h1 = subplot(3,5, aa ); 
        load(trialDataFiles(aa).name)
        
        imagesc(flipud(data.tempEnv))
        caxis([minVal maxVal])
        colormap(ironCMAP)
        alpha(.35)
        hold on
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 2)

        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off
        
       if aa == 11
            
            

           text(-1100, 1200, '6 to 10 ', 'FontSize', 20, 'Rotation', 90)
           
 

        end
    end
    
    annotation('line', [.15 .9], [1-0.915 1-0.915] , 'Color', [0 0 0], 'LineWidth', 2)
    drawnow

    annotation('textbox', [.1 .9 .1 .1], 'String', strName, 'interpreter', 'none', 'EdgeColor', [1 1 1], 'FontSize', 15); 
    
    cd(printDir)
    export_fig('experiment_summary_1', '-png')
    
 %% next 16-20 trials   
    close all
    f1 = figure('Color', 'w', 'Units', 'normalized','Position', [.01 .01 .7 .7]);
    

    for aa = 16:20
        cd(homeDir)
        
        training_num = aa-5;
       
        h1 = subplot(3,5, aa-15 ); 
        load(trialDataFiles(training_num).name)
        imagesc(flipud(data.tempEnv))
        maxVal = max(max(data.tempEnv));
        minVal = min(min(data.tempEnv));
        caxis([minVal maxVal])
        
        colormap(ironCMAP)
        alpha(.35)
       
      %  alpha(.5)
        hold on
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 2)

        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off   
       
        if aa == 16
            
           text(-1100, 1200, '11 to 15 ', 'FontSize', 20, 'Rotation', 90)

        end        
    end 
    
    annotation('line', [.15 .9], [1-0.33 1-0.33] , 'Color', [0 0 0], 'LineWidth', 2)
   % drawnow
    
 %% test trials 1-4     
    for aa = 1:4
        cd(homeDir)
       
        h1 = subplot(3,5, aa + 5 ); 
        load(posttestData(aa).name)
        
        imagesc(flipud(data.tempEnv))
        caxis([minVal maxVal])
        colormap(ironCMAP)
        alpha(.35)
        hold on
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 2)

        circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',5)
        axis equal off
        
        if aa == 1
            
           text(-1100, 1200, 'post test', 'FontSize', 20, 'Rotation', 90)

        end
        
    end 
    
    annotation('line', [.15 .9], [1-0.64 1-0.64] , 'Color', [0 0 0], 'LineWidth', 2)
   % drawnow
     
    

    cd(printDir)
    export_fig('experiment_summary_2', '-png')
    
    close all
end