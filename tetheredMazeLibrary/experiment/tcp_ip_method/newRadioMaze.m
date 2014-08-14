function tempEnv = newRadioMaze()

rC = 400;
rG = 600;
rE_1 = 860;
rE_2 = 880;
laneEdge = pi/20;


%% make train env
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 3 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 10 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.trainEnv = bg;

%% make train env flipped
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 10 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 3 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.trainEnv_flipped = bg;

%% make ref env 
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 10 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 3 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% 10 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.refEnv = bg;

%% make ref env 
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 10 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 3 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% 10 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.refEnv = bg;

%% make ref env flipped
bg(bg==1)=5;
% 7 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% edge 1
% 10 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
 % circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.refEnv_flipped = bg;

%% make test env 
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 10 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 3 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% 10 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
  
            bg(yy,xx) = 2;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
tempEnv.testEnv = bg;

%% make test env flipped
bg = 4*ones(1800,1800);
% first, draw lanes
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < pi/4 && theta > -pi/4)...
                || (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% now draw center circle
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        if sqrt(x_c^2 + y_c^2) < rC
           bg(yy,xx) = 2;     
        end
        

    end
end
% 10 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (11*pi/12)-laneEdge ) && theta > ((5*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% 7 pm punish zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < (-5*pi/12)-laneEdge ) && theta > ((-11*pi/12) + laneEdge)...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 5;
        end

    end
end
% edge 1
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_1
            
            bg(yy,xx) = 6;
            
        end

    end
end
% edge 2
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if sqrt(x_c^2 + y_c^2) > rE_2
            
            bg(yy,xx) = 7;
            
        end

    end
end
% 3 pm reward zone
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < ((pi/4)-laneEdge)) && (theta > ((-pi/4)+laneEdge))...
            && sqrt(x_c^2 + y_c^2) > rG
            
            bg(yy,xx) = 1;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end

for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        theta = atan2(y_c, x_c);
        
        if (theta < 11*pi/12 && theta > 5*pi/12) ...
                || (theta < -5*pi/12 && theta > -11*pi/12)
            
            bg(yy,xx) = 2;
        end

    end
end
% circle up
for xx = 1:1800
    for yy = 1:1800
    
        x_c = xx-900;
        y_c = yy-900;
        
        
        if sqrt(x_c^2 + y_c^2) > 910
            
            bg(yy,xx) = 7;
        end

    end
end
bg(bg==1) = 5;
tempEnv.testEnv_flipped = bg;

