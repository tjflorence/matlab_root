expPath(1).laser = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_laser_1';
expPath(1).bath  = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_water_3';

expPath(2).laser = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_laser_2';
expPath(2).bath  = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_water_4';


expPath(3).laser = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_laser_4';
expPath(3).bath = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/bath_control/motion_sum_water_8';

%% total motion
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .5 .4])
shapesVec = ['csdp'];
offsetVec_1 = [-.15 -.05 .05 .1];
offsetVec_2 = offsetVec_1-.05;


hold on

for aa = 1:3
    
    cd(expPath(aa).laser)
    data_25 = dir('*25*');
    data_30 = dir('*30*');
    data_35 = dir('*35*');
    
    vec_25 = nan(1,5);
    vec_30 = nan(1,5);
    vec_35 = nan(1,5);
    
    for bb = 1:5
        
        load(data_25(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_25(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;

        load(data_30(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_30(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;

        
        load(data_35(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_35(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;
        
    end
       
    
    mean_25    = mean(vec_25);
    sqrt_25    = std(vec_25)/sqrt(5);
    
    mean_30    = mean(vec_30);
    sqrt_30    = std(vec_30)/sqrt(5);
    
    mean_35    = mean(vec_35);
    sqrt_35    = std(vec_35)/sqrt(5);
    
    errorbar([1]+offsetVec_1(aa),[ mean_25], [sqrt_25], 'Color', 'r', 'LineWidth', 2)
    errorbar([2]+offsetVec_1(aa),[ mean_30], [sqrt_30], 'Color', 'r', 'LineWidth', 2)
    errorbar([3]+offsetVec_1(aa),[ mean_35], [sqrt_35], 'Color', 'r', 'LineWidth', 2)

    hold on
    z1 = scatter([1:3]+offsetVec_1(aa), [mean_25 mean_30 mean_35], 200, shapesVec(aa));
    set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
    
    
    cd(expPath(aa).bath)
    data_25 = dir('*25*');
    data_30 = dir('*30*');
    data_35 = dir('*35*');
    
    vec_25 = nan(1,5);
    vec_30 = nan(1,5);
    vec_35 = nan(1,5);
    
    for bb = 1:5
        
        load(data_25(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_25(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;

        load(data_30(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_30(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;

        
        load(data_35(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        vec_35(bb) =  (abs(vFwd)+abs(vSS)+abs(vOm))/10/3.6;
        
    end
       
    
    
    mean_25    = mean(vec_25);
    sqrt_25    = std(vec_25)/sqrt(5);
    
    mean_30    = mean(vec_30);
    sqrt_30    = std(vec_30)/sqrt(5);
    
    mean_35    = mean(vec_35);
    sqrt_35    = std(vec_35)/sqrt(5);
    
    errorbar([1]+offsetVec_2(aa),[ mean_25], [sqrt_25], 'Color', 'b', 'LineWidth', 2)
    errorbar([2]+offsetVec_2(aa),[ mean_30], [sqrt_30], 'Color', 'b', 'LineWidth', 2)
    errorbar([3]+offsetVec_2(aa),[ mean_35], [sqrt_35], 'Color', 'b', 'LineWidth', 2)
    hold on
    z1 = scatter([1:3]+offsetVec_2(aa), [mean_25 mean_30 mean_35], 200, shapesVec(aa));
    set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
    
    
    
    
    

end

xlim([.5 3.5])
xlabel('temperature (°C)', 'FontSize', 20)
ylabel('ball speed (mm/sec)', 'Fontsize', 20)
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'}, 'FontSize', 16)

text(1, 14, 'water bath', 'Color', 'b', 'Fontweight', 'bold', 'FontSize', 18)
text(1, 12, 'water bath + laser', 'Color', 'r', 'Fontweight', 'bold', 'FontSize', 18)
box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/')
export_fig('rotation_fcn_temp')

%% fraction forward
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .5 .4])
shapesVec = ['csdp'];
offsetVec_1 = [-.15 -.05 .05 .1];
offsetVec_2 = offsetVec_1-.05;

plot([-100 100], [0 0], 'Color', 'k', 'LineWidth', 1)
hold on


for aa = 1:3
    
    cd(expPath(aa).laser)
    data_25 = dir('*25*');
    data_30 = dir('*30*');
    data_35 = dir('*35*');
    
    vec_25 = nan(1,5);
    vec_30 = nan(1,5);
    vec_35 = nan(1,5);
    
    for bb = 1:5
        
        load(data_25(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_25(bb) = fracFwd;
        
        load(data_30(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_30(bb) = fracFwd;
        
        load(data_35(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_35(bb) = fracFwd;
        
    end
    
    mean_25    = nanmean(vec_25);
    sqrt_25    = nanstd(vec_25)/sqrt(5);
    
    mean_30    = nanmean(vec_30);
    sqrt_30    = nanstd(vec_30)/sqrt(5);
    
    mean_35    = nanmean(vec_35);
    sqrt_35    = nanstd(vec_35)/sqrt(5);
    
    errorbar([1]+offsetVec_1(aa),[ mean_25], [sqrt_25], 'Color', 'r', 'LineWidth', 2)
    errorbar([2]+offsetVec_1(aa),[ mean_30], [sqrt_30], 'Color', 'r', 'LineWidth', 2)
    errorbar([3]+offsetVec_1(aa),[ mean_35], [sqrt_35], 'Color', 'r', 'LineWidth', 2)
    hold on
    
    z1 = scatter([1:3]+offsetVec_1(aa), [mean_25 mean_30 mean_35], 200, shapesVec(aa));
    set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
     
    cd(expPath(aa).bath)
    data_25 = dir('*25*');
    data_30 = dir('*30*');
    data_35 = dir('*35*');
    
    vec_25 = nan(1,5);
    vec_30 = nan(1,5);
    vec_35 = nan(1,5);
    
    for bb = 1:5
        
        load(data_25(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_25(bb) = fracFwd;
        
        load(data_30(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_30(bb) = fracFwd;
        
        load(data_35(bb).name)
        vFwd = nansum(trial_data.Vfwd(1:trial_data.count))*.7071;
        vSS  = nansum(trial_data.Vss(1:trial_data.count))*.7071;
        vOm  = nansum(trial_data.Om(1:trial_data.count))/2;
        fracFwd = vFwd/(abs(vFwd)+abs(vSS)+abs(vOm));
        vec_35(bb) = fracFwd;
        
    end
    

    mean_25    = nanmean(vec_25);
    sqrt_25    = nanstd(vec_25)/sqrt(5);
    
    mean_30    = nanmean(vec_30);
    sqrt_30    = nanstd(vec_30)/sqrt(5);
    
    mean_35    = nanmean(vec_35);
    sqrt_35    = nanstd(vec_35)/sqrt(5);
    

    errorbar([1]+offsetVec_2(aa),[ mean_25], [sqrt_25], 'Color', 'b', 'LineWidth', 2)
    errorbar([2]+offsetVec_2(aa),[ mean_30], [sqrt_30], 'Color', 'b', 'LineWidth', 2)
    errorbar([3]+offsetVec_2(aa),[ mean_35], [sqrt_35], 'Color', 'b', 'LineWidth', 2)
    hold on
    z1 = scatter([1:3]+offsetVec_2(aa), [mean_25 mean_30 mean_35], 200, shapesVec(aa));
    set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
    
    
    
end

xlim([.5 3.5])
xlabel('temperature (°C)', 'FontSize', 20)
ylabel('fraction vFwd (vFwd / \Sigma Rotation)', 'Fontsize', 20)
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'}, 'FontSize', 16)

text(1, .8, 'water bath', 'Color', 'b', 'Fontweight', 'bold', 'FontSize', 18)
text(1, .7, 'water bath + laser', 'Color', 'r', 'Fontweight', 'bold', 'FontSize', 18)
box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04232014/')
export_fig('frac_fwd_fcn_tmp')