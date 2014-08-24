function setPeltierTemp(hComm, temp1, temp2, temp3, temp4)
%  setPeltierTemp set the peltier temperature (in celsius degree) on the
%  place learning rig.
%
%     setPeltierTemp(sp, desiredTemp) set the peltier temperature to
%     desiredTemp via the serial port object sp.
%
%     INPUT PARAMETERS:
%         sp: serial port object
%         desiredTemp: the desired temperature of the peltier
%  
%  
%     EXAMPLES:
%     set the peltier temperature to 30 celsius degree
%     setPeltierTemp(sp, 30);
sp1 = hComm.hOven1;

tempCode = ndec2hex(int16(temp1 * 100), 32);

Reslt = send_TEM_serial_command(sp1, '00', '10',lower(tempCode));

turnOnOffSwitcher(hComm, 'on', 1);

sp2 = hComm.hOven2;

tempCode = ndec2hex(int16(temp2 * 100), 32);

Reslt = send_TEM_serial_command(sp2, '00', '10',lower(tempCode));

turnOnOffSwitcher(hComm, 'on', 2);

sp3 = hComm.hOven3;

tempCode = ndec2hex(int16(temp3 * 100), 32);

Reslt = send_TEM_serial_command(sp3, '00', '10',lower(tempCode));

turnOnOffSwitcher(hComm, 'on', 3);

sp4 = hComm.hOven4;

tempCode = ndec2hex(int16(temp4 * 100), 32);

Reslt = send_TEM_serial_command(sp4, '00', '10',lower(tempCode));

turnOnOffSwitcher(hComm, 'on', 4);
