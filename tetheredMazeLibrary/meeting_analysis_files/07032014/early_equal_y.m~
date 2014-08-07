close all
clear all

newarena(1).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906121056_stimulusTest/';
newarena(2).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906142110_stimulusTest/';
newarena(3).path = '/Volumes/NO NAME/y_maze/2014-06-29/20142906160619_stimulusTest/';
newarena(4).path = '/Volumes/NO NAME/y_maze/2014-06-30/20143006235629_stimulusTest/';
newarena(5).path = '/Volumes/NO NAME/y_maze/2014-07-01/20140107011247_stimulusTest/';

%% make large arena for display
cd(newarena(1).path)
training_data = dir('env5*');

f1 = figure('units', 'normalized', 'Position', [.01 .01 .8 1.2], 'Color', 'w')


load(training_data(1).name)
for xx = 1:1800
    for yy = 1:1800
    
        centerX = xx-900;
        centerY = yy-900;
        
        if sqrt(centerX^2 + centerY^2) > 900
        
            data.tempEnv(yy,xx) = 7;
            
        end
    
    end
end


ironCMAP = [46 255 224;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            177 0 38; ...
            255 255 255];
ironCMAP = (ironCMAP./255);

imagesc(data.tempEnv)
colormap(ironCMAP)
set(gca, 'YDir', 'normal')
axis equal off

freezeColors()
ironCMAP = [46 255 224;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            177 0 38; ];
colormap(ironCMAP/255)
cbar1 = colorbar( 'YTick', [linspace(1.5,6.5, 8)],'YTickLabel', {'24°C  ', '32°C  ', '34°C  ', '35°C  ', '36°C ', '37°C  ','39°C  ', '40°C  ' })

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07032014/')
export_fig('new_arena', '-pdf')

close all

%% show what it looks like with visual texture
f1 = figure('units', 'normalized', 'Position', [.01 .01 .8 1.2], 'Color', 'w')

ironCMAP = [46 255 224;...
            255 237 160;...
            254 217 118;...
            254 178 76;...
            253 141 60;...
            252 78  42;...
            227 26 28;...
            177 0 38; ...
            255 255 255];
ironCMAP = (ironCMAP./255);

imagesc(data.tempEnv)
colormap(ironCMAP)
set(gca, 'YDir', 'normal')
axis equal off

freezeColors()
% creates SBD pattern
% % creates the pattern
bars=repmat([ones(32,8),zeros(32,8)],1,2);
stripes=repmat([ones(8,32);zeros(8,32)],2,1);
diagonal=circshift(stripes(:,1),[0,1]);
for f=2:32
    f_fact = round(f*1);
    diagonal=[diagonal,circshift(diagonal(:,1),[f_fact,0])];
end

diagonal_test=circshift(stripes(:,1),[0,1]);
for f=2:32
    f_fact = round(f*1);
    diagonal_test=[diagonal_test,circshift(diagonal_test(:,1),[f_fact,0])];
end



SBD = [fliplr(bars) stripes diagonal];
SBD = circshift(rot90(SBD,2), [0 32] );


SBD_masked          = ones(32,96);
SBD_masked(:,1:12)  = diagonal(:,1:12); %% target pattern
SBD_masked(:,33:44) = flipud(stripes(:,1:12));
SBD_masked(:,65:76) = flipud(stripes(:,1:12));
SBD_masked = circshift(rot90(SBD_masked,2), [0 38] );

hold on
drawArena2(900, 900, 900,  1.5, SBD_masked)


cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07032014/')
export_fig('new_arena+display', '-pdf')

%% now make fig with pretest and post-test
f1 = figure('units', 'normalized', 'Position', [.01 .01 1.2 1.2], 'Color', 'w')


flycolors = ['bgrcy']
s1 = subplot(1,2,1)
hold on

for aa = 1:5
   
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

for aa = 1:5
   
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
        
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), 'k', 'LineWidth', 3)
        plot(data.Xpos(data.trial_state==4), data.Ypos(data.trial_state==4), flycolors(aa), 'LineWidth', 3)

    end
    
end

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/07032014/')
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

