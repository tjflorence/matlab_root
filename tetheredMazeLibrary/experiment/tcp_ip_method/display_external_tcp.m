function display_external_tcp


global binvals
global tcpipClient
global init
global patternStruct


%% initialize tcp port
init_tcp;

%% make patterns and init structure
[init, patternStruct, binvals] = makePatternStruct;

%% set up tcp object and bytes available function
tcpipClient                         = tcpip('127.0.0.1',55000,'NetworkRole','Client');
tcpipClient.InputBufferSize         = 100;
tcpipClient.BytesAvailableFcnCount  = 40;
tcpipClient.BytesAvailableFcnMode   = 'byte';
tcpipClient.BytesAvailableFcn       = @updateDisplay;
fopen(tcpipClient);

isRunning = 1;
while isRunning == 1
    pause(.001)
end


stop(timerObj)
delete(timerObj)

fclose(tcpipClient)

end


function updateDisplay(obj,event) 

global init
global patternStruct
global tcpipClient

    dataOut = fread(obj, 5, 'double');
    
    if  dataOut(1) >0 %while trial is running, update the frame

          xVal        = dataOut(2);
          yVal        = dataOut(3);
          Theta       = dataOut(4);
          patternCode = round(dataOut(5));
          
          if patternCode < 1
              patternCode = 1;
          end
           
          [~,circPls,ray_dist] = sample_wall_positions_circ_elev_V4(xVal, yVal, Theta, 672, 96, init);

          for elev=init.height_vec
                init.dumpPat(elev,:)=(patternStruct(patternCode).expand_pattern(sub2ind(init.sizeExp,floor(elev*ray_dist)+1,circPls)))*patternStruct(patternCode).DSM';
          end
           
          Panel_tcp_com('dump_frame', [1152, 0, 0, 48, 3, 0,...
            make_frame_vector_faster2(circshift(fliplr(init.dumpPat),[0,22]), init.BitMapIndex, init.numPanels)']);
              
    else    %while trial is not running, all black!
        
          Panel_tcp_com('all_off') % turns display off
          
    end
     
end



        