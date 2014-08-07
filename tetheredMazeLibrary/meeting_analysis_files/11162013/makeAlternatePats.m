%% bigPat is 32x96 = 3072 pixels
%% smaller pat is 8x24  = 192 pixels

valsToPick = [ones(1,192/2) zeros(1,192/2)];
miniMatrix = zeros(8,24);
randInds   = randperm(192);

miniMatrix(:) = valsToPick(randInds);

bigMatrix = kron(miniMatrix,ones(4,4));

cMap = [0 1 0; 0 0 0];
f1 = figure('color', 'w', 'units', 'normalized', 'Position', [.1 .1 .9 .9])
imagesc(bigMatrix)
colormap(cMap);
axis equal off

export_fig('noisePattern', '-bmp')

load('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013/learningPat.mat')

symStripes = ones(32,96);
symStripes(:,7:11) = 0;
symStripes(:,15:19) = 0;
symStripes(:,77:81) = 0;
symStripes(:,85:89) = 0;
symStripes = circshift(symStripes, [0 48])

f1 = figure('color', 'w', 'units', 'normalized', 'Position', [.1 .1 .9 .9])
imagesc(symStripes)
colormap(flipud(cMap));
axis equal off

export_fig('symPatternbitmap', '-bmp')
