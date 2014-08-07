function drawArena2(centerX, centerY, radius,  radFac, pattern)

%centerX = 900;
%centerY = 900;
%radius = 900;

%% stripes
%bars    = repmat([ones(32,8) zeros(32,8)], [1 2]);
%stripes = [ones(8,32); zeros(8,32); ones(8,32); zeros(8,32)];
%diag = bars;
%for bb = 2:32
%    diag(bb,:) = circshift(diag(1,:), [1 bb]);
%end

%bsd = [bars stripes diag];
    

startSize = 20;
radiusDilationFactorVec = linspace(1,radFac, 32);
columnVec = linspace((2*pi)/96, 2*pi, 96);
sizeDilationFactorVec = linspace(6,8, 32);

hold on

%f1 = figure('Color', 'w');
[P] = annulus(radius+50,(radius*radiusDilationFactorVec(32))+100,centerX,centerX, centerY,centerY)

for yy = 1:32
   for xx = 1:96
    
       radiusCurrent = radius*radiusDilationFactorVec(yy);
       xPos = radiusCurrent*cos(columnVec(xx))+centerX;
       yPos = radiusCurrent*sin(columnVec(xx))+centerY;
   
       z1 = scatter(xPos, yPos, startSize*sizeDilationFactorVec(yy));
       hold on
       if pattern(yy,xx) ==1
            set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'g')
       else
           set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'k')
       end
   
      % drawnow
   end
end

axis equal off