daqreset
imaqreset
delete(instrfind)
clear all
close all

%% input file save path; set experiment type
file_save_path = '';
experiment_type = input('input experiment type: ')

if isempty(experiment_type)
    experiment_type = input('type something you dummy. input experiment type: ')
end

%% set some constant metadata
metaData.trial_time   = 10; % time in seconds for data
metaData.acq_freq     = 40; % acq frequency
metaData.desired_temp = [25 30 35];
metaData.experiment_order = [randperm(3); randperm(3); randperm(3); randperm(3); randperm(3)];

%% set up daq object
daqObj = daq.createSession('ni');
daqObj.addAnalogOutputChannel('Dev2', [0], 'Voltage');

%% set up particulars for each type
switch experiment_type
    case 'tether'
        
        cd(file_save_path)
        files_here = dir('*tether*');
        if isempty(files_here)
            experiment_num = 1;
        else
            experiment_num = length(files_here)+1;
        end
        
        exp_name = ['motion_sum_tether_' num2str(experiment_num)]
        
        metaData.laser_powers = (metaData.desired_temp-31.52)/2.46;
        
    case 'headfix'
        
        cd(file_save_path)
        files_here = dir('*headfix*');
        if isempty(files_here)
            experiment_num = 1;
        else
            experiment_num = length(files_here)+1;
        end
        
        exp_name = ['motion_sum_headfix_' num2str(experiment_num)]

        metaData.laser_powers = (metaData.desired_temp-31.52)/2.46;
        
        
    case 'plate'
        
        cd(file_save_path)
        files_here = dir('*plate*');
        if isempty(files_here)
            experiment_num = 1;
        else
            experiment_num = length(files_here)+1;
        end
        
        exp_name = ['motion_sum_plate_' num2str(experiment_num)]
        
        metaData.laser_powers = (metaData.desired_temp-54.84)/6.65;
        
    case 'water'
        
        cd(file_save_path)
        files_here = dir('*water*');
        if isempty(files_here)
            experiment_num = 1;
        else
            experiment_num = length(files_here)+1;
        end
        
        exp_name = ['motion_sum_water_' num2str(experiment_num)]

        metaData.laser_powers = (metaData.desired_temp-28.8)/1.72;
        
    otherwise
        err('invalid type. valid types: tether, headfix, plate, water')
end


mkdir(exp_name)
cd(exp_name)

save([exp_name 'metaData'], 'metaData')
for aa = 1:size(metaData.experiment_order, 1)
    for bb = 1:size(metaData.experiment_order, 2)
        
        laserPowerIdx = metaData.experiment_order(aa,bb);
        current_power = metaData.laserPowers(laserPowerIdx);
        
        daqObj.outputSingleScan([current_power])
        pause(10)
        
        trial_data = acquire_motion(metaData);
        save([exp_name 'trial_' num2str(aa) 'temp_' num2str(metaData.desired_temp(bb))], 'trial_data')
       
        daqObj.outputSingleScan([-4.99])
        pause(30)
    end
end



