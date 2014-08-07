liveFlies(1).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-22/20142205135513_stimulusTest/'
liveFlies(2).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-23/20142305105946_stimulusTest/'
liveFlies(3).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-24/20142405115248_stimulusTest/'
liveFlies(4).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-24/20142405141706_stimulusTest/'
liveFlies(5).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-26/20142605140855_stimulusTest/'
liveFlies(6).path = '/Users/tj_florence/Documents/MATLAB/tetheredMazeLibrary/meeting_analysis_files/05292014/2014-05-26/20142605154504_stimulusTest/'

for aa = 1:6
    plotAlignmentTrials_angleHist_ballStick(liveFlies(aa).path)
    plot_dist_hwm(liveFlies(aa).path)
end
    