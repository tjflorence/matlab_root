function [pwr1, pwr2, pwr3, pwr4] = readPowerOutput(hComm)
%  readPowerOutput read the current Oven 5R6-900 controller output power
%  (in percentage).
%
%     currPwr = readPowerOutput(sp) read the Oven5R6-900 controller output
%     power via the serial port object sp.
%
%     INPUT PARAMETERS:
%         sp: serial port object
%
%     RETURN PARAMETERS:
%         currPwr: current power output in percentage
%
%     EXAMPLES:
%     read the current power output
%     currPwr = readPowerOutput(sp);
%
sp1 = hComm.hOven1;
powerCode = send_TEM_serial_command(sp1, '00', '04');
pwr1 = double(nhex2dec(powerCode, 32))/683*100;

sp2 = hComm.hOven2;
powerCode = send_TEM_serial_command(sp2, '00', '04');
pwr2 = double(nhex2dec(powerCode, 32))/683*100;


sp3 = hComm.hOven3;
powerCode = send_TEM_serial_command(sp3, '00', '04');
pwr3 = double(nhex2dec(powerCode, 32))/683*100;


sp4 = hComm.hOven4;
powerCode = send_TEM_serial_command(sp4, '00', '04');
pwr4 = double(nhex2dec(powerCode, 32))/683*100;