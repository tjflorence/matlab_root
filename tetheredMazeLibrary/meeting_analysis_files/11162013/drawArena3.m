function drawArena3(centerX, centerY, radius,  radFac, pattern,startSizeFac, isTethered)

%centerX = 900;
%centerY = 900;
%radius = 900;

iVec = linspace(0,1,7);
gcMap = zeros(7,3);
gcMap(:,2) = iVec';
gcMap = [gcMap; gcMap(7,:)];

startSize = 20*startSizeFac;
radiusDilationFactorVec = linspace(1,radFac, 32);
columnVec = linspace((2*pi)/96, 2*pi, 96);
sizeDilationFactorVec = linspace(1.1,2.5, 32);

hold on

%f1 = figure('Color', 'w');
[P] = annulus(radius,(radius*radiusDilationFactorVec(32))+50,centerX,centerX, centerY,centerY)

for yy = 1:32
   for xx = 1:96
    
       radiusCurrent = radius*radiusDilationFactorVec(yy);
       xPos = radiusCurrent*cos(columnVec(xx))+centerX;
       yPos = radiusCurrent*sin(columnVec(xx))+centerY;
   
       z1 = scatter(xPos, yPos, startSize*sizeDilationFactorVec(yy));
       hold on
       
       set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', gcMap(pattern(yy,xx)+1,:) )
       if isTethered == 1
          if xx > 41+24 && xx<56+24
             
                 set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', [1 1 1])
              
          end
           
           
       end
   
      % drawnow
   end
end

axis equal off