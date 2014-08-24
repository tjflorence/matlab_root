function [temp1,temp2,temp3,temp4] = readPeltierTemp(hComm)
%  readPeltierTemp read the peltier temperature (in celsus degree) on the
%  place learning rig.
%
%     currTemp = readPeltierTemp(sp) read the peltier temperature via the
%     serial port object sp.
%
%     INPUT PARAMETERS:
%         sp: serial port object
%
%     RETURN PARAMETERS:
%         currTemp: current temperature in celsus degree
%
%     EXAMPLES:
%     read the current peltier temperature 
%     currTemp = readPeltierTemp(sp)
%
sp1 = hComm.hOven1;
tempCode = send_TEM_serial_command(sp1, '00', '01');
temp1 = hex2dec(tempCode)/100;

sp2 = hComm.hOven2;
tempCode = send_TEM_serial_command(sp2, '00', '01');
temp2 = hex2dec(tempCode)/100;

sp3 = hComm.hOven3;
tempCode = send_TEM_serial_command(sp3, '00', '01');
temp3 = hex2dec(tempCode)/100;

sp4 = hComm.hOven4;
tempCode = send_TEM_serial_command(sp4, '00', '01');
temp4 = hex2dec(tempCode)/100;

