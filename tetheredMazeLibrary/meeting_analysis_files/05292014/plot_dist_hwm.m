function out_vec = plot_dist_hwm(directory)
%% plots alignment trials, if they exist

cd(directory)

alignmentTrialsToPlot = dir('pre_selection*');
numFiles = length(alignmentTrialsToPlot);

data_array = nan(2, numFiles)

for aa = 1:numFiles

    load(alignmentTrialsToPlot(aa).name)
    
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
    
    [n,xout] = histc(rotatedValues-pi, linspace(-pi,pi, 41));
    hw = calcHWM(n, xout);
    
    hw_deg = hw*(360/(2*pi));
    dist2D = calc2D_dist(data); %% total distance walked, mm
    dist2D = dist2D/10; %% total distance walked, cm
    
    data_array(1, aa) = hw_deg;
    data_array(2, aa) = dist2D;
    
end

    f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [0 0 .3 .2]);
    
    hold on
    plot(data_array(2,:), data_array(1, :), 'Color', 'k', 'LineWidth', 1.5)
    
    cMap = zeros(numFiles, 3);
    greenVals = linspace(0,1,numFiles);
    cMap(:,2) = greenVals';
    
    for aa = 1:numFiles
        z1 = scatter(data_array(2,aa), data_array(1,aa), 200)
        set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', cMap(aa,:))
    
    end
    
    z2 = scatter(data_array(2,end), data_array(1,end), 200, 'x')
    set(z2, 'MarkerEdgeColor', 'k')
    
    set(gca, 'YDir', 'reverse')
    ylim([0 360])
    xlim([0 100])
    
    set(gca, 'XTick', [0 25 50 75 100], 'YTick', [0 90 180 270 360], 'FontSize', 14, 'FontWeight', 'Bold')
    xlabel('distance walked (cm)', 'FontSize', 20)
    ylabel('orientation half-width (deg)', 'FontSize', 20)
    
    export_fig('vecPlot', '-pdf')
    
%close all
out_vec = data_array;

save('hwm_dist_2D', 'data_array')
