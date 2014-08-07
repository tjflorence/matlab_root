%% right go
rightGo(13).tr1 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111221225_stimulusTest';
rightGo(13).tr2 = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-11/20131111223738_stimulusTest';

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013/learningPat.mat')

cd(rightGo(13).tr1)
expTrials = dir('env*')

trialNum = 13
        
load(expTrials(trialNum).name)

ironCMAP = [
            46 255 224;...
            255 237 160;...
            255 237 160;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            255 255 255];
        ironCMAP = (ironCMAP./255);
     %   set(gca, 'FaceAlpha', .5 )
     %   ironCMAP = ironCMAP/2;
        
        tempEnvInsert = data.tempEnv;
        for xx = 1:1800
            for yy = 1:1800
            
                if sqrt(((900-xx)^2) + ((900-yy)^2)) > 905
                    tempEnvInsert(yy,xx) = 8;
                end
            
            end
        end
        tempEnv = 8*ones([2400 2400]);
        tempEnv(301:2100,301:2100) = tempEnvInsert;
  
        f1 = figure('color', 'w')
    
        imagesc((tempEnv))
        set(gca, 'YDir', 'normal')
        colormap(ironCMAP)
        caxis([1 8])
        axis equal off
        
        hold on
        
        drawArena3(1200, 1200, 900,  1.2, learningPat*7, 3, 0)


        cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013/')
        export_fig(['arena_fig_' num2str(trialNum)])
        
        close all