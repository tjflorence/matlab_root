function acquire_video_external_matlab
%acquire_video_external_matlab

cd S:\Acquiring_AVI
array_ver=dir('Array_version*');


%initializes the camera with aquisition paramaters
%vidobj = videoinput('dcam', 1, 'Y8_1280x960');
ip = '127.0.0.1';
port = 5010;

vidobj = BiasControl(ip,port);
if strcmp('Array_version1.mat',array_ver.name)
    ROI = [264 12 750 750];
elseif strcmp('Array_version2.mat',array_ver.name)
    ROI = [259 43 750 750];
else
    error('Array_version does not match')
end

vidobj.connect();
vidobj.enableLogging();


while isempty(dir('S:\Acquiring_AVI\experiment_running.mat'))~=1
    if isempty(dir('S:\Acquiring_AVI\start_acquire.mat'))~=1
        
        load S:\Acquiring_AVI\video_settings.mat
        tic
              
        %src = getselectedsource(vidobj);
        %src.Shutter = 500;
        %preview(vidobj);
        
        %%relocate the acquire_video.m here
        %vidobj = acquire_video(time, fps, temp_file_path, file, vidobj);       
        %Create an AVI file object.
        
        %set acquisition paramaters
        vidobj.initializeCamera(fps,'ufmf',ROI);
        
        num_of_frames=time*fps;
%         vidobj.LoggingMode='disk';
%         vidobj.FramesPerTrigger=num_of_frames;
%         vidobj.TriggerRepeat=0;
%         vidobj.Timeout=inf;
        
        %sets camera settings
%         src = getselectedsource(vidobj);
%         src.FrameRate = num2str(fps);
        
        
        % creates avi file structure
        time=datestr(now);
        %filename=strcat(file,'_',time);
        filename=file;
        cd(file_path);
%         logfile = avifile(filename);
%         logfile.Fps=fps; %perhaps make variable
%         logfile.Compression='none';
%         logfile.Quality=100;
%         logfile.Colormap = gray(256);
        vidobj.setVideoFile(filename);
        
        % Configure the video input object to use the AVI file object.
%         vidobj.DiskLogger = logfile;
%         flushdata(vidobj)
        
        %start aquisition
%         start(vidobj);
%         wait(vidobj);
%         while vidobj.FramesAcquired ~= vidobj.DiskLoggerFrameCount
%             pause(.1)
%         end
        rsp = vidobj.getFrameCount();
        vidobj.startCapture();        
        while rsp.value <= num_of_frames
            rsp = vidobj.getFrameCount();
        end
        vidobj.stopCapture();            


        vidobj.disconnect();
        
        
        toc
        delete S:\Acquiring_AVI\start_acquire.mat
        clear vidobj;
    end
end
        