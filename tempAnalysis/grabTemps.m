function grabTemps(imbFile, roiXY_struct)
%% function makes 2 outputs of an imb file
% output 1: matrix of temp values
% output 2: structure of avg temp in each ROI in ROI struct
% the two are saved in one file in directory of imbFile

numROIs = length(roiXY_struct);
radius  = 5;
numLineSegs = 1000;
colorString = ['b', 'r', 'k', 'g' ];

%% process imb file into matrix of temp values
% get current file frame
 file=imbFile;
 data=fopen(file);
 f_header=fread(data, 10, 'int16');
 f_data=fread(data, [320 240], 'int16');
 IR_temp = (f_data+18000)/100;
 IR_temp = rot90(fliplr(IR_temp));   
 
 f1 = figure('Color','w');
 currFrame = imagesc(IR_temp);
 axis equal
 axis off
 caxis([15 80])
 pos=get(gca,'pos');
 cbar = colorbar('peer', gca, 'YLim', [15 80],'location','EastOutside' , 'Position', [0.9  0.35    0.0250    0.3420]);
 set(get(cbar,'ylabel'),'String', 'Temp')
 
 for bb = 1:numROIs
     [xi, yi] = circleXY([roiXY_struct(bb).x, roiXY_struct(bb).y], radius, numLineSegs);
     hold on
     plot(xi,yi,'k', 'LineWidth', 2, 'Color', colorString(bb))
     roimask = (poly2mask(xi,yi, size(IR_temp,1),size(IR_temp,2)));
     roiXY_struct(bb).tempVals = nanmean(IR_temp(roimask>0));
     valText = num2str(roiXY_struct(bb).tempVals);
     valText = valText(1:5);
     text(roiXY_struct(bb).x+10, roiXY_struct(bb).y, [valText '�C'], 'Color', 'w')
  end

%% save everything
nameInd = strfind(imbFile, '.imb');
name = imbFile(1:nameInd-1);

title(name, 'Color','k', 'FontSize', 20, 'interpreter', 'none')
save(['processed_file_' name], 'IR_temp', 'roiXY_struct')
export_fig(['processed_file_' name])
    
end
