tenTrials(1).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-05-31/20133105152444_stimulusTest';
tenTrials(2).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-05-31/20133105165448_stimulusTest';
tenTrials(3).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-02/20130206144213_stimulusTest';
%tenTrials(4).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-02/20130206154129_stimulusTest';

shapeTrials(1).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-03/20130306174226_stimulusTest';
shapeTrials(2).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-03/20130306132313_stimulusTest';
shapeTrials(3).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-03/20130306103143_stimulusTest';


eighteenTrials(1).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-04/20130406085816_stimulusTest';
eighteenTrials(2).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-04/20130406124628_stimulusTest';
eighteenTrials(3).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-04/20130406145503_stimulusTest';
eighteenTrials(4).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-04/20130406154220_stimulusTest';
eighteenTrials(5).directory = '/Volumes/flyplacememory/TJ/VR_Maze_Experiment_Data/temperaturePreference/2013-06-04/20130406162338_stimulusTest';


%%simple plots
for aa = 2:length(tenTrials)
    
    simplePlotTetheredMaze(tenTrials(aa).directory)
    
end

%%simple plots
for aa = 1:length(shapeTrials)
    
    simplePlotTetheredMaze(shapeTrials(aa).directory)
    
end

%%simple plots
for aa = 1:length(eighteenTrials)
    
    simplePlotTetheredMaze(eighteenTrials(aa).directory)
    
end