 experiment.name = 'testforlocationpreference';
 
%trial 1
experiment.protocol(1).trial_duration = 600;
%pattern control
experiment.protocol(1).pattern_ID = 1;
experiment.protocol(1).gain_bias = [0,0,0,0];
experiment.protocol(1).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(1).temps = [36 50 36 36 34.5 36];
%camera control
experiment.protocol(1).recordMovie = 1;

save('testforlocationpreference.mat', 'experiment');


