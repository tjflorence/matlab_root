function [vertStruct]=hextile(rect,size)
% hextile(rect,size)
% rect - [x y w h]
% size - distance between hexes (default 1)
% returns
% h - plot handle
% xy - centers of all hexagons drawn
[x,y,w,h] = deal(rect(1),rect(2),rect(3),rect(4));

if nargin < 2, 
    size = 1;
end

[c,s]=deal(cos(pi/6),sin(pi/6));

xlist = 0:size*(2+2*s):w; % anticipated x centers
ylist = 0:size*(c):h; % anticipated y centers

center_x = repmat(xlist,length(ylist),1)';
center_y = repmat(ylist,length(xlist),1);
center_x(:,2:2:end) = ...
  center_x(:,2:2:end)+size*(1+s); % Shift odd rows

f = find(center_x(:) <= w); % find outlying hexes
center_x = center_x(f); % remove outlying hexes
center_y = center_y(f); % remove outlying hexes

% Define corners of a single hexagon
x0=size*(cumsum([0,s,1,s, -s,-1,-s,NaN])-s-0.5);
y0=size*[0,c,c,0,-c,-c,0,NaN]; % full hex

% Replicate to the centers
xplot=log(exp(x0')*exp(center_x)');
yplot=log(exp(y0')*exp(center_y)');

%h = plot(x+xplot(:),y+yplot(:));

  xy = [x+center_x(:),y+center_y(:)];

axis equal

centers_xy = [center_x center_y];

%% now create a structure to hold all vertices in case you want to fill
%% hexagons
% make constants for later
numCenters  = length(centers_xy);
halfSize    = size*.9;
hexFact_tan    = halfSize*tan(pi/6);
hexFact_cos    = halfSize/cos(pi/6);

for aa = 1:numCenters
  
    vertStruct(aa).xy = xy(aa,:);
    
    centerX = centers_xy(aa,1);
    centerY = centers_xy(aa,2);
    
    xvals = nan(1,6);
    yvals = nan(1,6);
    
    xvals(1) = centerX-hexFact_cos;
    xvals(2) = centerX-hexFact_tan;
    xvals(3) = centerX+hexFact_tan;
    xvals(4) = centerX+hexFact_cos;
    xvals(5) = centerX+hexFact_tan;
    xvals(6) = centerX-hexFact_tan;
    
    yvals([1 4]) = centerY;
    yvals([2 3]) = centerY+halfSize;
    yvals([5 6]) = centerY-halfSize;
    
    vertStruct(aa).xvals = xvals;
    vertStruct(aa).yvals = yvals; 
    
end

return