function makeTetheredSummaryMatrix(inputPaths, correctCondition)

numExperiments = length(inputPaths);

%% first, we need test0 data, summary data, etc
for aa = 1:numExperiments
    cd(inputPaths(aa).path)

    infoFile = dir('*info*');
    load(infoFile.name)

    preTestFiles = dir('*TEST00*');
    summaryDataFile = dir('summaryData.mat');
    load(summaryDataFile.name)
    summaryData.pretestOutcome = nan(1,4);
    
    for bb = 1:length(preTestFiles)
        load(preTestFiles(bb).name)
   
        lastLaser = info.checkEnv(data.Ypos(data.count), data.Xpos(data.count));
   
        if lastLaser < 1.1
            if data.Ypos(data.count) < 900
                summaryData.pretestOutcome(bb) = 3;
            else
                summaryData.pretestOutcome(bb) = 2;
            end
        
        else
            summaryData.pretestOutcome(bb) = 4; 
        end
   
    end
    
    save('summaryData.mat')
end

      

%% experiment flies
insertVec = 7*ones(numExperiments,54);

for aa = 1:numExperiments
    cd(inputPaths(aa).path)

    load('summaryData.mat')

    insertVec(aa,1:4)      = summaryData.pretestOutcome;               
    insertVec(aa,6:25)     = summaryData.outcomeVec(1:20);
    insertVec(aa,27:30)    = summaryData.outcomeVec(21:24);
    insertVec(aa,32:41)    = summaryData.outcomeVec(25:34);
    insertVec(aa,43:46)    = summaryData.outcomeVec(35:38);
    
end

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .9 .9])

imagesc(insertVec)
caxis([0 6])
axis equal off

if correctCondition == 0
    cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 0 0; ...dark orange
        210 210 210; ...dark blue
        190 0 0
        100 100 100];% light orange
        
elseif correctCondition == 1

    cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 0 0; ...dark orange
        210 210 210; ...dark blue
        190 0 0
        100 100 100]; %light orange
else

cMap = [255 255 255; ...
            150 150 150; ...
        150 150 150; ...
        255 0 0; ...dark orange
        210 210 210; ...dark blue
        190 0 0
        100 100 100];% light orange
    
    
end
 
 cMap = cMap./255;
 colormap(cMap)
    hold on
    
z1 = scatter(44,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(45,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)

z1 = scatter(44,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(45,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)
text(45.5, 2.5, 'found target / chose left')
text(45.5, 3.5, 'missed target / chose right')

z1 = scatter(45,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(45.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(21.5,0, 'test 1')
text(26.5, 0, 'train 11-20')
text(37.5, 0, 'test 2')

for aa = 1:lnumExperiments
    text(-1, aa, ['fly ' num2str(aa)])
end

for aa = 1:lnumExperiments
   
    yval = aa+.5

    plot([0 41.5], [yval yval], 'Color', 'k')
end
text(-2, 13, 'left lane cool', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/02122014/')
export_fig('summry')
