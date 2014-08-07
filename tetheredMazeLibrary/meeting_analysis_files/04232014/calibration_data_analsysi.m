cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/calibration_data/calibration_V_ss_time_10_exp3/')
dataFiles = dir('raw*');
ss_calib_factor = nan(1,length(dataFiles));

for aa = 1:length(dataFiles)
    load(dataFiles(aa).name)
    
    vSS = abs(sum(data.y0(1:data.count))-sum(data.y1(1:data.count)))*.7071/(pi*90);
    
    vFwd = abs(sum(data.y0(1:data.count))+sum(data.y1(1:data.count)))*.7071/(pi*90);
    
    vOm  = abs(sum((data.x0(1:data.count)+data.x1(1:data.count)))*.5/(pi*90));
    
    ss_calib_factor(aa) = vSS+vOm+vFwd;
    
end

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/calibration_data/calibration_V_om_time_10_exp2/')
dataFiles = dir('raw*');
om_calib_factor = nan(1,length(dataFiles));

for aa = 1:length(dataFiles)
    load(dataFiles(aa).name)
   
    vSS = abs(sum(data.y0(1:data.count))-sum(data.y1(1:data.count)))*.7071/(pi*90);
    
    vFwd = abs(sum(data.y0(1:data.count))+sum(data.y1(1:data.count)))*.7071/(pi*90);
    
    vOm  = abs(sum((data.x0(1:data.count)+data.x1(1:data.count)))*.5/(pi*90));
    
    om_calib_factor(aa) = vOm+vSS+vFwd;
end




f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .4 .4])
for aa = 1:numel(ss_calib_factor)
    z1 = scatter(1+ .1*randn(1), ss_calib_factor(aa), 200)
    set(z1, 'markerFaceColor', 'r', 'markeredgecolor', 'k')
    hold on
end

for aa = 1:numel(om_calib_factor)
    z1 = scatter(2+.1*randn(1), om_calib_factor(aa), 200)
    set(z1, 'markerFaceColor', 'b', 'markeredgecolor', 'k')
    hold on
end

ylim([2.5 5])
xlim([.5 2.5])
set(gca, 'XTick', [1 2], 'XTickLabel', {'Roll (Vss)', 'Yaw (Vom)'}, 'FontSize', 30, 'YTick', [3 4 5], 'YTickLabel', {'   3', '   4', '   5'})
xlabel('Motion Vector')
ylabel('Calibration Factor (ticks/mm)')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/')
export_fig('calibration_values', '-pdf')