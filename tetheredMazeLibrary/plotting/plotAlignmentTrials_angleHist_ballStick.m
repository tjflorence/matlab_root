function plotAlignmentTrials_angleHist_ballStick(directory)
%% plots alignment trials, if they exist

cd(directory)

%try
%    cd('alignment')
%catch err
%    disp('no "pre_selection" folder. run "processVR_experiment.m first" ')
%    mkdir('alignment')
%    cd('alignment')
%end

alignmentTrialsToPlot = dir('pre_selection*');
numFiles = length(alignmentTrialsToPlot);

for aa = 1:numFiles

    load(alignmentTrialsToPlot(aa).name)
    f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.01 .01 .6 .3]);
    
    s1 = subplot(2,4,[1:2, 5:6])
    sizePlot = get(s1, 'Position')
  %  set(s1, 'Position', [sizePlot(1)-.1 sizePlot(2) sizePlot(3) sizePlot(4)])
    
    hold on
    radius = length(data.tempEnv)/2;
    
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'k',7)
    circle([length(data.tempEnv)/2 length(data.tempEnv)/2],length(data.tempEnv)/2,1000,'g',5)
    hold on
    plot_arc(-.0833*pi, .0833*pi,radius,radius,radius,5,'k');
    plot(data.Xpos(1:data.count), data.Ypos(1:data.count), 'k:', 'LineWidth', 1)
    
    numSamples = data.count;
    intersecond_interval = 3*50;
    pos_vec_size = 20;
    
    
        
    oneQuarter      = 0;
    oneHalf         = 0;
    threeQuarters   = 0;
    
    
       for bb = 1:numSamples
        
        if (floor(data.timeStamp(bb)) == 15) && (oneQuarter == 0)
            
            z1 = scatter(data.Xpos(bb), data.Ypos(bb), 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [202 0 32]/255)
        
            
            oneQuarter = 1;
        
        end
        
        if (floor(data.timeStamp(bb)) == 30) && (oneHalf == 0)
            
            z1 = scatter(data.Xpos(bb), data.Ypos(bb), 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [244 165 130]/255)
            
            oneHalf = 1;
        end
        
        if (floor(data.timeStamp(bb)) == 45) && (threeQuarters == 0)
            z1 = scatter(data.Xpos(bb), data.Ypos(bb), 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [146 197 222]/255)

            threeQuarters   = 1;

        end
        
         if bb == numSamples
            z1 = scatter(data.Xpos(bb), data.Ypos(bb), 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [5 113 176]/255)

         end
       end
      

%   plot(data.Xpos(1:data.count), data.Ypos(1:data.count),'k', 'LineWidth', 1)

        
    
    
    for bb = 1:intersecond_interval:numSamples
        
       % z1 = scatter(data.Xpos(bb), data.Ypos(bb), 50);
       % set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', 'none')
        
        rad_x_p = data.Xpos(bb)+(pos_vec_size*cos(data.flyTheta(bb)));
        rad_y_p = data.Ypos(bb)+(pos_vec_size*sin(data.flyTheta(bb)));
        
        rad_x_n = data.Xpos(bb)-(pos_vec_size*cos(data.flyTheta(bb)));
        rad_y_n = data.Ypos(bb)-(pos_vec_size*sin(data.flyTheta(bb)));
        
        plot([rad_x_n rad_x_p], [rad_y_n rad_y_p], 'LineWidth', 1.5, 'Color', 'k')        
      %  plot([rad_x_n rad_x_p], [rad_y_n rad_y_p], 'LineWidth', 1.5, 'Color', [.65 .65 .65])
        
        z2 = scatter(rad_x_p, rad_y_p, 40);
        set(z2, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [.8 .8 .8])
        

    end


    
    axis equal off
    title('arena (52 cm diameter)', 'interpreter', 'none')

    
    s2 = subplot(2,4,3:4)
    sizePlot = get(s2, 'Position')
    box off
    
    oneQuarter      = 0;
    oneHalf         = 0;
    threeQuarters   = 0;
    rotatedValues   = mod(data.flyTheta(1:data.count)+pi, 2*pi);
    
    zeroCenter_pi = rotatedValues-pi;
    
    data.relative_to_stripe = nan(1, data.count);
    for bb = 1:data.count
        
        x_from_stripe = 1800-data.Xpos(bb);
        y_from_stripe = 900-data.Ypos(bb);
        
        theta_from_stripe = atan2(y_from_stripe, x_from_stripe);
        data.relative_to_stripe(bb) = theta_from_stripe-zeroCenter_pi(bb);
        
    end
        
    rotated_values = data.relative_to_stripe+pi;

    
    hold on
   
    eye_height_vec = [];
    for bb = 1:data.count
        
        x_from_stripe = 1800-data.Xpos(bb);
        y_from_stripe = 900-data.Ypos(bb);
        
        dist_from_stripe = sqrt((x_from_stripe^2) + (y_from_stripe^2))/34.5;     
        eye_half_height = atan(13.66 / (2*dist_from_stripe));
        eye_height_vec = [eye_height_vec eye_half_height];
        
    end
    
    eye_height_vec = [eye_height_vec -fliplr(eye_height_vec)];
    x_vec          = [linspace(0,60,data.count) linspace(60,0,data.count)];
    
    fill(x_vec, eye_height_vec, [.6 .6 .6])
    
    for bb = 1:numSamples
        
        
        if (floor(data.timeStamp(bb)) == 15) && (oneQuarter == 0)
            
            z1 = scatter(15, rotatedValues(bb)-pi, 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [202 0 32]/255)
        
            
            oneQuarter = 1;
        
        end
        
        if (floor(data.timeStamp(bb)) == 30) && (oneHalf == 0)
            
            z1 = scatter(30, rotatedValues(bb)-pi, 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [244 165 130]/255)
            
            oneHalf = 1;
        end
        
        if (floor(data.timeStamp(bb)) == 45) && (threeQuarters == 0)
            z1 = scatter(45, rotatedValues(bb)-pi, 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [146 197 222]/255)

            threeQuarters   = 1;

        end
        
         if bb == numSamples
            z1 = scatter(60, rotatedValues(bb)-pi, 200)
            set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [5 113 176]/255)

         end
        
    end
   
    
    plot(data.timeStamp(1:data.count),rotatedValues-pi, 'Color', 'k', 'LineWidth',2)
    ylim([-3.14 3.14])
    set(gca, 'YTick', [-pi -pi/2 0 pi/2 pi], 'YTickLabel', {'-pi' '-pi/2' '0' 'pi/2' 'pi'}, 'Fontsize', 15)
    ylabel('theta', 'Fontsize', 20)
    xlabel('time (sec)', 'Fontsize', 20)
    xlim([0 60])
    title('theta vs. time')
    box off
    
    s3 = subplot(2,4,7:8)
    box off
    
    deltaTheta = zeros(1,data.count);

    [n,xout] = histc(rotatedValues-pi, linspace(-pi,pi, 41));
    
    hw = calcHWM(n, xout)
    
    hw_plot = (hw/(2*pi))*41;
    
    fill1 = fill([-hw/2 hw/2 hw/2 -hw/2], [0 0 (max(n)/data.count) (max(n)/data.count)], 'r')
    hold on
    plot([0 0], [0 max(n)/data.count], 'k:', 'LineWidth', 2)
    
    
    n = n/data.count;
    area(linspace(-pi,pi, 41),n,'LineWidth', 2, 'EdgeColor', 'k', 'FaceColor', [.7 .7 .7])
    
    hold on
    
    
    xlim([-pi pi])
    set(gca, 'XTick', [-3.14 -3.14/2 0 3.14/2 3.14], 'XTickLabel', {'-pi' 'pi/2' '0' 'pi/2' 'pi'}, 'YTickLabel', {' '}, 'FontSize', 14)
    xlabel('theta to stripe center', 'Fontsize', 20)
    ylabel('normalized counts', 'Fontsize', 20)
   % title('orientation histogram')
    box off
    
    export_fig(['E_plot_' alignmentTrialsToPlot(aa).name(1:end-4)], '-pdf')
    
end

close all

