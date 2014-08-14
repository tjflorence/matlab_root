startMat = 5*ones(1800,1800);
theta = pi/4; % make lanes
alpha = theta/2; % half-lane

%% circularize center
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
     if  sqrt((xx_p^2)+(yy_p)^2)<150
         
         startMat(xx, yy) = 3;
         
     end
        
    end
end


%% make lanes
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha)) && (testAngle < ((pi/3) + alpha))
               
               startMat(xx, yy) = 3;

               
           end
            
        
        end
    
        
        if xx_p <0 && yy_p ~= 0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > -alpha) && (testAngle < alpha)
               
               startMat(xx,yy) = 3;

           end            
        
        end
        
        if abs(yy_p) <10 && xx_p < 0 
            
             startMat(xx,yy) = 3;
             
        end
        
    end
end

%% make hot zone out
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha*.8)) && (testAngle < ((pi/3) + alpha*.8)) && (sqrt((xx_p^2)+(yy_p^2)) > 610 )
               
               startMat(xx,yy) = 5;

               
           end
            
        
        end
        
    end
end


%% make hot zone in
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha*.6)) && (testAngle < ((pi/3) + alpha*.6)) && (sqrt((xx_p^2)+(yy_p^2)) > 660 )
               
               startMat(xx,yy) = 6;

               
           end
            
        
        end
        
    end
end

%% circularize border outer
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
     if  sqrt((xx_p^2)+(yy_p)^2) > 840
         
         startMat(xx, yy) = 6;
         
     end
        
    end
end

%% circularize border outer
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
     if  sqrt((xx_p^2)+(yy_p)^2) > 870
         
         startMat(xx, yy) = 7;
         
     end
        
    end
end


%% remake top lane
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
         if xx_p <0 && yy_p ~= 0
         
                testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
                if (testAngle > -alpha) && (testAngle < alpha)
               
                    startMat(xx,yy) = 3;

                end            
        
        end
        
    end
end

%% make cool zone
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
        
        if xx_p <0 && yy_p ~= 0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > -alpha*.8) && (testAngle < alpha*.8) && (sqrt((xx_p^2)+(yy_p^2)) > 610)
               
               startMat(xx,yy) = 1;

           end            
        
        end
        
    end
end

startMat(901:1800, 1:900) = fliplr(startMat(901:1800, 901:1800)); 
startMat = flipud(startMat);

trainEnv = startMat;

startMat = flipud(startMat);
%% make cool zone for test env
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
        
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha)) && (testAngle < ((pi/3) + alpha)) 
               
               startMat(xx, yy) = 3;

               
           end
            
        
        end
        
    end
end

for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
        
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha*.8)) && (testAngle < ((pi/3) + alpha*.8)) && (sqrt((xx_p^2)+(yy_p^2)) > 610)
               
               startMat(xx, yy) = 1;

               
           end
            
        
        end
        
    end
end

refEnv_start8 = flipud(startMat);
refEnv_start4 = fliplr(refEnv_start8);

startMat = refEnv_start8;
%% remove cool zone
for xx = 1:1800
    for yy = 1:1800
    

        
        if xx > 556 && startMat(yy,xx) == 1
         
            startMat(yy,xx) = 3;
        
        end
        
    end
end

testEnv_start8 = startMat;
testEnv_start4 = fliplr(startMat);


for xx = 1:1800
    for yy = 1:1800
        
        xx_p = xx-900;
        yy_p = yy-900;
        if sqrt((xx_p^2)+(yy_p^2))>900
            
            trainEnv(xx, yy) = 7;
            testEnv_start8(xx, yy) = 7;
            testEnv_start4(xx, yy) = 7;
            refEnv_start8(xx, yy)  = 7; 
            refEnv_start4(xx, yy)  = 7;
        end
        
    end
end




% imagesc(startMat);
% set(gca, 'YDir', 'normal')
% axis equal off
% 
% hold on
% 
% z1 = scatter(348, 584, 100);
% set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', [.5 .5 .5]);
% startTheta = (pi/6);
% plot([348, 348+(100*cos(startTheta))], [584, 584+(100*sin(startTheta))], 'k', 'LineWidth', 3)
% 
% z1 = scatter(1452, 584, 100);
% set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', [.5 .5 .5]);
% startTheta = pi-(pi/6);
% plot([1452, 1452+(100*cos(startTheta))], [584, 584+(100*sin(startTheta))], 'k', 'LineWidth', 3)
% 
% %creates the pattern
% bars=repmat([ones(32,8),zeros(32,8)],1,2);
% stripes=repmat([ones(8,32);zeros(8,32)],2,1);
% diagonal=circshift(bars(1,:),[0,1]);
% for f=1:31
%     diagonal=[diagonal;circshift(diagonal(1,:),[0,f])];
% end
% 
% SBD = [bars stripes diagonal];
% SBD = circshift(rot90(SBD,2), [0 23] );
% 
% 
% drawArena2(900, 900, 900,  1.3, SBD)
% 
% hold off
