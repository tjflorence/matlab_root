
function [init, patternStruct, binVals] = makePatternStruct_id
%% makes structure containing patterns for visual discrim / virtual place learning
% can code up to 8 patterns
% experiment outputs pattern nums 0-7
% each pattern structure entry has a pat, a down-sampling matrix (DSM) and an
% expanded pattern (expand_pat)

% structure ID = pattern num +1
% pattern 0 = dark pattern
% pattern 1 = vertical stripe
% pattern 2 = diagonal stripe discrimination
% pattern 3 = diagonal versus block discrimination
% pattern 4 = block versus diagonal discrimination


%% also, make init structure

%% input pattern matrices
% pattern matrices are 32x96 patterns
% all off pattern
darkPattern             = zeros(32,96);
patternStruct(1).pat    = darkPattern;
patternStruct(1).name   = 'dark';

% creates vertical line pattern
vertLine                = zeros(32,96);
vertLine(:,1:4)         = 1;
vertLine(:,93:96)       = 1;
vertLine(:,45:52)       = 200;
patternStruct(2).pat    = vertLine;
patternStruct(2).name   = 'vertical line';


% creates SBD pattern
% % creates the pattern
bars=repmat([ones(32,8),zeros(32,8)],1,2);
stripes=repmat([ones(8,32);zeros(8,32)],2,1);
diagonal=circshift(bars(1,:),[0,1]);
for f=1:31
    diagonal=[diagonal;circshift(diagonal(1,:),[0,f])];
end
SBD = [fliplr(bars) stripes diagonal]
SBD = circshift(rot90(SBD,2), [0 36] );


patternStruct(3).pat = SBD;
patternStruct(3).name = 'SBD';

%% now, all we have to do is iterate making DSMs and expanded pats over the
% number of entries in patternStruct

% some constants
displayHeight   = 32;
displayWidth    = 96;
overSample      = 7;

for aa = 1:length(patternStruct)
    
    expand_pattern=[];
    
    for g=1:displayHeight
        
        H_expand_pattern=[];
        
        for f=1:length(patternStruct(aa).pat)
            H_expand_pattern=[H_expand_pattern,patternStruct(aa).pat(g,f)*ones(1,overSample)];
        end
        
    expand_pattern=[expand_pattern;H_expand_pattern];
    
    end
    expand_pattern=[expand_pattern;zeros(size(expand_pattern))];
    
 %  expand_pattern                     =    addNoiseToPattern(expand_pattern);
    patternStruct(aa).expand_pattern   =   expand_pattern;

    %creates the down sampling matrix
    DSM = zeros(displayWidth, displayWidth*overSample);

    for j = 1:displayWidth
        start_ind = overSample*(j-1) + 1;
        end_ind = overSample*j;
        DSM(j,start_ind:end_ind) = 1;
    end
    
    patternStruct(aa).DSM = DSM;
end

%% init structures

% process pattern info
init.pattern.row_compression = 0; % kind of a hack, but then can use old code for process_panel_map
init.pattern.Panel_map = [12 8 4 11 7 3 10 6 2  9 5 1; 24 20 16 23 19 15 22 18 14 21 17 13; 36 32 28 35 31 27 34 30 26 33 29 25; 48 44 40 47 43 39 46 42 38 45 41 37];
init.BitMapIndex = process_panel_map(init.pattern);
init.numPanels   = length(init.pattern.Panel_map);
init.displayHeight   = 32;
init.displayWidth    = 96;
init.overSample      = 7;
init.dumpPat         = ones(init.displayHeight, init.displayWidth);

init.pat=zeros(displayHeight,displayWidth);
init.num_angle_samples = displayWidth*overSample;
init.height_vec = 1:1:displayHeight;
init.sizeExp = size(expand_pattern);
init.numPanels = length(init.BitMapIndex);
    
init.theta = 0:(2*pi)/init.num_angle_samples:2*pi - (1/init.num_angle_samples);
init.one_quarter = (init.num_angle_samples/4);
init.theta = [init.theta(init.one_quarter + 1:end) init.theta(1:init.one_quarter)];
% theta starts at behind then goes counterclockwise, so flip this - 
init.theta = fliplr(init.theta);

init.x_circle_pos = zeros(1,length(init.theta));
init.y_circle_pos = zeros(1,length(init.theta));
init.ray_dist = zeros(1,length(init.theta));




%% bin vals
binVals.bin_val =  [0 0 0; 0 0 1; 0 1 0; 0 1 1; 1 0 0; 1 0 1; 1 1 0; 1 1 1];
binVals.bin2dec_mat = [1 2 4 8 16 32 64 128]; %[128 64 32 16 8 4 2 1];
    
end


function noisy_pattern = addNoiseToPattern(expandedPat)
%% adds noise to pattern

    noiseProb     = 50; % enter freq of noise pixel
    noisy_pattern = expandedPat;
    sizePattern = size(expandedPat);
    totalPixels = sizePattern(1)*sizePattern(2);

    doFlipVec   = [1 zeros(1,noiseProb)];

    for zz = 1:totalPixels
        
        flipInd = mod(zz, length(doFlipVec));
        randInd = randperm(length(doFlipVec));
        if flipInd == 0
            flipInd = length(doFlipVec);
        end
        
        [height, width] = ind2sub(size(expandedPat), zz);
        
        if height < 33
            if (expandedPat(zz) > 0) && (doFlipVec(randInd(flipInd))==1)
                noisy_pattern(zz) = 0;
           % elseif (expandedPat(zz) < 1) && (doFlipVec(randInd(flipInd))==1)
           %     noisy_pattern(zz) = 1;
            end
        end
        
  
    end


end
