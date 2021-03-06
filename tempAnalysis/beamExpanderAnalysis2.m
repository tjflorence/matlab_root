
cd('/Users/tj_florence/Desktop/thermalAnalysis/laserCycleColumator')
frameDir = pwd;
mkdir('analysisFrame')

%% 
files=dir('*.imb');
numFiles = length(files);

leadingZeros = 5
colorString = ['k', 'r', 'b']
ROI(1).x = 186;
ROI(1).y = 136;
ROI(1).radius = 10;
ROI(1).vals = []

ROI(2).x = 216;
ROI(2).y = 123;
ROI(2).radius = 10;
ROI(2).vals = []

%ROI(3).x = 82;
%ROI(3).y = 126;
%RIO(3).radius = 10;
%ROI(3).vals = []

ROI(3).x = 82;
ROI(3).y = 126;
ROI(3).radius = 10;
ROI(3).vals = []

numLineSegs =  100;
for aa = 1:numFiles
    hFig = figure(1);
    set(hFig, 'Position', [100 0  700 700])
    subplot(2,1,2)
    % get current file frame
    file=[files(aa).name];
    data=fopen(file);
    f_header=fread(data, 10, 'int16');
    f_data=fread(data, [320 240], 'int16');
    IR_temp = (f_data+18000)/100;
    IR_temp = flipud(rot90(IR_temp));
    
    currFrame = imagesc(IR_temp);
    axis equal
    axis off
    caxis([24 46])
    pos=get(gca,'pos');
    cbar = colorbar('peer', gca, 'YLim', [24 46],'location','EastOutside' , 'Position', [0.75  0.11    0.0250    0.3420]);
    
    set(get(cbar,'ylabel'),'String', 'Temp')
    
    % get ROI data
    
    for bb = 1:length(ROI)
        [xi, yi] = circleXY([ROI(bb).x, ROI(bb).y], ROI(bb).radius, numLineSegs);
        hold on
        plot(xi,yi,'k', 'LineWidth', 2, 'Color', colorString(bb))
        roimask = (poly2mask(xi,yi, size(IR_temp,1),size(IR_temp,2)));
        ROI(bb).vals = [ROI(bb).vals nanmean(IR_temp(roimask>0))];
    end
    
    hold on
    
       subplot(2,1,1)
    for cc = 1:length(ROI)
        
        plot(ROI(cc).vals, colorString(cc), 'LineWidth',2)
        hold on
        
    end
    xlim([0 numFiles])
    ylim([22 46])
    xlabel('frame')
    ylabel('temp')
    
    cd('analysisFrame')
    saveDigits = length(num2str(aa));
    zerosToSave = zeros(1,leadingZeros-saveDigits)
    saveFrameNum = num2str(aa);
    zerosToSave = num2str(zerosToSave);
    zerosToSave = zerosToSave(~isspace(zerosToSave))
    export_fig(['frame_' zerosToSave saveFrameNum], '-pdf')
    
    cd(frameDir)
    close all   
end

