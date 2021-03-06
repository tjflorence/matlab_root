function makeColorSummaryMatrix(enterMatrix, correctSideCode, plotName, saveDir)
%% pathStruct       = structure of paths, of processed experiments
%% rightSideCode    = 0 or 1; 0--> go left, 1--> go right
%% saveDir          = where to export matrix

f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .9 .9])
%s1 = subplot(3,7,[1:2, 4:5])

%colorSummaryMatrix = [colorSummaryMatrix 6*ones(7,2)]

imagesc(enterMatrix)
caxis([0 6])
axis equal off

numEntries = size(enterMatrix,1);

if correctSideCode == 0

    cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
          1 183 255; ...dark orange
        255 86  1; ...dark blue
        255 145 111;... light orange
        111 255 243];...light blue
else

    cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...dark blue
        1 183 255; ...dark orange
        255 145 111;... light orange
        111 255 243];...light blue
end       
    
    hold on
    
z1 = scatter(33,numEntries+2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(34,numEntries+2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)

z1 = scatter(33,numEntries+3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(34,numEntries+3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)

if correctSideCode == 0
    text(34.5, numEntries+2.5, 'found target / chose left')
    text(34.5, numEntries+3.5, 'missed target / chose right')      
else
    text(34.5, numEntries+2.5, 'found target / chose right')
    text(34.5, numEntries+3.5, 'missed target / chose left')
end

z1 = scatter(33,numEntries+4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(34.5, numEntries+4.5, 'no choice')

text(.5, 0, 'train 1-20')
text(20.5,0, 'test 1')
text(24.5, 0, 'train 21-30')
text(34.5, 0, 'test 2')

for aa = 1:(size(enterMatrix,1))
    text(-1, aa, ['fly ' num2str(aa)])
end

for aa = 1:(size(enterMatrix,1))
   
    yval = aa+.5

    plot([0 38.5], [yval yval], 'Color', 'k')
end

if correctSideCode == 0
    text(-2, (numEntries/2)+3, 'left lane cool', 'Rotation', 90)
else
    text(-2, (numEntries/2)+3, 'right lane cool', 'Rotation', 90)
end
       
colormap(flipud(cMap)./255)
drawnow
hold on

cd(saveDir)
export_fig(plotName)
