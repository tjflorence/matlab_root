function new_arena = makeRuschaEnv2(info)


                          
arena = info.arenaPowerLevels(5)*ones(1800,1800);
blendVec = linspace(info.arenaPowerLevels(4),info.arenaPowerLevels(2),500);

for yy = 1:1800
    for xx = 1:1800

        if (yy<1075) && (yy>900) && (xx >370) && (xx < 1135)
           arena(yy,xx)=info.arenaPowerLevels(4);
        end
        
        if (yy<1025) && (yy>900) && (xx >395) && (xx < 1150)
           numPix = xx-420;
           if numPix>0 && numPix <500 && blendVec(numPix) < info.arenaPowerLevels(3) 
            arena(yy,xx)=info.arenaPowerLevels(3);
           end
        end
        
        if yy >950 && xx>800
            arena(yy,xx) = info.arenaPowerLevels(4);
        end
        
        if (yy<1000) && (yy>900) && (xx >400) && (xx < 1000)
            numPix = xx-420;
            if (xx <902)&& xx>420
              arena(yy,xx) = blendVec(numPix);
            elseif xx>420
                arena(yy,xx)= info.arenaPowerLevels(2);
            end
        end
        
        
     if (xx< (yy)+200) && (xx>(yy)-500) && (yy > 1070) && (yy<1300) && (xx>2)
        arena(yy,xx)= info.arenaPowerLevels(4);
      end  
        
      if (xx< (yy)+100) && (xx>(yy)-400) && (yy > 900) && (yy<1300) && (xx>2)
          numPix = xx-420;
           if (xx <902)&& xx>420
              arena(yy,xx) = blendVec(numPix);
            elseif xx>420
                arena(yy,xx)= info.arenaPowerLevels(2);
            end
      end
      

        
      if yy >1000 && xx>900
          arena(yy,xx) = info.arenaPowerLevels(2);
      end
   

        
    end
end

for yy = 1:1800
    for xx = 1:1800
        
             %% edge powers
      if sqrt(((xx-900)^2)+((yy-900)^2))>780
            arena(xx,yy) = info.arenaPowerLevels(5);
      end
      
      if sqrt(((xx-900)^2)+((yy-900)^2))>790
            arena(xx,yy) = info.edgePowerLevels(1);
      end
      
      if sqrt(((xx-900)^2)+((yy-900)^2))>800
            arena(xx,yy) = info.edgePowerLevels(2);
      end
      
    end
end


arena(1:900,:) = flipud(arena(901:end,:));
for yy = 1:1800
    for xx = 1:1800

 
        
       if yy < 675 && xx >1025
            arena(yy,xx) = info.arenaPowerLevels(1);
       end   
        
       if yy < 650 && xx >1050
            arena(yy,xx) = -4.99;
       end  
       
        
       if yy < 625 && xx >1075
            arena(yy,xx) = info.arenaPowerLevels(1);
       end  
       
       if yy < 600 && xx >1100
            arena(yy,xx) = -4.99;
       end  
       
       if yy < 575 && xx >1125
            arena(yy,xx) = info.arenaPowerLevels(1);
       end  
       
       if yy < 550 && xx >1150
            arena(yy,xx) = -4.99;
      end  
       
       if yy < 525 && xx >1175
            arena(yy,xx) = info.arenaPowerLevels(1);
       end  
       
       if yy < 500 && xx >1200
            arena(yy,xx) = -4.99;
      end       

       if yy < 475 && xx >1225
            arena(yy,xx) = info.arenaPowerLevels(1);
      end  
       
       if yy < 450 && xx >1250
            arena(yy,xx) = -4.99;
       end  
       
       if yy < 425 && xx >1275
            arena(yy,xx) = info.arenaPowerLevels(1);
       end 
 
          

      
    end
end

new_arena.left_go = arena;
new_arena.right_go = flipud(arena);
new_arena.both_go = new_arena.right_go;
new_arena.both_go(1:900,:) = flipud(new_arena.both_go(901:end,:));


new_arena.both_go_noCool = new_arena.both_go;
new_arena.both_go_noCool(new_arena.both_go_noCool<info.arenaPowerLevels(2)) = info.arenaPowerLevels(2);

new_arena.both_hot = new_arena.both_go;
new_arena.both_hot(new_arena.both_hot<info.arenaPowerLevels(2))=info.arenaPowerLevels(4);

new_arena.left_go = new_arena.both_go;
new_arena.left_go(901:end,:) = new_arena.both_hot(901:end,:);


for yy = 1:1800
    for xx = 1:1800
        
             %% edge powers
      if sqrt(((xx-900)^2)+((yy-900)^2))>780 && new_arena.left_go(xx,yy) > info.arenaPowerLevels(3)
            new_arena.left_go(xx,yy) = info.arenaPowerLevels(5);
      end
      
      if sqrt(((xx-900)^2)+((yy-900)^2))>790 && new_arena.left_go(xx,yy) > info.arenaPowerLevels(3)
            new_arena.left_go(xx,yy) = info.edgePowerLevels(1);
      end
      
      if sqrt(((xx-900)^2)+((yy-900)^2))>800 && new_arena.left_go(xx,yy) > info.arenaPowerLevels(3)
            new_arena.left_go(xx,yy) = info.edgePowerLevels(2);
      end
      
    
    

    
    end
end

for yy = 1:1800
    for xx = 1:1800
      if xx> 900 && yy <800
       if new_arena.left_go(yy,xx) > info.arenaPowerLevels(4)
           new_arena.left_go(yy,xx) = info.arenaPowerLevels(2);
       end
      end
    
    if xx> 800 && yy <850
       if new_arena.left_go(yy,xx) > info.arenaPowerLevels(4)
           new_arena.left_go(yy,xx) = info.arenaPowerLevels(4);
       end
    end
    
    end
end


new_arena.right_go = flipud(new_arena.left_go);
    
    