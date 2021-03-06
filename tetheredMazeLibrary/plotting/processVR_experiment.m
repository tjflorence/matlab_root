function processVR_experiment(directory)

cd(directory)
homeDir = pwd;

mkdir('rawFiles')
mkdir('alignment')

%% collect files to move
selectionFiles = dir('pre_*');
rawFiles = dir('*RAW');
temperatureFiles = dir('*_temps');

%% move files to appropriate location
if ~isempty(rawFiles)
    disp('moving RAW files')
    for aa = 1:length(rawFiles)
        fileToMove = [homeDir '/' rawFiles(aa).name]
        toMoveLocation = [homeDir '/rawFiles/' ]
        movefile(fileToMove, toMoveLocation, 'f')
    end
    disp('raw files moved')
else
    disp('no raw files')

end

%% move files to appropriate location
if ~isempty(selectionFiles)
    disp('moving selection files')
    for aa = 1:length(selectionFiles)
        fileToMove = [homeDir '/' selectionFiles(aa).name]
        toMoveLocation = [homeDir '/alignment/' ]
        movefile(fileToMove, toMoveLocation, 'f')
    end
    disp('selection files moved')
else('no selection files')

end



%% now that files are moved, begin plotting
plotExperimentSummary_tenTrials(homeDir)


addVarStats_tetheredMaze_prePhases(directory)


try
        plotAlignmentTrials(homeDir)
catch
end

if ~isempty(temperatureFiles)
    plotTrialTemp(homeDir)
end