data_dir = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05022014/black_ball/'
cd(data_dir)

tether_exps     = dir('*black_no*');
headfix_exps    = dir('*white_no*');
plate_exps      = dir('*white_yes*');
water_exps      = dir('*black_yes*');
old_exps        = dir('*old*');

num_tether  = length(tether_exps);
num_headfix = length(headfix_exps);
num_plate   = length(plate_exps);
num_water   = length(water_exps);
num_old     = length(old_exps);

dummyStruct.temp_25_total = [];
dummyStruct.temp_30_total = [];
dummyStruct.temp_35_total = [];
dummyStruct.temp_25_str = [];
dummyStruct.temp_30_str = [];
dummyStruct.temp_35_str = [];
dummyStruct.temp_25_total_sem = [];
dummyStruct.temp_30_total_sem = [];
dummyStruct.temp_35_total_sem = [];
dummyStruct.temp_25_str_sem = [];
dummyStruct.temp_30_str_sem = [];
dummyStruct.temp_35_str_sem = [];

tether_data = dummyStruct;
headfix_data = dummyStruct;
plate_data = dummyStruct;
water_data = dummyStruct;
old_data = dummyStruct;

tempsToFind = [25 30 35];

for aa = 1:num_tether
   
    cd(tether_exps(aa).name)
    
    lastTrial = dir('*5temp*');
        
        for cc = 1:3          
 
               dataToLoad = dir(['*temp_' num2str(tempsToFind(cc)) '*']);
               meanVal_total = [];
               meanVal_fwd   = [];
               
               for bb = 1:length(dataToLoad)
                   
                load(dataToLoad(bb).name)
               
                totalSumRotation = sum(abs(trial_data.Vfwd(1:trial_data.count))*.7071) ...
                                + sum(abs(trial_data.Vss(1:trial_data.count))/2) ...
                                + sum(abs(trial_data.Om(1:trial_data.count))*.7071);
                            
                fr_fwd          = sum(trial_data.Vfwd(1:trial_data.count)*.7071)/totalSumRotation;
                
                totalSumRotation_cal = totalSumRotation/3.6;
                meanVal_total = [meanVal_total; totalSumRotation_cal];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_fwd)/sqrt(numel(meanVal_fwd));
               
              if cc == 1
                   tether_data.temp_25_total     = [tether_data.temp_25_total meanVal_total_toStore];
                   tether_data.temp_25_total_sem = [tether_data.temp_25_total_sem semVal_total_toStore];
                   tether_data.temp_25_str       = [tether_data.temp_25_str meanVal_fwd_toStore];
                   tether_data.temp_25_str_sem   = [tether_data.temp_25_str_sem semVal_fwd_toStore];

               elseif cc == 2
                        tether_data.temp_30_total     = [tether_data.temp_30_total meanVal_total_toStore];
                   tether_data.temp_30_total_sem = [tether_data.temp_30_total_sem semVal_total_toStore];
                   tether_data.temp_30_str       = [tether_data.temp_30_str meanVal_fwd_toStore];
                   tether_data.temp_30_str_sem   = [tether_data.temp_30_str_sem semVal_fwd_toStore];

               elseif cc == 3
                    tether_data.temp_35_total     = [tether_data.temp_35_total meanVal_total_toStore];
                   tether_data.temp_35_total_sem = [tether_data.temp_35_total_sem semVal_total_toStore];
                   tether_data.temp_35_str       = [tether_data.temp_35_str meanVal_fwd_toStore];
                   tether_data.temp_35_str_sem   = [tether_data.temp_35_str_sem semVal_fwd_toStore];
                   
               end
               
               
        end
               

       
   % end
    
    cd(data_dir)
    
end

for aa = 1:num_headfix
   
    cd(headfix_exps(aa).name)
    
    lastTrial = dir('*5temp*');
        
        for cc = 1:3          
 
               dataToLoad = dir(['*temp_' num2str(tempsToFind(cc)) '*']);
               meanVal_total = [];
               meanVal_fwd   = [];
               
               for bb = 1:length(dataToLoad)
                   
                load(dataToLoad(bb).name)
               
                totalSumRotation = sum(abs(trial_data.Vfwd(1:trial_data.count))*.7071) ...
                                + sum(abs(trial_data.Vss(1:trial_data.count))/2) ...
                                + sum(abs(trial_data.Om(1:trial_data.count))*.7071);
                            
                fr_fwd          = sum(trial_data.Vfwd(1:trial_data.count)*.7071)/totalSumRotation;
                totalSumRotation_cal = totalSumRotation/3.6;
                meanVal_total = [meanVal_total; totalSumRotation_cal];
                
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_fwd)/sqrt(numel(meanVal_fwd));
               
              if cc == 1
                   headfix_data.temp_25_total     = [headfix_data.temp_25_total meanVal_total_toStore];
                   headfix_data.temp_25_total_sem = [headfix_data.temp_25_total_sem semVal_total_toStore];
                   headfix_data.temp_25_str       = [headfix_data.temp_25_str meanVal_fwd_toStore];
                   headfix_data.temp_25_str_sem   = [headfix_data.temp_25_str_sem semVal_fwd_toStore];

               elseif cc == 2
                        headfix_data.temp_30_total     = [headfix_data.temp_30_total meanVal_total_toStore];
                   headfix_data.temp_30_total_sem = [headfix_data.temp_30_total_sem semVal_total_toStore];
                   headfix_data.temp_30_str       = [headfix_data.temp_30_str meanVal_fwd_toStore];
                   headfix_data.temp_30_str_sem   = [headfix_data.temp_30_str_sem semVal_fwd_toStore];

               elseif cc == 3
                    headfix_data.temp_35_total     = [headfix_data.temp_35_total meanVal_total_toStore];
                   headfix_data.temp_35_total_sem = [headfix_data.temp_35_total_sem semVal_total_toStore];
                   headfix_data.temp_35_str       = [headfix_data.temp_35_str meanVal_fwd_toStore];
                   headfix_data.temp_35_str_sem   = [headfix_data.temp_35_str_sem semVal_fwd_toStore];
                   
               end
               
               
               
               
        end
               

       
   % end
    
    cd(data_dir)
    
end

for aa = 1:num_plate
   
    cd(plate_exps(aa).name)
    
    lastTrial = dir('*5temp*');
        
        for cc = 1:3          
 
               dataToLoad = dir(['*temp_' num2str(tempsToFind(cc)) '*']);
               meanVal_total = [];
               meanVal_fwd   = [];
               
               for bb = 1:length(dataToLoad)
                   
                load(dataToLoad(bb).name)
               
                totalSumRotation = sum(abs(trial_data.Vfwd(1:trial_data.count))*.7071) ...
                                + sum(abs(trial_data.Vss(1:trial_data.count))/2) ...
                                + sum(abs(trial_data.Om(1:trial_data.count))*.7071);
                            
                fr_fwd          = sum(trial_data.Vfwd(1:trial_data.count)*.7071)/totalSumRotation;
                totalSumRotation_cal = totalSumRotation/3.6;
                meanVal_total = [meanVal_total; totalSumRotation_cal];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_fwd)/sqrt(numel(meanVal_fwd));
               
              if cc == 1
                   plate_data.temp_25_total     = [plate_data.temp_25_total meanVal_total_toStore];
                   plate_data.temp_25_total_sem = [plate_data.temp_25_total_sem semVal_total_toStore];
                   plate_data.temp_25_str       = [plate_data.temp_25_str meanVal_fwd_toStore];
                   plate_data.temp_25_str_sem   = [plate_data.temp_25_str_sem semVal_fwd_toStore];

               elseif cc == 2
                        plate_data.temp_30_total     = [plate_data.temp_30_total meanVal_total_toStore];
                   plate_data.temp_30_total_sem = [plate_data.temp_30_total_sem semVal_total_toStore];
                   plate_data.temp_30_str       = [plate_data.temp_30_str meanVal_fwd_toStore];
                   plate_data.temp_30_str_sem   = [plate_data.temp_30_str_sem semVal_fwd_toStore];

               elseif cc == 3
                    plate_data.temp_35_total     = [plate_data.temp_35_total meanVal_total_toStore];
                   plate_data.temp_35_total_sem = [plate_data.temp_35_total_sem semVal_total_toStore];
                   plate_data.temp_35_str       = [plate_data.temp_35_str meanVal_fwd_toStore];
                   plate_data.temp_35_str_sem   = [plate_data.temp_35_str_sem semVal_fwd_toStore];
                   
               end
               
               
               
               
        end
               

       
   % end
    
    cd(data_dir)
    
end

for aa = 1:num_water
   
    cd(water_exps(aa).name)
    
    lastTrial = dir('*5temp*');
        
        for cc = 1:3          
 
               dataToLoad = dir(['*temp_' num2str(tempsToFind(cc)) '*']);
               meanVal_total = [];
               meanVal_fwd   = [];
               
               for bb = 1:length(dataToLoad)
                   
                load(dataToLoad(bb).name)
               
                totalSumRotation = sum(abs(trial_data.Vfwd(1:trial_data.count))*.7071) ...
                                + sum(abs(trial_data.Vss(1:trial_data.count))/2) ...
                                + sum(abs(trial_data.Om(1:trial_data.count))*.7071);
                            
                fr_fwd          = sum(trial_data.Vfwd(1:trial_data.count)*.7071)/totalSumRotation;
                totalSumRotation_cal = totalSumRotation/3.6;
                meanVal_total = [meanVal_total; totalSumRotation_cal];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_fwd)/sqrt(numel(meanVal_fwd));
               
              if cc == 1
                   water_data.temp_25_total     = [water_data.temp_25_total meanVal_total_toStore];
                   water_data.temp_25_total_sem = [water_data.temp_25_total_sem semVal_total_toStore];
                   water_data.temp_25_str       = [water_data.temp_25_str meanVal_fwd_toStore];
                   water_data.temp_25_str_sem   = [water_data.temp_25_str_sem semVal_fwd_toStore];

               elseif cc == 2
                        water_data.temp_30_total     = [water_data.temp_30_total meanVal_total_toStore];
                   water_data.temp_30_total_sem = [water_data.temp_30_total_sem semVal_total_toStore];
                   water_data.temp_30_str       = [water_data.temp_30_str meanVal_fwd_toStore];
                   water_data.temp_30_str_sem   = [water_data.temp_30_str_sem semVal_fwd_toStore];

               elseif cc == 3
                    water_data.temp_35_total     = [water_data.temp_35_total meanVal_total_toStore];
                   water_data.temp_35_total_sem = [water_data.temp_35_total_sem semVal_total_toStore];
                   water_data.temp_35_str       = [water_data.temp_35_str meanVal_fwd_toStore];
                   water_data.temp_35_str_sem   = [water_data.temp_35_str_sem semVal_fwd_toStore];
                   
               end
               
               
               
               
        end
               

       
   % end
    
    cd(data_dir)
    
end

for aa = 1:num_old
   
    cd(old_exps(aa).name)
    
    lastTrial = dir('*5temp*');
        
        for cc = 1:3          
 
               dataToLoad = dir(['*temp_' num2str(tempsToFind(cc)) '*']);
               meanVal_total = [];
               meanVal_fwd   = [];
               
               for bb = 1:length(dataToLoad)
                   
                load(dataToLoad(bb).name)
               
                totalSumRotation = sum(abs(trial_data.Vfwd(1:trial_data.count))*.7071) ...
                                + sum(abs(trial_data.Vss(1:trial_data.count))/2) ...
                                + sum(abs(trial_data.Om(1:trial_data.count))*.7071);
                            
                fr_fwd          = sum(trial_data.Vfwd(1:trial_data.count)*.7071)/totalSumRotation;
                totalSumRotation_cal = totalSumRotation/3.6;
                meanVal_total = [meanVal_total; totalSumRotation_cal];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_fwd)/sqrt(numel(meanVal_fwd));
               
              if cc == 1
                   old_data.temp_25_total     = [old_data.temp_25_total meanVal_total_toStore];
                   old_data.temp_25_total_sem = [old_data.temp_25_total_sem semVal_total_toStore];
                   old_data.temp_25_str       = [old_data.temp_25_str meanVal_fwd_toStore];
                   old_data.temp_25_str_sem   = [old_data.temp_25_str_sem semVal_fwd_toStore];

               elseif cc == 2
                        old_data.temp_30_total     = [old_data.temp_30_total meanVal_total_toStore];
                   old_data.temp_30_total_sem = [old_data.temp_30_total_sem semVal_total_toStore];
                   old_data.temp_30_str       = [old_data.temp_30_str meanVal_fwd_toStore];
                   old_data.temp_30_str_sem   = [old_data.temp_30_str_sem semVal_fwd_toStore];

               elseif cc == 3
                    old_data.temp_35_total     = [old_data.temp_35_total meanVal_total_toStore];
                   old_data.temp_35_total_sem = [old_data.temp_35_total_sem semVal_total_toStore];
                   old_data.temp_35_str       = [old_data.temp_35_str meanVal_fwd_toStore];
                   old_data.temp_35_str_sem   = [old_data.temp_35_str_sem semVal_fwd_toStore];
                   
               end
               
               
               
               
        end
               

       
   % end
    
    cd(data_dir)
    
end



cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014')

%% make plot
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .4 .4])

    
for aa = 1:length(plate_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(.85+(randVal), plate_data.temp_25_total(aa)./10, plate_data.temp_25_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(.85+(randVal), plate_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(1.85+(randVal), plate_data.temp_30_total(aa)./10, plate_data.temp_30_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(1.85+(randVal), plate_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.85+(randVal), plate_data.temp_35_total(aa)./10, plate_data.temp_35_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(2.85+(randVal), plate_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
end

for aa = 1:length(water_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(1.25+(randVal), water_data.temp_25_total(aa)./10, water_data.temp_25_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(1.25+(randVal), water_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.25+(randVal), water_data.temp_30_total(aa)./10, water_data.temp_30_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(2.25+(randVal), water_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(3.25+(randVal), water_data.temp_35_total(aa)./10, water_data.temp_35_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(3.25+(randVal), water_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
end



xlim([.5 3.5])
xlabel('head temp (�C)', 'FontSize', 14)
ylabel('\Sigma Rotation  (mm / sec)', 'Fontsize', 14)
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'},  'FontSize', 14)


z1 = scatter(1,20, 200)
set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
text(1.08, 20, 'white ball')

z1 = scatter(1,19, 200)
set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
text(1.08, 19, 'black ball')




box off
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05122014/')
export_fig('motion_as_fcn_of_observed_temp', '-pdf')

%% make plot
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .4 .4])
plot([-100  100], [0 0], 'k')
hold on



    
for aa = 1:length(plate_data.temp_25_str)
    randVal = .02*randn(1);
    errorbar(.85+(randVal), plate_data.temp_25_str(aa) , plate_data.temp_25_str_sem(aa) , 'k');
    hold on
    z1 = scatter(.85+(randVal), plate_data.temp_25_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(1.85+(randVal), plate_data.temp_30_str(aa) , plate_data.temp_30_str_sem(aa) , 'k');
    hold on
    z1 = scatter(1.85+(randVal), plate_data.temp_30_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.85+(randVal), plate_data.temp_35_str(aa) , plate_data.temp_35_str_sem(aa) , 'k');
    hold on
    z1 = scatter(2.85+(randVal), plate_data.temp_35_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
end

for aa = 1:length(water_data.temp_25_str)
    randVal = .02*randn(1);
    errorbar(1.25+(randVal), water_data.temp_25_str(aa) , water_data.temp_25_str_sem(aa) , 'k');
    hold on
    z1 = scatter(1.25+(randVal), water_data.temp_25_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.25+(randVal), water_data.temp_30_str(aa) , water_data.temp_30_str_sem(aa) , 'k');
    hold on
    z1 = scatter(2.25+(randVal), water_data.temp_30_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(3.25+(randVal), water_data.temp_35_str(aa) , water_data.temp_35_str_sem(aa) , 'k');
    hold on
    z1 = scatter(3.25+(randVal), water_data.temp_35_str(aa) , 200);
    set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
end



xlim([.5 3.5])
xlabel('head temp (�C)', 'FontSize', 14)
ylabel('Fraction Vfwd  (Vfwd / \Sigma Rotation)', 'Fontsize', 14)

set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'},  'FontSize', 14)


z1 = scatter(1,.42, 200)
set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
text(1.08, .42, 'white ball')

z1 = scatter(1,.40, 200)
set(z1, 'MarkerFaceColor', 'k', 'MarkerEdgeColor', 'k')
text(1.08, .40, 'black ball')

box off
cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05122014/')
export_fig('Vfwd_as_fcn_of_observed_temp', '-pdf')



