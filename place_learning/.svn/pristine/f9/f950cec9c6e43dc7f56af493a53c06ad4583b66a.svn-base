function saveLoadConfigTest(ip,port,configFile)
% saveLoadConfigTest: a simple example demonstating how to use the save and
% load configuration http request from Matlab.
%
% Usage Example: 
%
% saveLoadConfigTest('127.0.0.1', 5010,'C:\Users\wbd\Documents\test_config.json')
%
% -------------------------------------------------------------------------
baseUrl = sprintf('http://%s:%d',ip,port);

% Create save-configuration command and send http request 
saveCmd = sprintf('%s/?save-configuration=%s',baseUrl,configFile);
rspString = urlread(saveCmd);
rspStruct = loadjson(rspString);
if rspStruct.success == false
    error('Failed to save BIAS configuration: %s', rspStruct.message);
else
    fprintf('Configuration saved to: %s\n', configFile);
end

% Create load-configuration command and send http request
loadCmd = sprintf('%s/?load-configuration=%s',baseUrl,configFile);
rspString = urlread(loadCmd);
rspStruct = loadjson(rspString);
if rspStruct.success == false
    error('Failed to load BIAS configuration: %s', rspStruct.message);
else
    fprintf('Configuration loaded from: %s\n', configFile);
end



