healthy_2bar(1).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-09/20140907154038_stimulusTest'
healthy_2bar(2).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-10/20141007154215_stimulusTest'
healthy_2bar(3).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-14/20141407160641_stimulusTest'
healthy_2bar(4).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07112014/2014-07-16/20141607141124_stimulusTest'
healthy_2bar(5).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07112014/2014-07-16/20141607195812_stimulusTest'
healthy_2bar(6).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07112014/2014-07-17/20141707091603_stimulusTest'
healthy_2bar(7).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-18/20141807113314_stimulusTest'
healthy_2bar(8).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-19/20141907143528_stimulusTest'
healthy_2bar(9).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-19/20141907170452_stimulusTest'
healthy_2bar(10).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-19/20141907183626_stimulusTest'
healthy_2bar(11).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-22/20142207212019_stimulusTest'
healthy_2bar(12).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-25/20142507132817_stimulusTest'
healthy_2bar(13).path = '/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/07282014/2014-07-25/20142507182719_stimulusTest'

% for aa = 1:length(healthy_2bar)
%    
%    cd(healthy_2bar(aa).path)
%    
%    behavior_files = dir('pre_selection*');
%    num_behav_files = length(behavior_files);
%    
%    hw_dist_mat = nan(2,num_behav_files);
%    
%    for bb = 1:num_behav_files
%        [hw, dist2D] = make_space_time_view(behavior_files(bb).name, 1, 0);
%        hw_dist_mat(1,bb) = hw;
%        hw_dist_mat(2,bb) = dist2D;
%    end
%    
%    save('hw_dist_mat.mat', 'hw_dist_mat')
% end



% for aa = 1:length(healthy_2bar)
%     
%     cd(healthy_2bar(aa).path)
%     
%     load('hw_dist_mat.mat')
%     
%     hw_dist_mat(1,:) = (180-hw_dist_mat(1,:)/(2*pi)*360)+10*randn(1,length(hw_dist_mat));
%     hw_dist_mat(2,:) = hw_dist_mat(2,:)./10;
% 
%     f1 = figure('Color', 'w', 'units', 'normalized','Position', [.01 .01 .4 .6])
%     plot(hw_dist_mat(2,:), hw_dist_mat(1,:), 'color', 'k')
%     hold on
%     z1 = scatter(hw_dist_mat(2,2:end), hw_dist_mat(1,2:end), 350)
%     set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [.7 .7 .7])
%     
%     z2 = scatter(hw_dist_mat(2,1), hw_dist_mat(1,1), 600)
%     set(z2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 1 0])
%     
%     z3 = scatter(hw_dist_mat(2,end), hw_dist_mat(1,end), 600, 'x')
%     set(z3, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', [1 0 0], 'LineWidth', 10)
%     
%     ylim([20 180])
%     xlim([0 140])
% 
%     xlabel('dist walked (cm)', 'FontSize', 30)
%     ylabel('180-hwm (deg.)', 'FontSize', 30)
%     
%     
%     set(gca, 'XTick', [0 70 140], 'YTick', [40 80 120 160], 'FontSize', 30)
%     box off
%     
%     alpha(.5)
%     
%     export_fig('dist_hwm_summary.pdf', '-pdf')
%     
%     close all
%     
% end


mark_types = ['osvd'];
mark_colors = cool(13);

f1 = figure('Color', 'w', 'units', 'normalized','Position', [.01 .01 .4 .6]);
for aa = 1:length(healthy_2bar)
    
    cd(healthy_2bar(aa).path)
    
    load('hw_dist_mat.mat')
    
    hw_dist_mat(1,:) = (180-hw_dist_mat(1,:)/(2*pi)*360)+10*randn(1,length(hw_dist_mat));
    hw_dist_mat(2,:) = hw_dist_mat(2,:)./10;

    hold on
    z1 = scatter(hw_dist_mat(2,:), hw_dist_mat(1,:), 350, mark_types(mod(aa,4)+1))
    set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', mark_colors(aa,:))
    
    alpha(.5)
    
end

    ylim([20 180])
    xlim([0 140])

    xlabel('dist walked (cm)', 'FontSize', 30)
    ylabel('180-hwm (deg.)', 'FontSize', 30)
    
    
    set(gca, 'XTick', [0 70 140], 'YTick', [40 80 120 160], 'FontSize', 30)
    box off
    
cd('/Users/florencet/Documents/matlab_root/tetheredMazeLibrary/meeting_analysis_files/20140815')
export_fig('all_dist_hwm_summary.pdf', '-pdf')
    
close all
