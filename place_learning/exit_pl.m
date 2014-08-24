function exit_pl(hComm)

%remove the event, DataAvailable event listener
delete(hComm.lh);

%close PControl window
try 
    close(hComm.hPControl);
    uiwait(hComm.hPControl);
catch ME
end


%close BIAS window
try
    rps = hComm.flea3.disconnect();
    rps = hComm.flea3.closeWindow();
    
catch ME
    
end

try 
    hAgilent = hComm.hAgilent;
    PS3649a = hComm.PS3649a;
    hNICRio = hComm.hNICRio;
    hOven1 = hComm.hOven1;
    hOven2 = hComm.hOven2;
    hOven3 = hComm.hOven3;
    hOven4 = hComm.hOven4;
    
    fprintf(hAgilent,'OUTP OFF');
    % close the object, and clear the workspace of the object
    disconnect(PS3649a);
    delete(PS3649a);
    fclose(hAgilent);
    delete(hAgilent);
    
    turnOnOffSwitcher(hComm, 'off',1);
    turnOnOffSwitcher(hComm, 'off',2);
    turnOnOffSwitcher(hComm, 'off',3);
    turnOnOffSwitcher(hComm, 'off',4);
    fclose(hOven1);
    delete(hOven1);
    fclose(hOven2);
    delete(hOven2);
    fclose(hOven3);
    delete(hOven3);
    fclose(hOven4);
    delete(hOven4);
catch ME
    
end

