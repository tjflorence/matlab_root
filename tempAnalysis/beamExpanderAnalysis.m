
cd('/Users/tj_florence/Desktop/thermalAnalysis/laserCycleColumator')
mkdir('analysisFrame')

%% 
files=dir('*.imb');
numFiles = length(files);

for aa = 1:numFiles
    % get current file frame
    file=[files(aa).name];
    data=fopen(file);
    f_header=fread(data, 10, 'int16');
    f_data=fread(data, [320 240], 'int16');
    IR_temp = (f_data+18000)/100;
    
    currFrame = image(IR_temp) 
    pause(.05)
end