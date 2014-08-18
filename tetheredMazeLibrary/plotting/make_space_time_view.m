function [hw, dist2D] = make_space_time_view(data_file, ds, print_fig)

load(data_file)
leader_name = data_file(1:end-4);

data_frames = data.count;
data.min_error = nan(1, data.count);

st_mat = zeros(floor(data.count/ds), 96);
size(st_mat)
[init, patternStruct, binVals] = makePatternStructSBD_id;

patternCode = 2; % need this pattern code for double stripes

frame_p = 1;
for aa = 1:ds:data_frames
    
    %% calculate frame; grab one row
    xVal = (data.Xpos(aa)-900)/900;
    yVal = (data.Ypos(aa)-900)/900;
    Theta = data.flyTheta(aa);
    
    [~,circPls,ray_dist] = sample_wall_positions_circ_elev_V4(xVal, yVal, Theta, 672, 96, init);

    for elev=init.height_vec
        init.dumpPat(elev,:)=(patternStruct(patternCode).expand_pattern(sub2ind(init.sizeExp,...
            floor(elev*ray_dist)+1,circPls)))*patternStruct(patternCode).DSM';
    end
    
    init.dumpPat = circshift(fliplr(init.dumpPat),[0,0]);

    insert_frame = init.dumpPat(1,:);
    ds_frame = round(insert_frame./7);
    ds_frame = ds_frame(1:1:96);
    ds_frame(ds_frame>1) = 2;
    st_mat(frame_p,:) = ds_frame;
    
    frame_p = frame_p+1;
    
    %% now find min error to middle
    r_ind = find(ds_frame==1);
    b_ind = find(ds_frame==2);
    
    median_r_ind = median(r_ind);
    median_b_ind = median(b_ind);
    
    r_error = median_r_ind-48;
    b_error = median_b_ind-48;
    
    if abs(r_error) < abs(b_error)
        min_error = r_error;
    elseif abs(b_error) < abs(r_error)
        min_error = b_error;
    end
    
    error_pct = min_error/48;
    min_error_rad = pi*error_pct;
    
    data.min_error(1,aa) = min_error_rad;
end

if print_fig ==1
f1 = figure('color', 'w', 'Units', 'normalized', 'Position', [.01 .01 1.6 .8])


s1 = subplot(211)
st_mat(st_mat>1) = 2;
st_mat = st_mat';
st_mat = flipud(st_mat);
imagesc(st_mat)
colormap([.7 .7 .7; 1 0 0; 0 0 1])
daspect([1 .075 1])

hold on
plot([0 3000], [24 24], 'Color', 'k', 'LineWidth', 3)
plot([0 3000], [72 72], 'Color', 'k', 'LineWidth', 3)

plot([3000/4 3000/4], [.5 96.5], 'k--', 'LineWidth', 2)
z1 = scatter(3000/4, 48.5, 200)
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [202 0 32]/255)

plot([2*3000/4 2*3000/4], [.5 96.5], 'k--', 'LineWidth', 2)
z1 = scatter(2*3000/4, 48.5, 200)
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [244 165 130]/255)

plot([3*3000/4 3*3000/4], [.5 96.5], 'k--', 'LineWidth', 2)
z1 = scatter(3*3000/4, 48.5, 200)
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [146 197 222]/255)

plot([4*3000/4 4*3000/4], [.5 96.5], 'k--', 'LineWidth', 2)
z1 = scatter(3000, 48.5, 200)
set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [5 113 176]/255)

set(gca, 'XTick', [1 1500 3000], 'XTickLabel', {'0', '30', '60'}, 'FontSize', 30)
xlabel('time (s)')
set(gca, 'YTick', [24 72], 'YTickLabel', {'pi/2', '-pi/2'})
xlabel('seconds')

s2 = subplot(212)

end

[n,xout] = histc(data.min_error, linspace(-pi/2,pi/2, 21));
hw = calcHWM_180(n);
% add hwm_180
data.hwm_180 = hw;


if print_fig == 1
fill1 = fill([-hw/2 hw/2 hw/2 -hw/2], [0 0 (max(n)/sum(n)) (max(n)/(sum(n)))], 'r')
hold on
area(linspace(-pi/2,pi/2, 21),fliplr(n)/sum(n),'LineWidth', 2, 'EdgeColor', 'k', 'FaceColor', [.7 .7 .7])
xlim([-pi/2 pi/2])
ylim([0 max(n)/sum(n)])
alpha(.8)
set(gca, 'XTick', [-pi/2 0 pi/2], 'XTickLabel', {'pi/2', '0', '-pi/2'}, 'Ytick', [], 'FontSize', 30)
ylabel('rel. counts')
xlabel('min. error (rad)')
text((hw/2)*1.1, max(n)/sum(n), ['hwm: ' num2str(hw/(2*pi)*360) ' deg'], 'FontSize' , 18)
plot([0 0], [0 max(n)/sum(n)], 'k--', 'LineWidth', 2)
box off
%daspect([1 .085 1])

ax=get(s2,'Position');
ax(3) = ax(3)*.52;
ax(1) = ax(1)+.185;
set(s2, 'Position', ax)

if print_fig == 1
    export_fig(['space-time_' leader_name], '-pdf')
end

end

dist2D = calc2D_dist(data);

% add dist2D
data.dist2D = dist2D;

save(data_file, 'data')

clear st_mat
close all



