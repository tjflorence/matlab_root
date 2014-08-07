function [tempEnvStruct] = makeRingEnv_gradient(info)

mmWidth = 224;
tickWidth = mmWidth*info.ticksPerMM; 
remainderNum = tickWidth/8;
remainderNum = ceil(remainderNum);
expandMat = ones(remainderNum, remainderNum);
tickWidth = 8*remainderNum;

normID = .417;
normOD = .583;
normEdge = .9;

laneWidth = .09;
roundRadius = round(.10*tickWidth);
goalOuterRadius = round(.12*tickWidth);
startCircleX = round(.3*tickWidth);
startCircleY = round(.5*tickWidth);

deadEndCircleX = round(.5*tickWidth);
deadEndCircleY = round(.25*tickWidth);



%% Third Environment
goalCircleX_3 = round(.65*tickWidth);
goalCircleY_3= round(.65*tickWidth);

deadEndCircleX_3 = goalCircleX_3;
deadEndCircleY_3 = round(.35*tickWidth);


startEnvQ1 = (.33*tickWidth);
startEnvQ2 = (.66*tickWidth);

gradVec  = linspace(info.powerLevels(2),info.powerLevels(3),5);
gradVec = fliplr(gradVec);


 
%% ring environment 3
bg = info.powerLevels(3)*ones(tickWidth,tickWidth);
for xx=1:tickWidth
    for yy=1:tickWidth
        
    end
       
     
       %% start lane
      if (abs(yy-(tickWidth/2))< (laneWidth*tickWidth/2)) && (abs(xx-(tickWidth/2)) < tickWidth*.2) && xx < tickWidth/2
           bg(yy,xx) = gradVec(2);
      
      end
      
      if (abs(yy-(tickWidth/2))< (.85*laneWidth*tickWidth/2)) && (abs(xx-(tickWidth/2)) < tickWidth*.2) && xx < tickWidth/2
           bg(yy,xx) = gradVec(2);
      
      end
      
      if (abs(yy-(tickWidth/2))< (.75*laneWidth*tickWidth/2)) && (abs(xx-(tickWidth/2)) < tickWidth*.2) && xx < tickWidth/2
           bg(yy,xx) = gradVec(3);
      
      end
      
      if (abs(yy-(tickWidth/2))< (.65*laneWidth*tickWidth/2)) && (abs(xx-(tickWidth/2)) < tickWidth*.2) && xx < tickWidth/2
           bg(yy,xx) = gradVec(4);
      
      end
       
      if (abs(yy-(tickWidth/2))< (.65*laneWidth*tickWidth/2)) && (abs(xx-(tickWidth/2)) < tickWidth*.2) && xx < tickWidth/2
           bg(yy,xx) = gradVec(5);
      
      end
      
       %% ring 
       if (sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth*3/4))^2 ) >(normID*tickWidth/2)) && ...
                (sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth*3/4))^2 ) < (normOD*tickWidth/2))
                bg(yy,xx) = info.powerLevels(2);
                

       end
       
       %% dead end quadrant
     %  if (yy < tickWidth/2) && (xx > tickWidth/2) && (bg(yy,xx) == info.powerLevels(2))
       if (xx > .57*tickWidth) && (bg(yy,xx) == info.powerLevels(2))   
           bg(yy,xx) = info.powerLevels(3);

       end
       
       
        

       
        
       %% dead end circle
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(goalOuterRadius) 
                bg(yy,xx) = info.powerLevels(2);

       end
       
       
          %% goal end circle outer
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(goalOuterRadius) 
                bg(yy,xx) = info.powerLevels(2);

       end
       
       
       %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
              %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.9*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
              %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.8*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                     %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.7*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
                     %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.6*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                            %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.5*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
                            %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.4*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                                   %% goal end circle inner
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.3*roundRadius) 
                   bg(yy,xx) = -4.99;

       end
       
       if sqrt( (yy-(goalCircleY_3))^2 + (xx-(goalCircleX_3))^2 ) <(.2*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
       
       
    end
       
end

for xx=1:tickWidth
    for yy=1:tickWidth
        %% edge power
       if sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth/2))^2 ) > (normEdge*tickWidth/2-10)
           
            delta = info.edgePower-info.powerLevels(3);
            
            bg(xx,yy) = info.powerLevels(3)+ (delta* sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth/2))^2 ) /(tickWidth/2));
       end
    end
end
    
 tempEnvStruct(3).right_go = bg;
 tempEnvStruct(3).left_go = flipud(bg);
 
 
 for xx=1:tickWidth
    for yy=1:tickWidth
        
       %% dead end circle
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
       
                     %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.9*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
              %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.8*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                     %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.7*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
                     %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.6*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                            %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.5*roundRadius) 
                bg(yy,xx) = -4.99;

       end
       
                            %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.4*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
                                   %% goal end circle inner
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.3*roundRadius) 
                   bg(yy,xx) = -4.99;

       end
       
       if sqrt( (yy-(deadEndCircleY_3))^2 + (xx-(deadEndCircleX_3))^2 ) <(.2*roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
       
       
    end
end
 
 tempEnvStruct(3).both_go = bg;


 %tempEnvStruct(1).both_go = bg;
    


 %% start environment
bg = info.powerLevels(2)*ones(tickWidth,tickWidth);
for xx=1:tickWidth
    for yy=1:tickWidth
   
        
        %% edge power
       if sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth/2))^2 ) > (normEdge*tickWidth/2-10)
           
            delta = info.edgePower-info.powerLevels(3);
            
            bg(xx,yy) = info.powerLevels(3)+ (delta* sqrt( (yy-(tickWidth/2))^2 + (xx-(tickWidth/2))^2 ) /(tickWidth/2));
       end
       
        
       %% NW cool spot
        if sqrt( (yy-(startEnvQ1))^2 + (xx-(startEnvQ1))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

        end
       
        %% NE cool spot
        if sqrt( (yy-(startEnvQ1))^2 + (xx-(startEnvQ2))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

        end
       
        %% SW cool spot
        if sqrt( (yy-(startEnvQ2))^2 + (xx-(startEnvQ1))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

        end
        
       
        %% SE cool spot
        if sqrt( (yy-(startEnvQ2))^2 + (xx-(startEnvQ2))^2 ) <(roundRadius) 
                bg(yy,xx) = info.powerLevels(1);

       end
       
    end
       
end

 tempEnvStruct(1).start_env = bg;




end
