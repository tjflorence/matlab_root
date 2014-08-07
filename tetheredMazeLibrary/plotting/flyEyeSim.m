function h1 = makeFlyGoggles(viewMatrix)

%% viewMatrix = 32x96 matrix

% blow up image to 3200 x 9600
bigView = kron(viewMatrix, ones(100, 100));

% make gaussian filter. filter size = 80 x 80 pixels (approx 3 deg of space
% assuming 9600 pixels is 360 degrees
h = fspecial('gaussian', [80 80], 132); % set sigma to 1.67x filter size
filteredImage = imfilter(bigView,h,'replicate');

% constants below set shape of fly eyes
e1_centerX = 25+5;
e2_centerX = 73-5;

e1_centerY = 16.5;
e2_centerY = 16.5;

a = 20;
b = 16;


%f1 = figure('color', 'w', 'units', 'normalized', 'Position', [.1 .1 .8 .8])

% here we create hexagonal grid to sample points from the large filtered
% image
[vertStruct]=hextile([1 1 96 32], 1)

% draw individual ommatidia, fill with 
for aa = 1:length(vertStruct)
    
    index = [nan nan];
    try
        vertStruct(aa).val = filter( floor(vertStruct(aa).xy(2)*100), floor(vertStruct(aa).xy(1)*100) );
    
        if  ( (vertStruct(aa).xy(1)-e1_centerX) /a)^2 + ( (vertStruct(aa).xy(2)-e1_centerY) /b)^2 < 1.2 ||  ( (vertStruct(aa).xy(1)-e2_centerX) /a)^2 + ( (vertStruct(aa).xy(2)-e2_centerY) /b)^2 < 1.2
        
            hold on
            fill(vertStruct(aa).xvals, vertStruct(aa).yvals, vertStruct(aa).val*[0 1 0])
        
          %  n = n+1
        end
        
        
    catch
        
    end
end
box off
axis equal off
%export_fig('ommatidia_view_sim_v1', '-pdf', '-nocrop')