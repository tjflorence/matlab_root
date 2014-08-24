function initializeCamera4LED(ip, port, frameRate, triggerMode, ROI)
% setConfigTest: a simple example demonstrating how to set and get the BIAS 
% configuration using http requests from Matlab. In this example the frameRate 
% property of the camera is set to 30 Hz. Note, the server must be enabled
% and the camera must be connected.
%
% Usage:  setConfigTest('127.0.0.1', 5010)
%
% ------------------------------------------------------------------------
baseUrl = sprintf('http://%s:%d',ip,port);

% Create and set get-configuration command 
getConfigCmd = sprintf('%s/?get-configuration',baseUrl);
rspString = urlread(getConfigCmd);

% Parse response and remove get configuration structure
rspStruct = loadjson(rspString);
if rspStruct.success == false
    error('Failed to get BIAS configuration: %s', rspStruct.message);
end
configStruct = rspStruct.value;


%default setting for the olfactory arena project
configStruct.logging.format = 'avi';
configStruct.logging.settings.avi.frameSkip = 1;


% Set frame rate if configuration structure - note to use absolute value 
% asbolute control must be enabled (set to true). 
configStruct.camera.properties.frameRate.absoluteControl = 1;
configStruct.camera.properties.frameRate.autoActive = 0;
configStruct.camera.properties.frameRate.absoluteValue = frameRate;

%trigger mode is either internal or external 
if strncmpi(triggerMode, 'ex', 2)
    configStruct.camera.triggerType = 'External';
else
    configStruct.camera.triggerType = 'Internal';
end

%set ROI
configStruct.camera.format7Setting.roi.offsetX = ROI(1);
configStruct.camera.format7Setting.roi.offsetY = ROI(2);
configStruct.camera.format7Setting.roi.width = ROI(3);
configStruct.camera.format7Setting.roi.height = ROI(4);

% Create set-configuration command and remove pretty printing. Note, there
% doesn't seem to be any way to turn off pretty printing w/ jsonlab. 
configString = savejson('',configStruct);
configString = strrep(configString,sprintf('\n'), ''); 
configString = strrep(configString,sprintf('\t'), ''); 
setConfigCmd = sprintf('%s/?set-configuration=%s',baseUrl, configString);

% Send set-configuration command and parse response
rspString = urlread(setConfigCmd);
rspStruct = loadjson(rspString);

if rspStruct.success == true
    fprintf('BIAS configuration set successfully\n');
else
    fprintf('Failed to set BIAS configuration: %s\n', rspStruct.message);
end






