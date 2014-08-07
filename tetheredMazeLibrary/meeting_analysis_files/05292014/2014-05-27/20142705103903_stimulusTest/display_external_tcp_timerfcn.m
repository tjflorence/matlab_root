function display_external_tcp_timerfcn


global binvals
global tcpipClient
global init
global patternStruct
global lastRead
global dumpedFrame

%% initialize dummy variable
lastRead    = zeros(5,1);
dumpedFrame = ones(5,1);

%% initialize tcp port
init_tcp;

%% make patterns and init structure
[init, patternStruct, binvals]      = makePatternStructSBD;

%% set up tcp object and bytes available function
tcpipClient                         = tcpip('127.0.0.1',55000,'NetworkRole','Client');
tcpipClient.InputBufferSize         = 41;
fopen(tcpipClient);

%% set up timer object
timerObj                = timer;
timerObj.ExecutionMode  = 'fixedRate';
timerObj.Period         = .01;
timerObj.TasksToExecute = 100000000000;
timerObj.BusyMode       = 'drop';
timerObj.TimerFcn       = {@updateDisplay};
start(timerObj)

wait(timerObj)

stop(timerObj)
delete(timerObj)

stop(timerObj)
delete(timerObj)

fclose(tcpipClient)

end


function updateDisplay(obj,event) 

global init
global patternStruct
global tcpipClient
global lastRead
global dumpedFrame
    
    if tcpipClient.bytesAvailable > 0;
        dataOut     = fread(tcpipClient, 5, 'double');
        lastRead    = dataOut;
        doDump      = 1;
    else
        dataOut     = lastRead;
        doDump      = 0;
    end
    
    if  dataOut(1) >0 %while trial is running, update the frame
          
          if doDump == 1
            xVal        = dataOut(2)*.8;
            yVal        = dataOut(3)*.8;
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
                    make_frame_vector_faster2(circshift(fliplr(init.dumpPat),[0,23]), init.BitMapIndex, init.numPanels)']);
           end
            

          
    else    %while trial is not running, all black!
        
          Panel_tcp_com('all_off') % turns display off
          
    end
     
end



        