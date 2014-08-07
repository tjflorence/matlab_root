data_dir = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014/behavior_data/'
cd(data_dir)

tether_exps     = dir('*tether*');
headfix_exps    = dir('*headfix*');
plate_exps      = dir('*plate*');
water_exps      = dir('*water*');

num_tether  = length(tether_exps);
num_headfix = length(headfix_exps);
num_plate   = length(plate_exps);
num_water   = length(water_exps);

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
                
                meanVal_total = [meanVal_total; totalSumRotation];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               
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
                
                meanVal_total = [meanVal_total; totalSumRotation];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               
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
                
                meanVal_total = [meanVal_total; totalSumRotation];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               
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
                
                meanVal_total = [meanVal_total; totalSumRotation];
                meanVal_fwd   = [meanVal_fwd; fr_fwd];
               end
               
               meanVal_total_toStore = nanmean(meanVal_total);
               semVal_total_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               meanVal_fwd_toStore   = nanmean(meanVal_fwd);
               semVal_fwd_toStore  = nanstd(meanVal_total)/sqrt(numel(meanVal_total));
               
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
    
    cd(data_dir)
    
end


cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014')

%% make plot
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .4 .4])

for aa = 1:length(tether_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(.75+(randVal), tether_data.temp_25_total(aa)./10, tether_data.temp_25_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(.75+(randVal), tether_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(1.75+(randVal), tether_data.temp_30_total(aa)./10, tether_data.temp_30_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(1.75+(randVal), tether_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.75+(randVal), tether_data.temp_35_total(aa)./10, tether_data.temp_35_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(2.75+(randVal), tether_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
end



for aa = 1:length(headfix_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(.86+(randVal), headfix_data.temp_25_total(aa)./10, headfix_data.temp_25_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(.86+(randVal), headfix_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(1.86+(randVal), headfix_data.temp_30_total(aa)./10, headfix_data.temp_30_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(1.86+(randVal), headfix_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
    
    randVal = .02*randn(1);
    errorbar(2.86+(randVal), headfix_data.temp_35_total(aa)./10, headfix_data.temp_35_total_sem(aa)/10, 'k');
    hold on
    z1 = scatter(2.86+(randVal), headfix_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', 'w', 'MarkerEdgeColor', 'k')
end

    
for aa = 1:length(plate_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(1.15+(randVal), plate_data.temp_25_total(aa)./10, plate_data.temp_25_total_sem(aa)/10, 'r');
    hold on
    z1 = scatter(1.15+(randVal), plate_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [1 .2 .2], 'MarkerEdgeColor', 'r')
    
    randVal = .02*randn(1);
    errorbar(2.15+(randVal), plate_data.temp_30_total(aa)./10, plate_data.temp_30_total_sem(aa)/10, 'r');
    hold on
    z1 = scatter(2.15+(randVal), plate_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [1 .2 .2], 'MarkerEdgeColor', 'r')
    
    randVal = .02*randn(1);
    errorbar(3.15+(randVal), plate_data.temp_35_total(aa)./10, plate_data.temp_35_total_sem(aa)/10, 'r');
    hold on
    z1 = scatter(3.15+(randVal), plate_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [1 .2 .2], 'MarkerEdgeColor', 'r')
end


for aa = 1:length(water_data.temp_25_total)
    randVal = .02*randn(1);
    errorbar(1.25+(randVal), water_data.temp_25_total(aa)./10, water_data.temp_25_total_sem(aa)/10, 'b');
    hold on
    z1 = scatter(1.25+(randVal), water_data.temp_25_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 1], 'MarkerEdgeColor', 'b')
    
    randVal = .02*randn(1);
    errorbar(2.25+(randVal), water_data.temp_30_total(aa)./10, water_data.temp_30_total_sem(aa)/10, 'b');
    hold on
    z1 = scatter(2.25+(randVal), water_data.temp_30_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 1], 'MarkerEdgeColor', 'b')
    
    randVal = .02*randn(1);
    errorbar(3.25+(randVal), water_data.temp_35_total(aa)./10, water_data.temp_35_total_sem(aa)/10, 'b');
    hold on
    z1 = scatter(3.25+(randVal), water_data.temp_35_total(aa)./10, 200);
    set(z1, 'MarkerFaceColor', [.2 .2 1], 'MarkerEdgeColor', 'b')
end


z1 = scatter(3.1, 100);
set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
text(3.15, 100, 'tether')

z1 = scatter(3.1, 96);
set(z1, 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', 'k')
text(3.15, 96, 'tether+headfix')

z1 = scatter(3.1, 92);
set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
text(3.15, 92, 'phys plate')

z1 = scatter(3.1, 88);
set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
text(3.15, 88, 'phys plate+water')

xlim([.5 3.5])
ylim([0 100])
xlabel('head temp (°C)', 'FontSize', 14)
ylabel('\Sigma Rotation / sec', 'Fontsize', 14)
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'}, 'YTick', [30 60 90], 'YTickLabel', {30 60 90}, 'FontSize', 14)

box off
export_fig('motion_as_fcn_of_observed_temp', '-pdf')


%% make plot 2: fraction of movement forward
f1 = figure('Color', 'w', 'units', 'normalized', 'Position',  [.1 .1 .6 .6])

plot([-100 100], [0 0], 'k')
hold on

for aa = 1:length(tether_data.temp_25_str)
    z1 = scatter(.75+(.05*randn(1)), tether_data.temp_25_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
    
    z1 = scatter(1.75+(.05*randn(1)), tether_data.temp_30_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
    
    z1 = scatter(2.75+(.05*randn(1)), tether_data.temp_35_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
end



for aa = 1:length(headfix_data.temp_25_str)
    z1 = scatter(.85+(.05*randn(1)), headfix_data.temp_25_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', 'k')
    
    z1 = scatter(1.85+(.05*randn(1)), headfix_data.temp_30_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', 'k')
    
    z1 = scatter(2.86+(.05*randn(1)), headfix_data.temp_35_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', 'k')
end

for aa = 1:length(plate_data.temp_25_str)
    z1 = scatter(1.15+(.05*randn(1)), plate_data.temp_25_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
    
    z1 = scatter(2.15+(.05*randn(1)), plate_data.temp_30_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
    
    z1 = scatter(3.15+(.05*randn(1)), plate_data.temp_35_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
end

for aa = 1:length(water_data.temp_25_str)
    z1 = scatter(1.3+(.05*randn(1)), water_data.temp_25_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
    
    z1 = scatter(2.3+(.05*randn(1)), water_data.temp_30_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
    
    z1 = scatter(3.3+(.05*randn(1)), water_data.temp_35_str(aa));
    hold on
    set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
end


z1 = scatter(3.1, .5);
set(z1, 'MarkerFaceColor', [.2 .2 .2], 'MarkerEdgeColor', 'k')
text(3.15, .5, 'tether')

z1 = scatter(3.1, .48);
set(z1, 'MarkerFaceColor', [1 1 1], 'MarkerEdgeColor', 'k')
text(3.15, .48, 'tether+headfix')

z1 = scatter(3.1, .46);
set(z1, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')
text(3.15, .46, 'phys plate')

z1 = scatter(3.1, .44);
set(z1, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
text(3.15, .44, 'phys plate+water')

xlim([.5 3.5])
ylim([-.10 .5])
xlabel('head temp (°C)', 'FontSize', 14)
ylabel('Vfwd/ \Sigma Rotation', 'Fontsize', 14)
set(gca, 'XTick', [1 2 3], 'XTickLabel', {'25' '30' '35'}, 'YTick', [ 0 .25 .5 1], 'YTickLabel', { 0 .25 .5 }, 'FontSize', 14)

box off

export_fig('frac_fwd_fcn_temp', '-pdf')