%% make example for cosyne poster sesh
flyID(1).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-10-31/20133110105939_stimulusTest';
flyID(1).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-10-31/20133110113049_stimulusTest';

flyID(2).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-01/20130111140023_stimulusTest';
flyID(2).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-01/20130111145325_stimulusTest';

flyID(3).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111162019_stimulusTest';
flyID(3).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111164342_stimulusTest';

flyID(4).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111180828_stimulusTest';
flyID(4).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111182835_stimulusTest';

flyID(5).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111203329_stimulusTest';
flyID(5).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111205822_stimulusTest';

flyID(6).tr1 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111221225_stimulusTest';
flyID(6).tr2 = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-11-11/20131111223738_stimulusTest';



f1              = figure('Color','w', 'units', 'normalized', 'Position', [.1 .1 .9 .9])
blueColor       = rgbconv('ABF8FF');
orangeColor     = rgbconv('FFA954');
yellowColor     = rgbconv('FFE4A9');
yellowColor2    = rgbconv('FFD981')
redColor        = rgbconv('FFACA9');
redColor2       = rgbconv('FE8184')
whiteColor      = [1 1 1];


backgroundCMAP  = [ blueColor; yellowColor; yellowColor; yellowColor2; redColor; redColor2; redColor2; whiteColor];
flyColors       = cool(6);

cd(flyID(1).tr1)
infoFile = dir('*info*');
load(infoFile.name)


%% check out trial 1
f1 = figure('Color', 'w')

    
    cd(flyID(1).tr1)
    expFiles = dir('env6*');
    load(expFiles(1).name)
    
        
        tempBG = data.tempEnv;
        
        for xx = 1:1800
            for yy = 1:1800
                
                if sqrt( (xx-900)^2 + (yy-900)^2 ) > 910
                    
                    tempBG(xx,yy) = 8;
                    
                end
                
                
            end
        end
        
        image(tempBG)
        
        set(gca, 'YDir', 'normal')
        axis equal off
        hold on
        colormap(backgroundCMAP)
        caxis([1 6])

    
  %  plot(data.Xpos(1:data.count), data.Ypos(1:data.count), 'LineWidth', 5, 'Color', 'k')
  %  plot(data.Xpos(1:data.count), data.Ypos(1:data.count), 'LineWidth', 2, 'Color', flyColors(aa,:))

[~,~]=circle([900 900],900,1000,'k',10)
axis equal




cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02192014/')
export_fig('test_arena', '-pdf', '-painters')
%