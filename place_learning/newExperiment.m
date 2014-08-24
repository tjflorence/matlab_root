experiment.name = 'standard';

%trial 1
experiment.protocol(1).trial_duration = 300;
%pattern control
experiment.protocol(1).pattern_ID = 2;
experiment.protocol(1).gain_bias = [0,0,0,0];
experiment.protocol(1).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(1).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(1).recordMovie = 1;

%trial 2
experiment.protocol(2).trial_duration = 300;
%pattern control
experiment.protocol(2).pattern_ID = 2;
experiment.protocol(2).gain_bias = [0,0,0,0];
experiment.protocol(2).pattern_position = [49, 1];
%temperature cotnrol
experiment.protocol(2).temps = [35 50 35 25 35 35];
%camera control
experiment.protocol(2).recordMovie = 1;

%trial 3
experiment.protocol(3).trial_duration = 30;
%pattern control
experiment.protocol(3).pattern_ID = 1;
experiment.protocol(3).gain_bias = [0,0,0,0];
experiment.protocol(3).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(3).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(3).recordMovie = 1;

%trial 4
experiment.protocol(4).trial_duration = 30;
%pattern control
experiment.protocol(4).pattern_ID = 1;
experiment.protocol(4).gain_bias = [0,0,0,0];
experiment.protocol(4).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(4).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(4).recordMovie = 1;

%trial 5
experiment.protocol(5).trial_duration = 30;
%pattern control
experiment.protocol(5).pattern_ID = 1;
experiment.protocol(5).gain_bias = [0,0,0,0];
experiment.protocol(5).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(5).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(5).recordMovie = 1;

%trial 6
experiment.protocol(6).trial_duration = 30;
%pattern control
experiment.protocol(6).pattern_ID = 1;
experiment.protocol(6).gain_bias = [0,0,0,0];
experiment.protocol(6).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(6).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(6).recordMovie = 1;

%trial 7
experiment.protocol(7).trial_duration = 30;
%pattern control
experiment.protocol(7).pattern_ID = 1;
experiment.protocol(7).gain_bias = [0,0,0,0];
experiment.protocol(7).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(7).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(7).recordMovie = 1;

%trial 8
experiment.protocol(8).trial_duration = 30;
%pattern control
experiment.protocol(8).pattern_ID = 1;
experiment.protocol(8).gain_bias = [0,0,0,0];
experiment.protocol(8).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(8).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(8).recordMovie = 1;

%trial 9
experiment.protocol(9).trial_duration = 30;
%pattern control
experiment.protocol(9).pattern_ID = 1;
experiment.protocol(9).gain_bias = [0,0,0,0];
experiment.protocol(9).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(9).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(9).recordMovie = 1;

%trial 10
experiment.protocol(10).trial_duration = 30;
%pattern control
experiment.protocol(10).pattern_ID = 1;
experiment.protocol(10).gain_bias = [0,0,0,0];
experiment.protocol(10).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(10).temps = [35 50 25 35 35 35];
%camera control
experiment.protocol(10).recordMovie = 1;

save('exeriment_template.mat', 'experiment');


