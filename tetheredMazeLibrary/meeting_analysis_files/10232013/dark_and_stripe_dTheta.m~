%function makeDarkAndStripeFixPlot(pathStructure)

%% 40hz flies 
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

nfly(1).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710105700_stimulusTest';
nfly(1).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710112737_stimulusTest';

nfly(2).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710115816_stimulusTest';
nfly(2).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710122857_stimulusTest';

nfly(3).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710131440_stimulusTest';
nfly(3).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-17/20131710134644_stimulusTest';

nfly(4).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010125507_stimulusTest';
nfly(4).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010133613_stimulusTest';

nfly(5).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010170509_stimulusTest';
nfly(5).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010174349_stimulusTest';

nfly(6).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010144630_stimulusTest';
nfly(6).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010154102_stimulusTest';

nfly(7).tr1 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010182946_stimulusTest';
nfly(7).tr2 = '/Users/tj_florence/Desktop/current_experiments/2013-10-20/20132010190812_stimulusTest';



dark_dTheta         = cell(7,28);
stripeFixCell       = cell(7,28);

for aa = 1:7
    
    
    cd(fly(aa).tr1)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        [n,xout] = histc(data.dTheta_dark, linspace(-.15,.15, 41));
        n = n/1200;
        dark_dTheta{aa,bb}   = n;
    end
    
    cd(fly(aa).tr2)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        [n,xout] = histc(data.dTheta_dark, linspace(-.15,.15, 41));
        n = n/1200;
        dark_dTheta{aa,bb+14}   = n;
    end 
    
    
end

for aa = 1:7
    
    
    cd(fly(aa).tr1)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        stripeFixCell{aa,bb}   = data.flyTheta_stripe-pi;
    end
    
    cd(fly(aa).tr2)
    dataTrials = dir('env*');
    for bb = 1:length(dataTrials)
        load(dataTrials(bb).name)
        stripeFixCell{aa,bb+14} = data.flyTheta_stripe-pi;
    end 
    
    
end

for aa = 1:7
f1 = figure('Color', 'w','Units', 'normalized', 'position', [.1 .1 .5 .4])
s1 = subplot(2,1,1)
emptyMat = zeros(41,28);
for bb = 1:28
   emptyMat(:,bb) = dark_dTheta{aa,bb}';
end

improvedCmap = pmkmp(50);
colormap(improvedCmap)
freezeColors
caxis([0 max(max(emptyMat))])
imagesc(emptyMat)
hold on

set(gca, 'YDir', 'normal')
for bb = 1:28
   plot([bb+.5 bb+.5], [0 41], 'k', 'lineWidth', .5)
   
end

c1 = colorbar;
cbfreeze(c1)
text(31, 26.5, 'normalized counts', 'rotation', -90)
set(gca, 'YTick', [0.5 21 41.5], 'YTickLabel', {-.15 0 .15})
freezeColors

xlabel('trial no.')
ylabel('delta Theta (rad, +left)')
title('inst. turn distribution, dark')
drawnow
%export_fig(['dark_turn_distribution'])

%% plot orientation v time for stripe fix
%f1 = figure('Color', 'w','Units', 'normalized', 'position', [.1 .1 .5 .4])
s2 = subplot(2,1,2)
b1 = fill([0 350 350 0],[-0.1963 -0.1963 0.1963 0.1963], [.7 .7 .7]);
set(b1, 'FaceAlpha', [.5]);
hold on

redVals = linspace(0,1,28)';
cmap = zeros(28,3);
cmap(:,1) = redVals;

for bb = 1:28
    plot(stripeFixCell{aa,bb},'Color', cmap(bb,:), 'LineWidth', 3)
    hold on
end

ylim([-pi/2 pi/2])
xlim([0 320])
set(gca, 'XTick', [0 40 80 120 160 200 240 280 320], 'XTickLabel', {0 1 2 3 4 5 6 7 8})
xlabel('time (s)')
ylabel('theta (rad, +left)')

colormap(cmap)
freezeColors
c2 = colorbar;
set(c2, 'YTick', [linspace(0,1,28)], 'YTickLabel', {1:28})
box off
cbfreeze(c2)
plot([0 0], [-pi pi], 'Color', 'k' , 'LineWidth', 3)
plot([0 450], [-pi -pi], 'Color', 'k' , 'LineWidth', 3)

title('stripe fixation period, by trial')

cd(fly(aa).tr2)
export_fig(['darkDist_stripeFix'])
close all
end