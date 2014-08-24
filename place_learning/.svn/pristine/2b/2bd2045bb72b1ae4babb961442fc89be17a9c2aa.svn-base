function setFloorWallTemp(hComm, desiredFloorTemp, desiredWallTemp)
% Function for communicating with an Agilent AE3649a power supply.

% The function comprises of the following steps to communicate with the
% instrument:
%   1)  Create an interface object
%   2)  Connect to the instrument
%   3)  Configure properties
%   4)  Set the voltage and current values
%   5)  Disconnect from the power supply
%
% INPUTS:
%
% voltage        : Voltage value the E3649a should output (double datatype)
% chanIndex      : Channal index (double datatype)
% overVoltage    : the over-voltage protection (OVP) level of the output channel.
%                  The values are programmed in volts. If the output voltage exceeds
%                  the OVP level, the output is disabled. (double datatype)
% currentProState: enables or disables the over-current protection (OCP)
%                  function (boolean datatype)
%
% OUTPUTS:
%
% outputVoltage: Output voltage the E3649A is currently generating
%
%
% EXAMPLE SYNTAX:
%
% outputVoltage = E3649A(5, 1, 10, 1);

% create a device object using RS232 protocol
hNICRio = hComm.hNICRio;
hAgilent = hComm.hAgilent;

lh = hNICRio.addlistener('DataAvailable', @(src,event)tempControl(src, event, hAgilent, desiredFloorTemp, desiredWallTemp)); 
fprintf(hAgilent,'OUTP ON');
hNICRio.startBackground();



