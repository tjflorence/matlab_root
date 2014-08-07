%% old experimental flies 
fly(1).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410130504_stimulusTest';
fly(1).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410134944_stimulusTest';

fly(2).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410143753_stimulusTest';
fly(2).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410150813_stimulusTest';

fly(3).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410161247_stimulusTest/';
fly(3).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-14/20131410165257_stimulusTest/';

fly(4).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510101225_stimulusTest/';
fly(4).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510110517_stimulusTest/';

fly(5).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510145208_stimulusTest/';
fly(5).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-15/20131510153114_stimulusTest/';

fly(6).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610204018_stimulusTest/';
fly(6).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610212518_stimulusTest/';

fly(7).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610225626_stimulusTest/';
fly(7).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-16/20131610233853_stimulusTest/';


%% new experimental flies 
fly2(1).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710105700_stimulusTest';
fly2(1).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710112737_stimulusTest';

fly2(2).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710115816_stimulusTest';
fly2(2).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710122857_stimulusTest';

fly2(3).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710131440_stimulusTest';
fly2(3).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710134644_stimulusTest';

fly2(4).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010125507_stimulusTest';
fly2(4).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010133613_stimulusTest';

fly2(5).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010170509_stimulusTest';
fly2(5).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010174349_stimulusTest';

fly2(6).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010144630_stimulusTest';
fly2(6).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010154102_stimulusTest';

fly2(7).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010182946_stimulusTest';
fly2(7).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010190812_stimulusTest';




%% experiment flies
for aa = 1:7
    
    cd(fly(aa).tr1)
    load('summaryVec.mat')
    fly(aa).tr1_data = summaryVec;
    
    
    cd(fly(aa).tr2)
    load('summaryVec.mat')
    fly(aa).tr2_data = summaryVec;    


end


f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .5 .5])
s1 = subplot(3,7,[1:2, 4:5])
 
 colorSummaryMatrix = nan(7,28);

for aa = 1:7
    colorSummaryMatrix(aa,:) = [fly(aa).tr1_data fly(aa).tr2_data];
end

colorSummaryMatrix = [colorSummaryMatrix 6*ones(7,2)]

imagesc(colorSummaryMatrix)
caxis([0 6])
axis equal off
cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...
        1 183 255; ...
        111 255 243;...
        255 145 111]
    hold on
    
z1 = scatter(29,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(30,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)

z1 = scatter(29,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(30,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)
text(30.5, 2.5, 'found target / chose left')
text(30.5, 3.5, 'missed target / chose right')

z1 = scatter(30,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(30.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(10.5,0, 'test 1')
text(14.5, 0, 'train 11-20')
text(24.5, 0, 'test 2')

for aa = 1:7
    text(-.7, aa, ['fly ' num2str(aa)])
end

for aa = 1:7
   
    yval = aa+.5

    plot([0 28.5], [yval yval], 'Color', 'k')
end
text(-2, 9.5, 'trained to go left', 'Rotation', 90)
       
colormap(flipud(cMap)./255)
hold on

s2 = subplot(7,3,[7:8,10:11])
%% control flies
for aa = 1:7
    
    cd(fly2(aa).tr1)
    load('summaryVec.mat')
    fly2(aa).tr1_data = summaryVec;
    
    
    cd(fly2(aa).tr2)
    load('summaryVec.mat')
    fly2(aa).tr2_data = summaryVec;    
 

end


% f1 = figure('Color', 'w', 'units', 'normalized', 'position', [.1 .1 .5 .5])
% s1 = subplot(3,3,[1:2; 4:5])
control_colorSummaryMatrix = nan(7,30);

for aa = 1:7
    control_colorSummaryMatrix(aa,:) = [fly2(aa).tr1_data fly2(aa).tr2_data 6*ones(1,2)];
end

%control_colorSummaryMatrix = [control_colorSummaryMatrix 6*ones(7,2)]

imagesc(control_colorSummaryMatrix)
caxis([0 6])
axis equal off
cMap = [255 255 255; ...
        150 150 150; ...
        150 150 150; ...
        255 86  1; ...
        1 183 255; ...
        111 255 243;...
        255 145 111]
    hold on
    hold on
    
z1 = scatter(29,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(6,:)./255)
z1 = scatter(30,2.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(5,:)./255)

z1 = scatter(29,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(7,:)./255)
z1 = scatter(30,3.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(4,:)./255)
text(30.5, 2.5, 'found target / chose left')
text(30.5, 3.5, 'missed target / chose right')

z1 = scatter(30,4.5, 100);
set(z1, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', cMap(2,:)./255)
text(30.5, 4.5, 'no choice')

text(.5, 0, 'train 1-10')
text(10.5,0, 'test 1')
text(14.5, 0, 'train 11-20')
text(24.5, 0, 'test 2')

for aa = 1:7
    text(-.7, aa, ['fly ' num2str(aa)])
end

for aa = 1:7
   
    yval = aa+.5

    plot([0 28.5], [yval yval], 'Color', 'k')
end

text(-2, 7.5, 'new flies', 'rotation', 90)
           
colormap(flipud(cMap)./255)
hold on