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

%trial 15
experiment.protocol(2).trial_duration = 120;
%pattern control
experiment.protocol(2).pattern_ID = 3;
experiment.protocol(2).gain_bias = [50,0,0,0];
experiment.protocol(2).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(2).temps = [36 50 tq1 tq2 tq3 tq4];
%camera control
experiment.protocol(2).recordMovie = 1;

%trial 16
experiment.protocol(3).trial_duration = 120;
%pattern control
experiment.protocol(3).pattern_ID = 3;
experiment.protocol(3).gain_bias = [-50,0,0,0];
experiment.protocol(3).pattern_position = [1, 1];
%temperature cotnrol
experiment.protocol(3).temps = [36 50 tq1 tq2 tq3 tq4];
experiment.protocol(3).recordMovie = 1;





save('optomotorcolorcamera.mat', 'experiment');


