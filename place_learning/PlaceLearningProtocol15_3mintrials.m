 experiment.name = 'standard';
 
 tq1=35.6
 tq2=35.5
 tq3=34.9
 tq4=35.8
 cool1=24.8
 cool2=24.8
 cool3=25
 cool4=24.5
 
 
%trial 1
experiment.protocol(1).trial_duration = 60;
%pattern control
experiment.protocol(1).pattern_ID = 1;
experiment.protocol(1).gain_bias = [0,0,0,0];
experiment.protocol(1).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(1).temps = [36 50 tq1 tq2 tq3 tq4];
%camera control
experiment.protocol(1).recordMovie = 0;

%trial 2
experiment.protocol(2).trial_duration = 180;
%pattern control
experiment.protocol(2).pattern_ID = 2;
experiment.protocol(2).gain_bias = [0,0,0,0];
experiment.protocol(2).pattern_position = [145, 1];
%temperature cotnrol
experiment.protocol(2).temps = [36 50 cool1 tq2 tq3 tq4];
%camera control
experiment.protocol(2).recordMovie = 1;

%trial 3
experiment.protocol(3).trial_duration = 180;
%pattern control
experiment.protocol(3).pattern_ID = 2;
experiment.protocol(3).gain_bias = [0,0,0,0];
experiment.protocol(3).pattern_position = [97, 1];
%temperature cotnrol
experiment.protocol(3).temps = [36 50 tq1 cool2 tq3 tq4];
%camera control
experiment.protocol(3).recordMovie = 1;

%trial 4
experiment.protocol(4).trial_duration = 180;
%pattern control
experiment.protocol(4).pattern_ID = 2;
experiment.protocol(4).gain_bias = [0,0,0,0];
experiment.protocol(4).pattern_position = [49, 1];
%temperature cotnrol
experiment.protocol(4).temps = [36 50 tq1 tq2 cool3 tq4];
%camera control
experiment.protocol(4).recordMovie = 1;

%trial 5
experiment.protocol(5).trial_duration = 180;
%pattern control
experiment.protocol(5).pattern_ID = 2;
experiment.protocol(5).gain_bias = [0,0,0,0];
experiment.protocol(5).pattern_position = [97, 1];
%temperature cotnrol
experiment.protocol(5).temps = [36 50 tq1 cool2 tq3 tq4];
%camera control
experiment.protocol(5).recordMovie = 1;

%trial 6
experiment.protocol(6).trial_duration = 180;
%pattern control
experiment.protocol(6).pattern_ID = 2;
experiment.protocol(6).gain_bias = [0,0,0,0];
experiment.protocol(6).pattern_position = [49, 1];
%temperature cotnrol
experiment.protocol(6).temps = [36 50 tq1 tq2 cool3 tq4];
%camera control
experiment.protocol(6).recordMovie = 1;

%trial 7
experiment.protocol(7).trial_duration = 180;
%pattern control
experiment.protocol(7).pattern_ID = 2;
experiment.protocol(7).gain_bias = [0,0,0,0];
experiment.protocol(7).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(7).temps = [36 50 tq1 tq2 tq3 cool4];
%camera control
experiment.protocol(7).recordMovie = 1;

%trial 8
experiment.protocol(8).trial_duration = 180;
%pattern control
experiment.protocol(8).pattern_ID = 2;
experiment.protocol(8).gain_bias = [0,0,0,0];
experiment.protocol(8).pattern_position = [49, 1];
%temperature cotnrol
experiment.protocol(8).temps = [36 50 tq1 tq2 cool3 tq4];
%camera control
experiment.protocol(8).recordMovie = 1;

%trial 9
experiment.protocol(9).trial_duration = 180;
%pattern control
experiment.protocol(9).pattern_ID = 2;
experiment.protocol(9).gain_bias = [0,0,0,0];
experiment.protocol(9).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(9).temps = [36 50 tq1 tq2 tq3 cool4];
%camera control
experiment.protocol(9).recordMovie = 1;

%trial 10
experiment.protocol(10).trial_duration = 180;
%pattern control
experiment.protocol(10).pattern_ID = 2;
experiment.protocol(10).gain_bias = [0,0,0,0];
experiment.protocol(10).pattern_position = [145, 1];
%temperature cotnrol
experiment.protocol(10).temps = [36 50 cool1 tq2 tq3 tq4];
%camera control
experiment.protocol(10).recordMovie = 1;

%trial 11
experiment.protocol(11).trial_duration = 180;
%pattern control
experiment.protocol(11).pattern_ID = 2;
experiment.protocol(11).gain_bias = [0,0,0,0];
experiment.protocol(11).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(11).temps = [36 50 tq1 tq2 tq3 cool4]
experiment.protocol(11).recordMovie = 1;

%trial 12
experiment.protocol(12).trial_duration = 180;
%pattern control
experiment.protocol(12).pattern_ID = 2;
experiment.protocol(12).gain_bias = [0,0,0,0];
experiment.protocol(12).pattern_position = [145, 1];
%temperature cotnrol
experiment.protocol(12).temps = [36 50 cool1 tq2 tq3 tq4];
%camera control
experiment.protocol(12).recordMovie = 1;

%trial 13
experiment.protocol(13).trial_duration = 180;
%pattern control
experiment.protocol(13).pattern_ID = 2;
experiment.protocol(13).gain_bias = [0,0,0,0];
experiment.protocol(13).pattern_position = [97, 1];
%temperature cotnrol
experiment.protocol(13).temps = [36 50 tq1 cool2 tq3 tq4];
%camera control
experiment.protocol(13).recordMovie = 1;

%trial 14
experiment.protocol(14).trial_duration = 180;
%pattern control
experiment.protocol(14).pattern_ID = 2;
experiment.protocol(14).gain_bias = [0,0,0,0];
experiment.protocol(14).pattern_position = [145, 1];
%temperature cotnrol
experiment.protocol(14).temps = [36 50 cool1 tq2 tq3 tq4];
%camera control
experiment.protocol(14).recordMovie = 1;

%trial 15
experiment.protocol(15).trial_duration = 180;
%pattern control
experiment.protocol(15).pattern_ID = 2;
experiment.protocol(15).gain_bias = [0,0,0,0];
experiment.protocol(15).pattern_position = [97, 1];
%temperature cotnrol
experiment.protocol(15).temps = [36 50 tq1 cool2 tq3 tq4];
%camera control
experiment.protocol(15).recordMovie = 1;

%trial 16
experiment.protocol(16).trial_duration = 180;
%pattern control
experiment.protocol(16).pattern_ID = 2;
experiment.protocol(16).gain_bias = [0,0,0,0];
experiment.protocol(16).pattern_position = [49, 1];
%temperature cotnrol
experiment.protocol(16).temps = [36 50 tq1 tq2 cool3 tq4];
%camera control
experiment.protocol(16).recordMovie = 1;

%trial 17
experiment.protocol(17).trial_duration = 180;
%pattern control
experiment.protocol(17).pattern_ID = 2;
experiment.protocol(17).gain_bias = [0,0,0,0];
experiment.protocol(17).pattern_position = [97, 1];
%temperature cotnrol
experiment.protocol(17).temps = [36 50 tq1 cool2 tq3 tq4];
%camera control
experiment.protocol(17).recordMovie = 1;

%trial 18
experiment.protocol(18).trial_duration = 180;
%pattern control
experiment.protocol(18).pattern_ID = 2;
experiment.protocol(18).gain_bias = [0,0,0,0];
experiment.protocol(18).pattern_position = [145, 1];
%temperature cotnrol
experiment.protocol(18).temps = [36 50 tq1 tq2 tq3 tq4];
%camera control
experiment.protocol(18).recordMovie = 1;


%trial 19
experiment.protocol(19).trial_duration = 120;
%pattern control
experiment.protocol(19).pattern_ID = 1;
experiment.protocol(19).gain_bias = [0,0,0,0];
experiment.protocol(19).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(19).temps = [36 50 cool1 tq2 cool3 tq4];
%camera control
experiment.protocol(19).recordMovie = 1;

%trial 20
experiment.protocol(20).trial_duration = 120;
%pattern control
experiment.protocol(20).pattern_ID = 1;
experiment.protocol(20).gain_bias = [0,0,0,0];
experiment.protocol(20).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(20).temps = [36 50 tq1 cool2 tq3 cool4];
%camera control
experiment.protocol(20).recordMovie = 1;

%trial 21
experiment.protocol(21).trial_duration = 120;
%pattern control
experiment.protocol(21).pattern_ID = 3;
experiment.protocol(21).gain_bias = [80,0,0,0];
experiment.protocol(21).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(21).temps = [36 50 tq1 tq2 tq3 tq4];
%camera control
experiment.protocol(21).recordMovie = 1;

%trial 22
experiment.protocol(22).trial_duration = 120;
%pattern control
experiment.protocol(22).pattern_ID = 3;
experiment.protocol(22).gain_bias = [-80,0,0,0];
experiment.protocol(22).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(22).temps = [36 50 tq1 tq2 tq3 tq4];
experiment.protocol(22).recordMovie = 1;






save('PlaceLearningProtocolShortTrials2.mat', 'experiment');


