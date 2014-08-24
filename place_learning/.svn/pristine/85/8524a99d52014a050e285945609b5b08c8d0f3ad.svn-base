function turnOnOffSwitcher(hComm, onOff, chanId)
% turnOnOffSwitcher enable or disable the Oven 5R6-900 controller output
%
%     turnOnOffSwitcher(sp, onOff) turn on or off the controller output via
%     the serial port object sp.
%
%     INPUT PARAMETERS:
%         sp: serial port object
%         onOff: 'on' or 'off'
%  
%     EXAMPLES:
%     enable controller output
%       turnOnOffSwitcher(sp, 'on');
%     disable controller output
%       turnOnOffSwitcher(sp, 'off');
%
switch chanId
    case 1
        sp = hComm.hOven1;
    case 2
        sp = hComm.hOven2;
    case 3
        sp = hComm.hOven3;
    case 4
        sp = hComm.hOven4;
    otherwise
        warndlg('channel ID should be an integer from 1 to 4', 'Wrong channel ID');
        return;
end
            
if strcmpi(onOff, 'ON')
    Reslt = send_TEM_serial_command(sp, '00', '1d','00000001');
elseif strcmpi(onOff, 'OFF')
    Reslt = send_TEM_serial_command(sp, '00', '1d','00000000');
else
    printf('The input command should be either on or off');
end