function summaryOut = collectExpLevelVars(struct)
%% struct is a structure containing path entries
% out is a structure containing individual entries

numExps = length(struct);



%% first collect fraction hot
fracHot = nan(numExps, 24);

    for aa = 1:numExps
        cd(struct(aa).path)
        
        trialFiles = dir('env*');
        numTrials = length(trialFiles);
        
        for bb = 1:numTrials
           load(trialFiles(bb).name)
           fracHot(aa,bb) = data.fractTimeHot;
            
        end
        
        
    end
summaryOut.fracHot = fracHot;






end