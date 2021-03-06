path1       = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711095531_stimulusTest';
path1_num   = 6;
tempFile1    = '/Users/tj_florence/Desktop/local_data/VR_data/thermalImaging/thermal_data/2013-11-17/20131711095548_thermImgData/tempTrial_06.mat';

path2       = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-14/20131411205207_stimulusTest';
path2_num   = 3;
tempFile2   = '/Users/tj_florence/Desktop/local_data/VR_data/thermalImaging/thermal_data/2013-11-14/20131411215026_thermImgData/tempTrial_03.mat';

path3       = '/Users/tj_florence/Desktop/local_data/VR_data/2013-11-17/20131711024531_stimulusTest';
path3_num   = 4;
tempFile3   = '/Users/tj_florence/Desktop/local_data/VR_data/thermalImaging/thermal_data/2013-11-17/20131711024544_thermImgData/tempTrial_04.mat'; 

trialNum = path1_num;
experimentPath = path1;
tempFile = tempFile1;

cd(experimentPath)
expTrials = dir('env*');
load(expTrials(trialNum).name)
load(tempFile)


infoFile = dir('*info*');
load(infoFile.name)

f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.2 .2 .9 .9]);
%% trajectory figure
s1 = subplot(2,4, [1 2 5 6]);
ironCMAP = [
            46 255 224;...
            255 237 160;...
            255 237 160;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            255 255 255];
ironCMAP = (ironCMAP./255);
     
tempEnvInsert = data.tempEnv;
    for xx = 1:1800
        for yy = 1:1800
            if sqrt(((900-xx)^2) + ((900-yy)^2)) > 905
                tempEnvInsert(yy,xx) = 8;
            end
        end
    end
    
tempEnv = 8*ones([2400 2400]);
tempEnv(301:2100,301:2100) = tempEnvInsert;
    
imagesc((tempEnv))
set(gca, 'YDir', 'normal')
colormap(ironCMAP)
caxis([1 8])
axis equal off

hold on

plot(data.Xpos(1:data.count)+300, data.Ypos(1:data.count)+300, 'Color', 'k', 'LineWidth', 3)
%plot(data.Xpos(1:data.count)+300, data.Ypos(1:data.count)+300, 'Color', [155 85 255]./255, 'LineWidth', 2)

%% set temp & measured temp
s2 = subplot(2, 4, 3:4)
fill([0 30 30 0], [0 0 100 100],  [.8 .8 .8])
hold on
fixEnd = data.timeStamp(data.state_2_3_transition);
fill([30 fixEnd fixEnd 30], [0 0 100 100], [.2 .2 .9])
plot( tempData.timeStamp(1:tempData.count-1)-tempData.timeStamp(1), (tempData.setPoint(1:tempData.count-1)), 'k', 'LineWidth', 2 )
hold on
plot(tempData.timeStamp(1:tempData.count-1)-tempData.timeStamp(1), smooth(tempData.measuredTemp(1:tempData.count-1)), 'r', 'LineWidth', 3 )
box off

ylim([20 40])
xlim([0 250])

text(190, 38, 'set temp.', 'FontWeight', 'bold')
text(190, 37, 'measured temp', 'Color', 'r', 'FontWeight', 'bold')

s2_pos = get(s2, 'Position');
set(s2, 'Position', [s2_pos(1)-.02 s2_pos(2)-.235 s2_pos(3) s2_pos(4)])

ylabel('temp (�c)')
xlabel('time (s)')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/11162013')
export_fig(['temp_control_' num2str(trialNum)])