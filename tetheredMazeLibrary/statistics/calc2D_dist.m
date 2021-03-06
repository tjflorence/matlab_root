function dist2D = calc2D_dist(data)

  %  inst_dist_walked = nan(1:data.count);
  %  inst_dist_walked(1) = 0;
  dist2D_ticks = 0;
  int_to_sample = 50;
  
    for aa = (int_to_sample+1):int_to_sample:data.count
        
        inst_dist_walked = sqrt( ((data.Xpos(aa)-data.Xpos(aa-int_to_sample))^2) + ((data.Ypos(aa)-data.Ypos(aa-int_to_sample))^2) );
        dist2D_ticks = dist2D_ticks+inst_dist_walked;
        
    end
    
    dist2D = dist2D_ticks/3.45;
    
    
end