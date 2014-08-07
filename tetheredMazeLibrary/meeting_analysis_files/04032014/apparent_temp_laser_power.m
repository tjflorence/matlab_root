tetherFly(1).power = [-5 -4 -3 -2 -1 0 1 2 3 4 5 ];
tetherFly(1).temps = [19.0 22.0 24.4 28 30.4 31.5 34.0 36.1 38.2 39.7 43.3; ...
                        17.5 20.5 24.1 26.9 29.7 31.8 35.1 36.8 40.2 44.8 47.3];
                    
tetherFly(2).power = tetherFly(1).power;
tetherFly(2).temps = [19.2 21.8 24.4 27.7 30.4 31.5 33.7 36.2 38.4 41.1 44.8;...
                        18.4 21.6 23.9 27.1 29.3 31.4 33.2 35.3 38.2 41.6 47.4];

tetherFly(3).power = tetherFly(1).power;
tetherFly(3).temps = [18.8 22.1 24.7 26.1 28.3 31.2 33.6 35.5 37.5 39.6 42.3; ...
                        19.1 21.9 24.8 28.0 29.7 31.1 33.3 35.3 37.5 39.8 42.6];

plateNoWater(1).power = [-5 -4.5 -4.0 -3.5 -3.0 -2.5 -2.0 -1.5];
plateNoWater(1).temps = [20.4 23.4 27.4 31.9 36.9 38.5 39.4 41.9; ...
                         20.5 23.6 27.5 31.2 34.5 38.9 40.2 45.1];
                 
plateNoWater(2).power = plateNoWater(1).power;
plateNoWater(2).temps = [21.2 25.0 29.9 32.4 36.1 40.1 44.4 47.2; ...
                         22.1 24.8 29.5 32.8 35.9 40.2 43.5 46.1];
                     
plateNoWater(3).power = plateNoWater(1).power;
plateNoWater(3).temps = [21.3 24.9 27.8 32.4 35.0 36.8 38.9 41.1;...
                         21.6 24.2 28.5 32.6 35.5 37.4 39.4 44.6];

plateWithWater(1).power = [-5 -4 -3 -2 -1 0 1 2 3 4 5];
plateWithWater(1).temps = [20.2 21.4 23.8 25.6 27.0 29.1 30.0 31.4 33.3 34.9 36.0; ...
                           21.4 22.3 23.4 25.7 26.8 28.5 29.3 31.4 32.6 34.1 35.5];

plateWithWater(2).power = plateWithWater(1).power;
plateWithWater(2).temps = [18.1 20.4 22.5 24.7 26.6 28.1 29.9 32.1 33.3 35.4 36.6;
                           19.4 20.4 22.4 23.8 26.2 28.2 30.3 31.4 34.0 35.2 36.7];

plateWithWater(3).power = plateWithWater(1).power;
plateWithWater(3).temps = [20.2 20.6 22.3 25.0 27.1 29.0 30.8 32.8 34.1 36.0 36.5; 
                           19.2 20.1 22.1 25.1 27.8 29.3 31.3 33.0 34.6 35.1 35.6];
   

f1 = figure('Color', 'w', 'units', 'normalized', 'Position', [.2 .2 .5 .6]);

markerTypeVec = ['o' 's' '^'];
jitterVal = 1*randn(1,3);
for bb = 1:3
    for aa = 1:2
        z1 = scatter(((tetherFly(1).power+5).*10)+jitterVal(bb), tetherFly(bb).temps(aa,:), markerTypeVec(bb));
        set(z1, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [.5 .5 .5])
        hold on
    end
end

for bb = 1:3
    for aa = 1:2
        z1 = scatter(((plateNoWater(1).power+5).*10)+jitterVal(bb), plateNoWater(bb).temps(aa,:), markerTypeVec(bb));
        set(z1, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', [.5 .5 1])
        hold on
    end
end

for bb = 1:3
    for aa = 1:2
        z1 = scatter(((plateWithWater(1).power+5).*10)+jitterVal(bb), plateWithWater(bb).temps(aa,:), markerTypeVec(bb));
        set(z1, 'MarkerEdgeColor', 'r', 'MarkerFaceColor', [1 .5 .5])
        hold on
    end
end

xlim([-.5 100.5])
ylim([15 50])

set(gca, 'XTick', [ 25 50  75 100], 'XTickLabel', {'25' '50' '75' '100'}, 'YTick', [20 30 40 50], 'YTickLabel', {'15' '30' '40' '50'}, 'FontSize', 18);
hx = xlabel('percent laser power (a.u.)')
hy = ylabel('observered temp (°C)')

text(60, 17, 'fly + tether pin', 'FontSize', 17)
text(60, 19, 'fly + PEEK pyramid', 'FontSize', 17)
text(60, 21, 'fly + PEEK + 500 \muL water', 'FontSize', 17)

z1 = scatter(59, 17, 's')
set(z1, 'MarkerFaceColor', [.5 .5 .5], 'MarkerEdgeColor', 'k')
z2 = scatter(59, 19, 's')
set(z2, 'MarkerFaceColor', [.5 .5 1], 'MarkerEdgeColor', 'b')
z3 = scatter(59, 21, 's')
set(z3, 'MarkerFaceColor', [1 .5 .5], 'MarkerEdgeColor', 'r')

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014')
export_fig('observed_temp_as_fcn_of_laser_power', '-pdf')


mean_tether = [];
for aa = 1:3
    
    mean_tether = [mean_tether; tetherFly(aa).temps];

end
mean_tether = mean(mean_tether);

mean_plate = [];
for aa = 1:3

    mean_plate = [mean_plate; plateNoWater(aa).temps];
    
end
mean_plate = mean(mean_plate);

mean_water = [];
for aa = 1:3

    mean_water =  [mean_water; plateWithWater(aa).temps];

end
mean_water = mean(mean_water);

p_tether = polyfit( (tetherFly(1).power+5)*10, mean_tether, 1);
p_plate  = polyfit( (plateNoWater(1).power+5)*10, mean_plate, 1);
p_water  = polyfit( (plateWithWater(1).power+5)*10, mean_water, 1);


x = 1:100;

plot((tetherFly(1).power+5)*10, mean_tether, 'k', 'LineWidth', 2)
plot((plateNoWater(1).power+5)*10, mean_plate, 'b', 'LineWidth', 2)
plot( (plateWithWater(1).power+5)*10, mean_water, 'r', 'LineWidth', 2)


plot(x, (p_tether(1)*x)+p_tether(2), 'k:', 'LineWidth', 2);
plot(x, (p_plate(1)*x)+p_plate(2), 'b:' , 'LineWidth', 2);
plot(x, (p_water(1)*x)+p_water(2), 'r:' ,  'LineWidth', 2);

cd('/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/04032014')
export_fig('observed_temp_as_fcn_of_laser_power+fit', '-pdf')

p_tether_i = polyfit( tetherFly(1).power, mean_tether, 1)
p_plate_i  = polyfit( plateNoWater(1).power, mean_plate, 1)
p_water_i  = polyfit( plateWithWater(1).power, mean_water, 1)

