function tempEnvStruct = makeQuadEnv()

startMat = 4*ones(1800,1800);
punishQuadEdge = 100;
ringInnerRadius = 840;
ringOuterRadius = 880;

% recover NW and SE
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        
       if xx_p > 0 && yy_p < 0
            
            startMat(yy,xx) = 4;
        end
        
    end
end

% draw punish square in SE & NE
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        

        
       if xx_p > 0 && yy_p < 0 && abs(xx_p) > punishQuadEdge && abs(yy_p) > punishQuadEdge
            
            startMat(yy,xx) = 4;
       end

       if xx_p > 0 && yy_p > 0 && abs(xx_p) > punishQuadEdge && abs(yy_p) > punishQuadEdge
            
            startMat(yy,xx) = 4;
       end       
       
        
    end
end

% circularize inner
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> ringInnerRadius
            
            startMat(yy,xx) = 5;
        end
        
    end
end

% circularize outer
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> ringOuterRadius
            
            startMat(yy,xx) = 6;
        end
        
    end
end

%% recover NW 
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        
       if xx_p < 0 && yy_p > 0
            
            startMat(yy,xx) = 4;
        end
        
    end
end

% draw reward square
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
       if xx_p < 0 && yy_p > 0 && abs(xx_p) > punishQuadEdge && abs(yy_p) > punishQuadEdge
            
            startMat(yy,xx) = 1;
        end
        
    end
end

% circularize for asthetics
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> 905
            
            startMat(yy,xx) = 6;
        end
        
    end
end

tempEnvStruct.sw_start = startMat;
tempEnvStruct.ne_start = flipud(rot90(tempEnvStruct.sw_start, 3));
tempEnvStruct.sw_start_flipped = fliplr(rot90(tempEnvStruct.sw_start, 3));
tempEnvStruct.ne_start_flipped = fliplr(flipud(tempEnvStruct.sw_start));

%% redraw for test envs
startMat = 4*ones(1800,1800);
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        
       if xx_p > 0 && yy_p > 0         
            startMat(yy,xx) = 4;
        end
        
    end
end

% circularize inner
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> ringInnerRadius
            
            startMat(yy,xx) = 5;
        end
        
    end
end

% circularize outer
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> ringOuterRadius
            
            startMat(yy,xx) = 6;
        end
        
    end
end

% circularize for asthetics
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> 905
            
            startMat(yy,xx) = 6;
        end
        
    end
end

tempEnvStruct.test_env = startMat;
tempEnvStruct.test_env_flipped = rot90(startMat, 2);

%% redraw for ref env
startMat = 4*ones(1800,1800);

% draw reward square
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
       if xx_p < 0 && yy_p > 0 && abs(xx_p) > punishQuadEdge && abs(yy_p) > punishQuadEdge
            
            startMat(yy,xx) = 1;
       end
       
       if xx_p > 0 && yy_p < 0 && abs(xx_p) > punishQuadEdge && abs(yy_p) > punishQuadEdge
            
            startMat(yy,xx) = 1;
       end
        
        
    end
end

% circularize for asthetics
for xx = 1:1800
    for yy = 1:1800
        xx_p = xx-900;
        yy_p = yy-900;
        
        if sqrt((xx_p^2)+(yy_p^2))> 905
            
            startMat(yy,xx) = 6;
        end
        
    end
end

tempEnvStruct.ref_env = startMat;



