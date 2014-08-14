function updateDisplay(xVal, yVal, Theta, patternCode) 

global visInit
global patternStruct
global binvals

          if patternCode < 1
              patternCode = 1;
          end
           
          [~,circPls,ray_dist] = sample_wall_positions_circ_elev_V4(xVal, yVal, Theta, 672, 96, visInit);

          for elev=visInit.height_vec
                visInit.dumpPat(elev,:)=(patternStruct(patternCode).expand_pattern(sub2ind(visInit.sizeExp,floor(elev*ray_dist)+1,circPls)))*patternStruct(patternCode).DSM';
          end
           
          Panel_tcp_com('dump_frame', [1152, 0, 0, 48, 3, 0,...
            make_frame_vector_faster2(circshift(fliplr(visInit.dumpPat),[0,20]), visInit.BitMapIndex, visInit.numPanels)']);

     
end


