close all
clear all

newarena(1).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906121056_stimulusTest/';
newarena(2).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906142110_stimulusTest/';
newarena(3).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906160619_stimulusTest/';
newarena(4).path = '/Volumes/NO NAME/y_maze/2014-06-30/20143006235629_stimulusTest/';
newarena(5).path = '/Volumes/NO NAME/y_maze/2014-07-01/20140107011247_stimulusTest/';



%% now make fig with pretest and post-test
f1 = figure('units', 'normalized', 'Position', [.01 .01 1.2 1.2], 'Color', 'w')


flycolors = ['r']
s1 = subplot(1,2,1)
hold on

for aa = 1
   
    cd(newarena(aa).path)
    pretest_files = dir('*TEST00*');
    
    for bb = 1:4
        
    load(pretest_files(bb).name)
        if bb ==1 && aa == 1
            
            for xx = 1:1800
                for yy = 1:1800
    
                centerX = xx-900;
                centerY = yy-900;
        
                if sqrt(centerX^2 + centerY^2) > 900
        
                    data.tempEnv(yy,xx) = 8;
            
                end
    
                end
            end
            imagesc(data.tempEnv)
            colormap(gray)
            axis equal off
            set(gca, 'YDir', 'normal')
            hold on
            
        end
        
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), flycolors(aa), 'LineWidth', 3)

    end
    
end

s2 = subplot(1,2,2)

for aa = 1
   
    cd(newarena(aa).path)
    pretest_files = dir('*TESTA*');
    
    for bb = 1:4
        
        load(pretest_files(bb).name)
        if bb ==1 && aa ==1
            
            for xx = 1:1800
                for yy = 1:1800
    
                centerX = xx-900;
                centerY = yy-900;
        
                if sqrt(centerX^2 + centerY^2) > 900
        
                    data.tempEnv(yy,xx) = 8;
            
                end
    
                end
            end
            imagesc(data.tempEnv)
            colormap(gray)
            axis equal off
            set(gca, 'YDir', 'normal')
            hold on
            
        end
        
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 4)
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), flycolors(aa), 'LineWidth', 3)

    end
    
end

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07282014/')
export_fig('test_trajectories', '-pdf')
close all


f1 = figure('units', 'normalized', 'Position', [.01 .01 .4 .7], 'Color', 'w')
test_data = [.5 .5; .25 1.0; .5 1.0; .5 .75; .5 1.0]

plot([-100 100], [.5 .5], 'k:')
hold on

for aa = 1:5
    
    x_jitter = .07*randn(1);
    y_jitter = .01*randn(1);
    
     
        plot([1, 2]+x_jitter, test_data(aa,:)+y_jitter, 'Color', 'k', 'LineWidth', 3)
    plot([1, 2]+x_jitter, test_data(aa,:)+y_jitter, 'Color', flycolors(aa), 'LineWidth', 2)
    
    z1 = scatter(1+x_jitter, test_data(aa, 1)+y_jitter, 100)
    set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', flycolors(aa))
    
    z2 = scatter(2+x_jitter, test_data(aa, 2)+y_jitter, 100)
    set(z2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', flycolors(aa))
    
    
    
end

xlim([.5 2.5])
ylim([0 1.15])

ylabel('fraction', 'FontSize', 20)

set(gca, 'XTick', [1 2], 'XTickLabel', {'pre-test', 'post-test'},'Ytick', [.25 .5 .75 1], 'Fontsize', 20)

box off

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07032014/')
export_fig('test_fraction', '-pdf')

