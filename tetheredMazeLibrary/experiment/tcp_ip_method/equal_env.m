startMat = ones(1800,1800);
theta = pi/4;
alpha = theta/2;


for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha)) && (testAngle < ((pi/3) + alpha))
               
               startMat(xx, yy) = 2;

               
           end
            
        
        end
    
        
        if xx_p <0 && yy_p ~= 0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > -alpha) && (testAngle < alpha)
               
               startMat(xx,yy) = 2;

           end            
        
        end
        
    end
end

%% make hot zone
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
        if xx_p > 0 && yy_p >0
         
           testAngle = asin(yy_p/(sqrt( (xx_p^2) + (yy_p^2))));
           
           if (testAngle > ((pi/3) - alpha*.8)) && (testAngle < ((pi/3) + alpha*.8)) && (sqrt((xx_p^2)+(yy_p^2)) > 650)
               
               startMat(xx,yy) = 4;

               
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
           
           if (testAngle > -alpha*.8) && (testAngle < alpha*.8) && (sqrt((xx_p^2)+(yy_p^2)) > 650)
               
               startMat(xx,yy) = 0;

           end            
        
        end
        
    end
end

startMat(901:1800, 1:900) = fliplr(startMat(901:1800, 901:1800)); 


%% circularize border
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
     if  sqrt((xx_p^2)+(yy_p)^2)>900
         
         startMat(xx, yy) = 1;
         
     end
        
    end
end

%% circularize center
for xx = 1:1800
    for yy = 1:1800
    
        xx_p = xx-900;
        yy_p = yy-900;
         
     if  sqrt((xx_p^2)+(yy_p)^2)<100
         
         startMat(xx, yy) = 2;
         
     end
        
    end
end

