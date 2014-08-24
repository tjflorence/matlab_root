%% Cluster Trackin GUI, v.1.0
% Nikolay Kladt, March 2009, sbconversion and CTrax tracking on the janelia cluster

% two dependencies: fuf and save2pdf functions have to be found in the
% Searchpath

% seems to work fine, however has only been tested by myself...



function cluster_tracking_GUI
    %% Setup the GUI
     %Load global variables  
    load('.\required\settings');

    % Temporary variables
    handles.temp.sbparamfile = '';
    handles.temp.ctraxfile = '';
    
    % Setup GUI
    handles.mygui = figure('Tag','Cluster Conversion and Tracking','name','Cluster Conversion and Tracking, Nikolay Kladt HHMI Janelia Farm March 2009, v.1.0','numbertitle','off','MenuBar','none','Units','pixels','Position',[50 50 1200 940],'Visible','On'); 
    handles.avi_filelist = uicontrol('parent',handles.mygui,'Units','pixels','Style','listbox','String','','Position',[50 450 300 400],'BackgroundColor','White','Value',0);
    handles.sbfmf_filelist = uicontrol('parent',handles.mygui,'Units','pixels','Style','listbox','String','','Position',[530 450 300 400],'BackgroundColor','White');
    handles.ctrax_filelist = uicontrol('parent',handles.mygui,'Units','pixels','Style','listbox','String','','Position',[850 450 300 400],'BackgroundColor','White');
    handles.select_files = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Select Files','Position',[50 860 140 25],'Callback',{@Select_Files_Callback});
    handles.get_directory = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Get all AVIs in directory','Position',[50 890 140 25],'Callback',{@Get_Directory_Callback});
    handles.clear_files = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Clear Lists','Position',[200 860 100 25],'Callback',{@Clear_Files_Callback});
    handles.change_sbconvert_param = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Change Sbconvert Parameters','Position',[530 860 200 25],'Callback',{@Change_Sbconvert_Param_Callback});
    handles.change_ctrax_param = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Change CTrax Parameters','Position',[850 860 200 25],'Callback',{@Change_CTrax_Param_Callback});
    handles.start_conversion = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Start Jobs','Position',[360 650 160 60],'Callback',{@Start_Conversion_Callback});
    handles.num_avis = uicontrol('parent',handles.mygui,'Units','pixels','String','0 Selected AVIs','Style','text','Position',[50 420 300 25],'HorizontalAlignment','center','BackgroundColor','White');
    handles.num_sbfmfs = uicontrol('parent',handles.mygui,'Units','pixels','String','0 Converted Files','Style','text','Position',[530 420 300 25],'HorizontalAlignment','center','BackgroundColor','White');
    handles.num_ctrax = uicontrol('parent',handles.mygui,'Units','pixels','String','0 Tracked Files','Style','text','Position',[850 420 300 25],'HorizontalAlignment','center','BackgroundColor','White');
    handles.settings = uipanel('Tag','Parameters','Units','pixels','title','Settings','Position',[50 100 450 300]);    
    handles.analyze_sbfmfs = uicontrol('parent',handles.settings,'Units','pixels','Style','Checkbox','String','Analyze sbfmf conversion quality','Position',[20 230 240 20],'Callback',{@Analyze_SBFMF_Callback},'Value',handles.var.analyze_sbfmf);
    uicontrol('parent',handles.settings,'Units','pixels','String','Mark if mean squared error exceeds','Style','text','Position',[25 200 200 20],'HorizontalAlignment','center');  
    handles.sbfmf_warninglevel = uicontrol('parent',handles.settings,'Units','pixels','Style','edit','String',handles.var.sbfmf_warninglevel,'Position',[220 205 50 20]);
    handles.onlyconvert = uicontrol('parent',handles.settings,'Units','pixels','Style','Checkbox','String','Only convert files (no tracking)','Position',[20 260 240 20],'Callback',{@OnlyConvert_Callback},'Value',handles.var.onlyconvert);
    handles.timeout = uicontrol('parent',handles.settings,'Units','pixels','Style','Checkbox','String','Job timeout [hours]','Position',[20 170 120 20],'Callback',{@Timeout_Callback},'Value',handles.var.timeout);
    handles.timeoutvalue = uicontrol('parent',handles.settings,'Units','pixels','Style','edit','String',handles.var.timeoutvalue,'Position',[140 170 50 20]);
    handles.delete_logs = uicontrol('parent',handles.settings,'Units','pixels','Style','Checkbox','String','Delete logfiles/setting-files when finished','Position',[20 140 240 20],'Callback',{@Delete_Logs_Callback},'Value',handles.var.delete_logs);
    handles.analyze_tracking = uicontrol('parent',handles.settings,'Units','pixels','Style','Checkbox','String','Analyze Tracking Quality when finished','Position',[20 110 240 20],'Callback',{@Analyze_Tracking_Callback},'Value',handles.var.analyze_tracking);
    handles.abort = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Abort Jobs','Position',[360 620 160 25],'Callback',{@Abort_Callback},'Enable','off');
    handles.quit = uicontrol('parent',handles.mygui,'Units','pixels','Style','Pushbutton','String','Save and Quit','Position',[950 50 200 25],'Callback',{@Quit_Callback});
    handles.status = uicontrol('parent',handles.mygui,'Units','pixels','String','Status','Style','listbox','Position',[530 100 620 300],'HorizontalAlignment','center','BackgroundColor','Black');
    handles.change_global_params =  uicontrol('parent',handles.settings,'Units','pixels','Style','Pushbutton','String','Change Global Parameters','Position',[20 20 200 25],'Callback',{@Change_Globals_Callback});
    handles.load_settings =  uicontrol('parent',handles.settings,'Units','pixels','Style','Pushbutton','String','Load Settings','Position',[20 60 140 25],'Callback',{@Load_Settings_Callback});
    handles.save_settings =  uicontrol('parent',handles.settings,'Units','pixels','Style','Pushbutton','String','Save Settings','Position',[170 60 140 25],'Callback',{@Save_Settings_Callback});
    
    %% File functions
    function Select_Files_Callback(hObject, eventdata)                      % Multiple file select (AVIs)
        current = cd;
        cd([handles.networkdrive ':\']);
        [filename, pathname, filterindex] = uigetfile({  '*.avi','AVI-files (*.avi)'},'Select AVI Files for tracking','MultiSelect', 'on');
        cd(current);
       
            for a=1:size(filename,2)
                zwischen = strcat(pathname,filename{a});
                handles.temp.avi_filelist(a).local = zwischen;
            end

        Update_AVI_List();
        set(handles.num_avis,'String',[num2str(length(handles.temp.avi_filelist)) ' Selected AVIs']);
    end
    function Get_Directory_Callback(hObject, eventdata)                     % Screen through a whole directory for AVIs
       current = cd;
       cd([handles.networkdrive ':\']);
       directory_name = uigetdir;
       cd(current);
       zwischen = fuf([directory_name '\*.avi'],'detail');
       length(zwischen)
       for a=1:length(zwischen)
            handles.temp.avi_filelist(a).local = zwischen{a};
       end
        Update_AVI_List();
         set(handles.num_avis,'String',[num2str(length(handles.temp.avi_filelist)) ' Selected AVIs']);
    end
    function Clear_Files_Callback(hObject, eventdata)                       % Clean the lists
        handles.temp.avi_filelist = '';
        handles.temp.sbfmf_filelist = '';
        handles.temp.ctrax_filelist = '';
        Update_AVI_List();
        Update_SBFMF_List();
        Update_CTrax_List();
    end

    %% Main Job Functions with according Timer Objects
    function Start_Conversion_Callback(hObject, eventdata)                  % Control the SBFMF Conversion
       DisableDuringRun();
       UpdateStatus('Scanning AVIs for conversion','green');
       Create_SBParam_File(); % Create/Overwrite sbparam.txt with current settings.
  
       % Start SBConversion
       fid = fopen([handles.networkdrive ':\cluster_sbconvert_jobs.sh'],'w');
       fprintf(fid,'%s \n','#!/bin/sh');
  
       
       for a=1:length(handles.temp.avi_filelist)
            zwischen = strrep(handles.temp.avi_filelist(a).local, '\', '/');
            handles.temp.avi_filelist(a).remote = strrep(zwischen, [handles.networkdrive ':'], handles.abs_home_path);
            handles.temp.avi_filepath(a).remote = fileparts(handles.temp.avi_filelist(a).remote);  
            qsub_command=['qsub -N sbconvert' num2str(a) ' -j y -o ' handles.temp.avi_filepath(a).remote '/sbconvert' num2str(a) '.out -b y -cwd -V -pe dual 2 /home/olbrisd/sbmoviesuite/sbconvert.sh ' handles.temp.avi_filelist(a).remote ' -p .' handles.sbconvert_settings];
            fprintf(fid,'%s \n',qsub_command);
       end
       fclose(fid);
       UpdateStatus('Converting files to .sbfmf - submitting jobs','green');
       [status,initial] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' chmod 777 ' handles.abs_home_path '/cluster_sbconvert_jobs.sh; env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 ' handles.abs_home_path '/cluster_sbconvert_jobs.sh;exit']);
     
      if status ~= 0
            UpdateStatus(initial,'red');
            return
       else
           UpdateStatus(initial,'white');
       end

       % Create a timer to check for results
       if handles.var.timeout == 1
          timeout = str2double(get(handles.timeoutvalue,'String')); 
       else
          timeout = 0;
       end
       
       handles.timer = timer('TimerFcn',@Timer_Callback, 'Period', handles.timer_frequency, 'ExecutionMode', 'fixedRate', 'BusyMode','queue', 'StartDelay', 1);
       start(handles.timer);
       tic;
       function Timer_Callback(obj, event, hObject)
            a = length(strfind(initial, 'job'));
            [status,result] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 qstat;exit']);
        
            b = length(strfind(result, 'sbconvert'));
            if status ~= 0
                UpdateStatus(result,'red');
                return
            else
                UpdateStatus(result,'white');
            end
           UpdateStatus(['Converting files to .sbfmf - conversion running (' num2str(a-b) '/' num2str(a) ' files done)'],'green');

            if b == 0 || (timeout>0&toc>=timeout*3600)
                 stop(handles.timer);
                UpdateStatus(['elapsed time: ' num2str(toc/3600) 'hours'] ,'green');
                for a=1:length(handles.temp.avi_filelist)
                       if exist([handles.temp.avi_filelist(a).local(1:end-3) 'sbfmf']) % Does the file exist?
                            handles.temp.sbfmf_filelist(a).local = [handles.temp.avi_filelist(a).local(1:end-3) 'sbfmf'];
                            handles.temp.sbfmf_filelist(a).remote = [handles.temp.avi_filelist(a).remote(1:end-3) 'sbfmf'];
                       end
                end
                % Check whether timeout was reached 
                if (timeout>0&toc>=timeout*3600)     
                     [status,result] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 qdel -u ' handles.username ';exit']);
                     if status ~= 0
                        UpdateStatus(result,'red');
                        return
                     else
                        UpdateStatus(result,'white');
                     end
                     UpdateStatus('Timeout reached - remaining jobs aborted.','red');
                end
                
                if handles.var.analyze_sbfmf == 1
                    Analyze_SBFMF_Quality();
                end
                
                if handles.var.delete_logs == 1
                    Delete_SBFMF_Logs();
                end
                
                 Update_SBFMF_List();
%                 
                if handles.var.onlyconvert == 0
                    Start_Tracking();
                else
                     UpdateStatus('Finished...','green');
                end
            end
       end
    end
    function Start_Tracking()                                               % Control the tracking
        UpdateStatus('Tracking - scanning files','green');
        Create_CTrax_File(); % Create/Overwrite CTraxsettings with current settings.
        %Write the submit-script
        fid = fopen(['U:\cluster_ctrax_jobs.sh'],'w'); % Create/open .sh shell script
        fprintf(fid,'%s \n','#!/bin/sh'); % First line - it is a shell script
        
        % Append a line with the qsub command for each sbfmf-file found
        for a=1:length(handles.temp.sbfmf_filelist)
            qsub_command=['qsub -N track' num2str(a) ' -j y -o /dev/null -b y -cwd -V -pe dual 2 ''/groups/reiser/home/kladtn/ctrax_batch --Input=' handles.temp.sbfmf_filelist(a).remote ' --Output=' strrep(handles.temp.sbfmf_filelist(a).remote, '.sbfmf', '.ann') ' --SettingsFile=.' handles.ctrax_settings ' --AutoEstimateBackground=True --AutoEstimateShape=False --AutoDetectCircularArena=False --Matfile=' strrep(handles.temp.sbfmf_filelist(a).remote, '.sbfmf', '_tracking') ''''];   
            fprintf(fid,'%s \n',qsub_command); % write the qsub command
        end
        fclose(fid); % close the file
        
        UpdateStatus('Tracking flies - submitting jobs','green');
       [status,initial] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' chmod 777 ' handles.abs_home_path '/cluster_ctrax_jobs.sh; env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 ' handles.abs_home_path '/cluster_ctrax_jobs.sh;exit']);
       if status ~= 0
            UpdateStatus(initial,'red');
            return
       else
           UpdateStatus(initial,'white');
       end
        
       
       % Create a timer to check for results
       if handles.var.timeout == 1
          timeout = str2double(get(handles.timeoutvalue,'String')); 
       else
          timeout = 0;
       end
       
       handles.timer = timer('TimerFcn',@Timer_Callback, 'Period', handles.timer_frequency, 'ExecutionMode', 'fixedRate', 'BusyMode','queue', 'StartDelay', 1);
       start(handles.timer);
       tic;
       function Timer_Callback(obj, event, hObject)
            a = length(strfind(initial, 'job'));
            [status,result] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 qstat;exit']);
            b = length(strfind(result, 'track'));
            
            if status ~= 0
                UpdateStatus(result,'red');
                return
            else
                UpdateStatus(result,'white');
           end
            UpdateStatus(['Tracking flies - jobs running (' num2str(a-b) '/' num2str(a) ' files done)'],'green');
          
            if b == 0 || (timeout>0&toc>=timeout*3600)
                stop(handles.timer);
                UpdateStatus(['elapsed time: ' num2str(toc/3600) 'hours'] ,'green');
              
                for a=1:length(handles.temp.sbfmf_filelist)
                    if exist([handles.temp.sbfmf_filelist(a).local(1:end-6) '_tracking.mat'])
                            handles.temp.ctrax_filelist(a).local = [handles.temp.sbfmf_filelist(a).local(1:end-6) '_tracking.mat'];
                             handles.temp.ctrax_filelist(a).remote = [handles.temp.sbfmf_filelist(a).remote(1:end-6) '_tracking.mat'];
                    end
                end
                
                % Check whether timeout was reached 
                if (timeout>0&toc>=timeout*3600)     
                     [status,result] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 qdel -u ' handles.username ';exit']);
                     if status ~= 0
                        UpdateStatus(result,'red');
                        return
                     else
                        UpdateStatus(result,'white');
                     end
                     UpdateStatus('Timeout reached - remaining jobs aborted.','red');
                end
              
                if handles.var.delete_logs == 1
                    Delete_CTrax_Logs();
                end
                
                if handles.var.analyze_tracking == 1
                   Analyze_Tracking(); 
                end
                Update_CTrax_List();
                
                UpdateStatus('Finished...','green');
                EnableAfterRun();
            end
       end
    end

    %% Update settings functions
    function Timeout_Callback(hObject, eventdata)                           % Check status of timeout
        handles.var.timeout = get(hObject,'Value');
        handles.var.timeoutvalue = get(handles.timeoutvalue,'String');
    end
    function Delete_Logs_Callback(hObject, eventdata)                       % Check status of delete logs after jobs
        handles.var.delete_logs = get(hObject,'Value');
    end
    function OnlyConvert_Callback(hObject, eventdata)                       % Check status of only convert
        handles.var.onlyconvert = get(hObject,'Value');
    end
    function Analyze_Tracking_Callback(hObject, eventdata)                  % Check status of tracking analysis
        handles.var.analyze_tracking = get(hObject,'Value');
    end

    %% GUI Update functions
    function Update_AVI_List()                                              % Update the list with selected AVIs
         set(handles.avi_filelist,'String','');
            for a=1:length(handles.temp.avi_filelist)
                set(handles.avi_filelist,'String',strvcat(get(handles.avi_filelist,'String'),strcat('<html><font color="green">',handles.temp.avi_filelist(a).local,'</font></html>')),'Value',1);
            end
 
        set(handles.num_avis,'String',[num2str(length(handles.temp.avi_filelist)) ' Selected AVIs']);
    end
    function Update_SBFMF_List()                                            % Update the list with converted SBFMFs
         set(handles.sbfmf_filelist,'String','');
      
            for a=1:length(handles.temp.sbfmf_filelist)
                set(handles.sbfmf_filelist,'String',strvcat(get(handles.sbfmf_filelist,'String'),strcat('<html><font color="green">',handles.temp.sbfmf_filelist(a).local,'</font></html>')),'Value',1);
            end

        set(handles.num_sbfmfs,'String',[num2str(length(handles.temp.sbfmf_filelist)) ' Converted SBFMFs']);
    end
    function Update_CTrax_List()                                            % Update the list with tracked files
        set(handles.ctrax_filelist,'String','');
      
       
            for a=1:length(handles.temp.ctrax_filelist)
         
                set(handles.ctrax_filelist,'String',strvcat(get(handles.ctrax_filelist,'String'),strcat('<html><font color="green">',handles.temp.ctrax_filelist(a).local,'</font></html>')),'Value',1);
            end

    
        set(handles.num_ctrax,'String',[num2str(length(handles.temp.ctrax_filelist)) ' Tracked files']);
    end
    function UpdateStatus(message,color)                                    % Update the status panel
        zwischen2(1) = 1;
        zwischen2(2:length(regexp(message, '\n'))+1) = regexp(message, '\n');
        if length(zwischen2) < 2
            zwischen2(2) = length(message);
        end
        for a=1:length(zwischen2)-1
            set(handles.status,'String',strvcat(get(handles.status,'String'),strcat('<html><font color="',color,'">',message(zwischen2(a):zwischen2(a+1)),'</font></html>')),'Value',get(handles.status,'Value')+1); 
        end
    end

    %% SBFMF Functions
    function Delete_SBFMF_Logs()                                            % Delete and empty Logfiles after conversion
        
        % delete sbconvert*.log in /home, 
        
        delete([handles.networkdrive ':\sbconvert*.log']); 
        if isempty(dir([handles.networkdrive ':\sbconvert*.log']))
            UpdateStatus(['Deleting sbconvert logs: successful. '],'white');
        else
            UpdateStatus(['Deleting sbconvert logs: failed. '],'red');
        end
        
        % delete sbconvert*.out at location of file.
        result = 0;
        for a=1:size(handles.temp.avi_filelist,1)
            avi_filepath{a} = fileparts(handles.temp.avi_filelist(a).local);
            delete([avi_filepath{a} '\sbconvert*.out']);
            if ~isempty(dir([avi_filepath{a} '\sbconvert*.out']))
            	result = -1;
            end
        end
        if result == 0
             UpdateStatus(['Deleting temporary sbconvert files: successful. '],'white');
        else
            UpdateStatus(['Deleting  temporary sbconvert files: failed. '],'red');
        end
        
        % delete sbconvert.summary in /home
         delete([handles.networkdrive ':\sbconvert.summary']); 
        if isempty(dir([handles.networkdrive ':\sbconvert.summary']))
            UpdateStatus(['Deleting sbconvert summary: successful. '],'white');
        else
            UpdateStatus(['Deleting sbconvert summary: failed. '],'red');
        end
        
         % delete sbparam in /home
          delete([handles.networkdrive ':\sbparam.txt']); 
        if isempty(dir([handles.networkdrive ':\sbparam.txt']))
            UpdateStatus(['Deleting sbconvert settings: successful. '],'white');
        else
            UpdateStatus(['Deleting sbconvert settings: failed. '],'red');
        end
    
       
        
    end
    function Analyze_SBFMF_Callback(hObject, eventdata)                     % Check setting status
        handles.var.analyze_sbfmf = get(hObject,'Value');
        handles.var.sbfmf_warninglevel = get(handles.sbfmf_warninglevel,'String');
    end
    function Analyze_SBFMF_Quality()                                        % Analyze the quality of the converted sbfmf files
        % Look into the sbconvert.summary, find each file that was
        % performed in this run, check the variables.
        sbconvertreport = fopen([handles.networkdrive ':\conversion_report.html'],'w+');
        fprintf(sbconvertreport,'<html><head><title>SBFMF Conversion report</title></head><body><ul>');
        
        fid = fopen([handles.networkdrive ':\sbconvert.summary']);
        
      
        linedata = textscan(fid, '%s','Whitespace','\n');

        for b=1:length(handles.temp.sbfmf_filelist)
    
               for a=1:length(linedata{1})

                if strfind(linedata{1}{a},handles.temp.sbfmf_filelist(b).remote)
                    % we have a match.
                    % screen the last three values.
                 
                    current_line = textscan(linedata{1}{a,1}, '%s');
   
                    if str2double(get(handles.sbfmf_warninglevel,'String')) < str2double(current_line{1}{end-1})
                        fprintf(sbconvertreport,['<li><font color="#FF0000">' current_line{1}{end-3} '<br>Number of frames: ' current_line{1}{end-2} '<br>Mean square error: ' current_line{1}{end-1} '</font>']);
                    else
                        fprintf(sbconvertreport,['<li><font color="000000">' current_line{1}{end-3} '<br>Number of frames: ' current_line{1}{end-2} '<br>Mean square error: ' current_line{1}{end-1} '</font>']);
                    end
                end
            end
        end
        
       fclose(fid);
       fprintf(sbconvertreport,'</ul></body></html>');
       fclose(sbconvertreport); 
       winopen([handles.networkdrive ':\conversion_report.html']);
       
    end
    function Change_Sbconvert_Param_Callback(hObject, eventdata)            % Change the parameters for the conversion
        % open a new dialog window!
        dlg = dialog('Units','pixels','Position',[400 300 240 650],'name','SBConvert settings','WindowStyle','normal');
        save = uicontrol('Units','pixels','Style','Pushbutton','String','Write Settings','Position',[20 620 200 20],'Callback',{@Save_Settings_Callback});   
        uicontrol('Units','pixels','String','convert:','Style','text','Position',[20 590 100 15],'HorizontalAlignment','left');
        convert = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 590 100 20],'Value',str2num(handles.sbparam.convert)+1);
        uicontrol('Units','pixels','String','writefiles:','Style','text','Position',[20 560 100 15],'HorizontalAlignment','left');
        writefiles = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 560 100 20],'Value',str2num(handles.sbparam.writefiles)+1);
        uicontrol('Units','pixels','String','overwrite:','Style','text','Position',[20 530 100 15],'HorizontalAlignment','left');
        overwrite = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 530 100 20],'Value',str2num(handles.sbparam.overwrite)+1);
        uicontrol('Units','pixels','String','usesequence:','Style','text','Position',[20 500 100 15],'HorizontalAlignment','left');
        usesequence = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 500 100 20],'Value',str2num(handles.sbparam.usesequence)+1);
        uicontrol('Units','pixels','String','sequencesuffix:','Style','text','Position',[20 470 100 15],'HorizontalAlignment','left');
        sequencesuffix = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.sequencesuffix,'Position',[120 470 100 20]);
        uicontrol('Units','pixels','String','writebgfiles:','Style','text','Position',[20 440 100 15],'HorizontalAlignment','left');
        writebgfiles = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 440 100 20],'Value',str2num(handles.sbparam.writebgfiles)+1);
        uicontrol('Units','pixels','String','readbgfiles:','Style','text','Position',[20 410 100 15],'HorizontalAlignment','left');
        readbgfiles = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 410 100 20],'Value',str2num(handles.sbparam.readbgfiles)+1);
        uicontrol('Units','pixels','String','bgfilename:','Style','text','Position',[20 380 100 15],'HorizontalAlignment','left');
        bgfilename = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',upper(handles.sbparam.bgfilename),'Position',[120 380 100 20]);
        uicontrol('Units','pixels','String','n_bg_std_thresh_low:','Style','text','Position',[20 350 100 15],'HorizontalAlignment','left');
        n_bg_std_thresh_low = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.n_bg_std_thresh_low,'Position',[120 350 100 20]);
        uicontrol('Units','pixels','String','n_bg_std_thresh_high:','Style','text','Position',[20 320 100 15],'HorizontalAlignment','left');
        n_bg_std_thresh_high = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.n_bg_std_thresh_high,'Position',[120 320 100 20]);
        

         uicontrol('Units','pixels','String','est_algorithm:','Style','text','Position',[20 290 100 15],'HorizontalAlignment','left');

         if strfind(handles.sbparam.est_algorithm,'median')
            est_algorithm = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','median|mean','Position',[120 290 100 20],'Value',1);
         else
            est_algorithm = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','median|mean','Position',[120 290 100 20],'Value',2);
         end
         
          uicontrol('Units','pixels','String','normalize_by:','Style','text','Position',[20 260 100 15],'HorizontalAlignment','left');
         if strfind(handles.sbparam.normalize_by,'standarddeviation')
            normalize_by = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','standarddeviation|other','Position',[120 260 100 20],'Value',1);
         else
            normalize_by = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','standarddeviation|other','Position',[120 260 100 20],'Value',2);
         end
         
          uicontrol('Units','pixels','String','difference_mode:','Style','text','Position',[20 230 100 15],'HorizontalAlignment','left');
         if strfind(handles.sbparam.difference_mode,'lightondark')
            difference_mode = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','lightondark|darkonlight','Position',[120 230 100 20],'Value',1);
         else
            difference_mode = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','lightondark|darkonlight','Position',[120 230 100 20],'Value',2);
         end
         
         uicontrol('Units','pixels','String','bg_nframes:','Style','text','Position',[20 200 100 15],'HorizontalAlignment','left');
        bg_nframes = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.bg_nframes,'Position',[120 200 100 20]);
        
        
        uicontrol('Units','pixels','String','bg_std_min:','Style','text','Position',[20 170 100 15],'HorizontalAlignment','left');
        bg_std_min = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.bg_std_min,'Position',[120 170 100 20]);
        
        uicontrol('Units','pixels','String','bg_std_max:','Style','text','Position',[20 140 100 15],'HorizontalAlignment','left');
        bg_std_max = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.bg_std_max,'Position',[120 140 100 20]);
        
        uicontrol('Units','pixels','String','summaryfile:','Style','text','Position',[20 110 100 15],'HorizontalAlignment','left');
        summaryfile = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.summaryfile,'Position',[120 110 100 20]);
        
        uicontrol('Units','pixels','String','logfile:','Style','text','Position',[20 80 100 15],'HorizontalAlignment','left');
        logfile = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbparam.logfile,'Position',[120 80 100 20]);
        
       
         uicontrol('Units','pixels','String','fileloglevel:','Style','text','Position',[20 50 100 15],'HorizontalAlignment','left');
         switch(handles.sbparam.fileloglevel)
             
         case 'warning'
            fileloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 50 100 20],'Value',1);
         case 'info'
            fileloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 50 100 20],'Value',2);
             case 'info-plus'
            fileloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 50 100 20],'Value',3);
             case 'debug'
            fileloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 50 100 20],'Value',4);
         end
         
         uicontrol('Units','pixels','String','screenloglevel:','Style','text','Position',[20 20 100 15],'HorizontalAlignment','left');
         switch(handles.sbparam.screenloglevel)
             
         case 'warning'
            screenloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 20 100 20],'Value',1);
         case 'info'
            screenloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 20 100 20],'Value',2);
             case 'info-plus'
            screenloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 20 100 20],'Value',3);
             case 'debug'
            screenloglevel = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','warning|info|info-plus|debug','Position',[120 20 100 20],'Value',4);
         end

        
        function Save_Settings_Callback(hObject,eventdata)
            handles.sbparam.convert = regexprep(regexprep(num2str(get(convert,'Value')-1),'0','false'),'1','true');
            handles.sbparam.writefiles  = regexprep(regexprep(num2str(get(writefiles,'Value')-1),'0','false'),'1','true');
            handles.sbparam.overwrite  = regexprep(regexprep(num2str(get(overwrite,'Value')-1),'0','false'),'1','true');
            handles.sbparam.usesequence  = regexprep(regexprep(num2str(get(usesequence,'Value')-1),'0','false'),'1','true');
            handles.sbparam.sequencesuffix = get(sequencesuffix,'String');
            handles.sbparam.writebgfiles  = regexprep(regexprep(num2str(get(writebgfiles,'Value')-1),'0','false'),'1','true');
            handles.sbparam.readbgfiles  = regexprep(regexprep(num2str(get(readbgfiles,'Value')-1),'0','false'),'1','true');
            handles.sbparam.bgfilename = lower(get(bgfilename,'String'));
            handles.sbparam.n_bg_std_thresh_low = get(n_bg_std_thresh_low,'String');
            handles.sbparam.n_bg_std_thresh_high = get(n_bg_std_thresh_high,'String');
            handles.sbparam.est_algorithm = regexprep(regexprep(num2str(get(est_algorithm,'Value')-1),'0','median'),'1','mean');
            handles.sbparam.normalize_by = regexprep(regexprep(num2str(get(est_algorithm,'Value')-1),'0','standarddeviation'),'1','other');
            handles.sbparam.difference_mode= regexprep(regexprep(num2str(get(difference_mode,'Value')-1),'0','lightondark'),'1','darkonlight');
            handles.sbparam.bg_nframes = get(bg_nframes,'String');
            handles.sbparam.bg_std_min = get(bg_std_min,'String');
            handles.sbparam.bg_std_max = get(bg_std_max,'String');
            handles.sbparam.summaryfile = get(summaryfile,'String');
            handles.sbparam.logfile = get(logfile,'String');
            handles.sbparam.fileloglevel = regexprep(regexprep(regexprep(regexprep(num2str(get(fileloglevel,'Value')-1),'0','warning'),'1','info'),'2','info-plus'),'3','debug');
            handles.sbparam.screenloglevel = regexprep(regexprep(regexprep(regexprep(num2str(get(screenloglevel,'Value')-1),'0','warning'),'1','info'),'2','info-plus'),'3','debug');
            close(dlg);
        end     
    end
    function Create_SBParam_File()                                          % Create the overall string to submit to the home directory temporary sbparam file.
        handles.temp.sbparamfile = ['convert\t' handles.sbparam.convert '\n writefiles\t' handles.sbparam.writefiles '\n overwrite\t' handles.sbparam.overwrite '\n usesequence\t' handles.sbparam.usesequence '\n sequencesuffix\t' handles.sbparam.sequencesuffix '\n writebgfiles\t' handles.sbparam.writebgfiles '\n readbgfiles\t' handles.sbparam.readbgfiles '\n bgfilename\t' handles.sbparam.bgfilename '\n n_bg_std_thresh_low\t' handles.sbparam.n_bg_std_thresh_low '\n n_bg_std_thresh_high\t' handles.sbparam.n_bg_std_thresh_high '\n est_algorithm\t' handles.sbparam.est_algorithm '\n normalize_by\t' handles.sbparam.normalize_by '\n difference_mode\t' handles.sbparam.difference_mode '\n bg_nframes\t' handles.sbparam.bg_nframes '\n bg_std_min\t' handles.sbparam.bg_std_min '\n bg_std_max\t' handles.sbparam.bg_std_max '\n summaryfile\t' handles.sbparam.summaryfile '\n logfile\t' handles.sbparam.logfile '\n fileloglevel\t' handles.sbparam.fileloglevel '\n screenloglevel\t' handles.sbparam.screenloglevel];
        fid = fopen([handles.networkdrive ':' handles.sbconvert_settings],'w');
        fprintf(fid,handles.temp.sbparamfile);
        fclose(fid);
    end

    %% Tracking Functions
    function Change_CTrax_Param_Callback(hObject, eventdata)                % Change the parameters for the conversion
        % open a new dialog window!
        dlg = dialog('Units','pixels','Position',[400 300 740 650],'name','SBConvert settings','WindowStyle','normal');
        save = uicontrol('Units','pixels','Style','Pushbutton','String','Write Settings','Position',[20 620 200 20],'Callback',{@Save_Settings_Callback});   
        uicontrol('Units','pixels','String','Background-Type:','Style','text','Position',[20 590 100 15],'HorizontalAlignment','left');
        bg_type = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','Lightondark|Darkonlight','Position',[120 590 100 20],'Value',str2num(handles.ctrax.bg_type)+1);
       %  if strfind(handles.ctrax.bg_type,'lightondark')
           % bg_type = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','Lightondark|Darkonlight','Position',[120 590 100 20],'Value',1);
      %   else
          %   bg_type = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','Lightondark|Darkonlight','Position',[120 590 100 20],'Value',2);
      %   end
        uicontrol('Units','pixels','String','n_bg_std_thresh:','Style','text','Position',[20 560 100 15],'HorizontalAlignment','left');
        n_bg_std_thresh = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.n_bg_std_thresh,'Position',[120 560 100 20]);
        uicontrol('Units','pixels','String','n_bg_std_thresh_low:','Style','text','Position',[20 530 100 15],'HorizontalAlignment','left');
        n_bg_std_thresh_low = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.n_bg_std_thresh_low,'Position',[120 530 100 20]);  
         uicontrol('Units','pixels','String','bg_std_min:','Style','text','Position',[20 500 100 15],'HorizontalAlignment','left');
        bg_std_min = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.bg_std_min,'Position',[120 500 100 20]);
         uicontrol('Units','pixels','String','bg_std_max:','Style','text','Position',[20 470 100 15],'HorizontalAlignment','left');
        bg_std_max = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.bg_std_max,'Position',[120 470 100 20]);
         uicontrol('Units','pixels','String','n_bg_frames:','Style','text','Position',[20 440 100 15],'HorizontalAlignment','left');
        n_bg_frames = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.n_bg_frames,'Position',[120 440 100 20]);
         uicontrol('Units','pixels','String','min_nonarena:','Style','text','Position',[20 410 100 15],'HorizontalAlignment','left');
        min_nonarena = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.min_nonarena,'Position',[120 410 100 20]);
         uicontrol('Units','pixels','String','max_nonarena:','Style','text','Position',[20 380 100 15],'HorizontalAlignment','left');
        max_nonarena = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.max_nonarena,'Position',[120 380 100 20]);
     
          uicontrol('Units','pixels','String','do_set_circular_arena','Style','text','Position',[20 350 100 15],'HorizontalAlignment','left');
        do_set_circular_arena = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 350 100 20],'Value',str2num(handles.ctrax.do_set_circular_arena)+1);
      
          uicontrol('Units','pixels','String','do_use_morphology','Style','text','Position',[20 320 100 15],'HorizontalAlignment','left');
        do_use_morphology = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[120 320 100 20],'Value',str2num(handles.ctrax.do_use_morphology)+1);
      
          uicontrol('Units','pixels','String','opening_radius:','Style','text','Position',[20 290 100 15],'HorizontalAlignment','left');
        opening_radius = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.opening_radius,'Position',[120 290 100 20]);
        
          uicontrol('Units','pixels','String','closing_radius:','Style','text','Position',[20 260 100 15],'HorizontalAlignment','left');
        closing_radius = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.closing_radius,'Position',[120 260 100 20]);
        
        
      uicontrol('Units','pixels','String','bg_algorithm','Style','text','Position',[20 230 100 15],'HorizontalAlignment','left');
         if strfind(handles.ctrax.bg_algorithm,'median')
            bg_algorithm = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','median|mean','Position',[120 230 100 20],'Value',1);
         else
            bg_algorithm = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','median|mean','Position',[120 230 100 20],'Value',2);
         end
         
    uicontrol('Units','pixels','String','hm_cutoff:','Style','text','Position',[20 200 100 15],'HorizontalAlignment','left');
        hm_cutoff = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.hm_cutoff,'Position',[120 200 100 20]);
          uicontrol('Units','pixels','String','hm_boost:','Style','text','Position',[20 170 100 15],'HorizontalAlignment','left');
        hm_boost = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.hm_boost,'Position',[120 170 100 20]);
          uicontrol('Units','pixels','String','hm_order:','Style','text','Position',[20 140 100 15],'HorizontalAlignment','left');
        hm_order = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.hm_order,'Position',[120 140 100 20]);
        
        
            uicontrol('Units','pixels','String','maxarea:','Style','text','Position',[20 110 100 15],'HorizontalAlignment','left');
        maxarea = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxarea,'Position',[120 110 100 20]);
          uicontrol('Units','pixels','String','maxmajor:','Style','text','Position',[20 80 100 15],'HorizontalAlignment','left');
        maxmajor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxmajor,'Position',[120 80 100 20]);
          uicontrol('Units','pixels','String','maxminor:','Style','text','Position',[20 50 100 15],'HorizontalAlignment','left');
        maxminor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxminor,'Position',[120 50 100 20]);
        
            uicontrol('Units','pixels','String','maxecc:','Style','text','Position',[20 20 100 15],'HorizontalAlignment','left');
        maxecc = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxecc,'Position',[120 20 100 20]);
        
        
          uicontrol('Units','pixels','String','minarea:','Style','text','Position',[240 590 100 15],'HorizontalAlignment','left');
        minarea = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minarea,'Position',[340 590 100 20]);
          uicontrol('Units','pixels','String','minmajor:','Style','text','Position',[240 560 100 15],'HorizontalAlignment','left');
        minmajor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minmajor,'Position',[340 560 100 20]);
        
           uicontrol('Units','pixels','String','minminor:','Style','text','Position',[240 530 100 15],'HorizontalAlignment','left');
        minminor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minminor,'Position',[340 530 100 20]);
          uicontrol('Units','pixels','String','minecc:','Style','text','Position',[240 500 100 15],'HorizontalAlignment','left');
        minecc = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minecc,'Position',[340 500 100 20]);
           uicontrol('Units','pixels','String','meanarea:','Style','text','Position',[240 470 100 15],'HorizontalAlignment','left');
        meanarea = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.meanarea,'Position',[340 470 100 20]);
          uicontrol('Units','pixels','String','meanmajor:','Style','text','Position',[240 440 100 15],'HorizontalAlignment','left');
        meanmajor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.meanmajor,'Position',[340 440 100 20]);
           uicontrol('Units','pixels','String','meanminor:','Style','text','Position',[240 410 100 15],'HorizontalAlignment','left');
        meanminor = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.meanminor,'Position',[340 410 100 20]);
          uicontrol('Units','pixels','String','meanecc:','Style','text','Position',[240 380 100 15],'HorizontalAlignment','left');
        meanecc = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.meanecc,'Position',[340 380 100 20]);
           uicontrol('Units','pixels','String','nframes_size:','Style','text','Position',[240 350 100 15],'HorizontalAlignment','left');
        nframes_size = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.nframes_size,'Position',[340 350 100 20]);
          uicontrol('Units','pixels','String','nstr_shape:','Style','text','Position',[240 320 100 15],'HorizontalAlignment','left');
        nstr_shape = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.nstr_shape,'Position',[340 320 100 20]);
    
        
         uicontrol('Units','pixels','String','max_jump:','Style','text','Position',[240 290 100 15],'HorizontalAlignment','left');
        max_jump = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.max_jump,'Position',[340 290 100 20]);
           uicontrol('Units','pixels','String','ang_dist_wt:','Style','text','Position',[240 260 100 15],'HorizontalAlignment','left');
        ang_dist_wt = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.ang_dist_wt,'Position',[340 260 100 20]);
          uicontrol('Units','pixels','String','center_dampen:','Style','text','Position',[240 230 100 15],'HorizontalAlignment','left');
        center_dampen = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.center_dampen,'Position',[340 230 100 20]);
           uicontrol('Units','pixels','String','angle_dampen:','Style','text','Position',[240 200 100 15],'HorizontalAlignment','left');
        angle_dampen = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.angle_dampen,'Position',[340 200 100 20]);
          uicontrol('Units','pixels','String','velocity_angle_weight:','Style','text','Position',[240 170 100 15],'HorizontalAlignment','left');
        velocity_angle_weight = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.velocity_angle_weight,'Position',[340 170 100 20]);
           uicontrol('Units','pixels','String','max_velocity_angle_weight:','Style','text','Position',[240 140 100 15],'HorizontalAlignment','left');
        max_velocity_angle_weight = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.max_velocity_angle_weight,'Position',[340 140 100 20]);
          uicontrol('Units','pixels','String','minbackthresh:','Style','text','Position',[240 110 100 15],'HorizontalAlignment','left');
        minbackthresh = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minbackthresh,'Position',[340 110 100 20]);
           uicontrol('Units','pixels','String','maxpenaltymerge:','Style','text','Position',[240 80 100 15],'HorizontalAlignment','left');
        maxpenaltymerge = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxpenaltymerge,'Position',[340 80 100 20]);
          uicontrol('Units','pixels','String','maxareadelete:','Style','text','Position',[240 50 100 15],'HorizontalAlignment','left');
        maxareadelete = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.maxareadelete,'Position',[340 50 100 20]);
        
          uicontrol('Units','pixels','String','minareaignore:','Style','text','Position',[240 20 100 15],'HorizontalAlignment','left');
        minareaignore = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.minareaignore,'Position',[340 20 100 20]);
        

     uicontrol('Units','pixels','String','do_fix_split','Style','text','Position',[460 590 100 15],'HorizontalAlignment','left');
        do_fix_split = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[560 590 100 20],'Value',str2num(handles.ctrax.do_fix_split)+1);
      
          uicontrol('Units','pixels','String','splitdetection_length:','Style','text','Position',[460 560 100 15],'HorizontalAlignment','left');
        splitdetection_length = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.splitdetection_length,'Position',[560 560 100 20]);
          uicontrol('Units','pixels','String','splitdetection_cost:','Style','text','Position',[460 530 100 15],'HorizontalAlignment','left');
        splitdetection_cost = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.splitdetection_cost,'Position',[560 530 100 20]);

        
         uicontrol('Units','pixels','String','do_fix_merged','Style','text','Position',[460 500 100 15],'HorizontalAlignment','left');
        do_fix_merged = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[560 500 100 20],'Value',str2num(handles.ctrax.do_fix_merged)+1);
          uicontrol('Units','pixels','String','mergedetection_length:','Style','text','Position',[460 470 100 15],'HorizontalAlignment','left');
        mergedetection_length = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.mergedetection_length,'Position',[560 470 100 20]);
          uicontrol('Units','pixels','String','mergedetection_distance:','Style','text','Position',[460 440 100 15],'HorizontalAlignment','left');
        mergedetection_distance = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.mergedetection_distance,'Position',[560 440 100 20]);
        
           uicontrol('Units','pixels','String','do_fix_spurios','Style','text','Position',[460 410 100 15],'HorizontalAlignment','left');
        do_fix_spurios = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[560 410 100 20],'Value',str2num(handles.ctrax.do_fix_spurios)+1);
          uicontrol('Units','pixels','String','spuriosdetection_length:','Style','text','Position',[460 380 100 15],'HorizontalAlignment','left');
        spuriosdetection_length = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.spuriosdetection_length,'Position',[560 380 100 20]);
      
      uicontrol('Units','pixels','String','do_fix_lost','Style','text','Position',[460 350 100 15],'HorizontalAlignment','left');
        do_fix_lost = uicontrol('Units','pixels','Style','popup','BackgroundColor','white','String','false|true','Position',[560 350 100 20],'Value',str2num(handles.ctrax.do_fix_lost)+1);
          uicontrol('Units','pixels','String','lostdetection_length:','Style','text','Position',[460 320 100 15],'HorizontalAlignment','left');
        lostdetection_length = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.lostdetection_length,'Position',[560 320 100 20]);
      

  uicontrol('Units','pixels','String','start_frame:','Style','text','Position',[460 290 100 15],'HorizontalAlignment','left');
        start_frame = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.start_frame,'Position',[560 290 100 20]);
     
        uicontrol('Units','pixels','String','arena_center_x:','Style','text','Position',[460 260 100 15],'HorizontalAlignment','left');
        arena_center_x = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.arena_center_x,'Position',[560 260 100 20]);
        
        
        uicontrol('Units','pixels','String','arena_center_y:','Style','text','Position',[460 230 100 15],'HorizontalAlignment','left');
        arena_center_y = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.arena_center_y,'Position',[560 230 100 20]);
        
        uicontrol('Units','pixels','String','arena_radius:','Style','text','Position',[460 200 100 15],'HorizontalAlignment','left');
        arena_radius = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax.arena_radius,'Position',[560 200 100 20]);
        
        function Save_Settings_Callback(hObject,eventdata)
            
            
            
            handles.ctrax.bg_type = regexprep(regexprep(num2str(get(bg_type,'Value')-1),'0','0'),'1','1');
            handles.ctrax.n_bg_std_thresh = get(n_bg_std_thresh,'String');
            handles.ctrax.n_bg_std_thresh_low = get(n_bg_std_thresh_low,'String');
            handles.ctrax.bg_std_min = get(bg_std_min,'String');
            handles.ctrax.bg_std_max = get(bg_std_max,'String');
            handles.ctrax.n_bg_frames = get(n_bg_frames,'String');
            handles.ctrax.min_nonarena = get(min_nonarena,'String');
            handles.ctrax.max_nonarena = get(max_nonarena,'String');
            handles.ctrax.do_set_circular_arena = regexprep(regexprep(num2str(get(do_set_circular_arena,'Value')-1),'0','false'),'1','true');
            handles.ctrax.do_use_morphology = regexprep(regexprep(num2str(get(do_use_morphology,'Value')-1),'0','false'),'1','true');
            handles.ctrax.opening_radius = get(opening_radius,'String');
            handles.ctrax.closing_radius = get(closing_radius,'String');
            handles.ctrax.bg_algorithm = regexprep(regexprep(num2str(get(bg_algorithm,'Value')-1),'0','median'),'1','mean');
            
            handles.ctrax.hm_cutoff = get(hm_cutoff,'String');
            handles.ctrax.hm_boost = get(hm_boost,'String');
            handles.ctrax.hm_order = get(hm_order,'String');
            handles.ctrax.maxarea = get(maxarea,'String');
            handles.ctrax.maxmajor = get(maxmajor,'String');
            handles.ctrax.maxminor = get(maxminor,'String');
            handles.ctrax.maxecc = get(maxecc,'String');
            handles.ctrax.minarea = get(minarea,'String');
            handles.ctrax.minmajor = get(minmajor,'String');
            handles.ctrax.minminor = get(minminor,'String');
            handles.ctrax.minecc = get(minecc,'String');
            handles.ctrax.meanarea = get(meanarea,'String');
            handles.ctrax.meanmajor = get(meanmajor,'String');
            handles.ctrax.meanminor = get(meanminor,'String');
            handles.ctrax.meanecc = get(meanecc,'String');
            handles.ctrax.nframes_size = get(nframes_size,'String');
            handles.ctrax.nstr_shape = get(nstr_shape,'String');
            handles.ctrax.max_jump = get(max_jump,'String');
            handles.ctrax.ang_dist_wt = get(ang_dist_wt,'String');
            handles.ctrax.center_dampen = get(center_dampen,'String');
            handles.ctrax.angle_dampen = get(angle_dampen,'String');
            handles.ctrax.velocity_angle_weight = get(velocity_angle_weight,'String');
            handles.ctrax.max_velocity_angle_weight = get(max_velocity_angle_weight,'String');
            handles.ctrax.minbackthresh = get(minbackthresh,'String');
            handles.ctrax.maxpenaltymerge = get(maxpenaltymerge,'String');
            handles.ctrax.maxareadelete = get(maxareadelete,'String');
            handles.ctrax.minareaignore = get(minareaignore,'String');

            handles.ctrax.do_fix_split = regexprep(regexprep(num2str(get(do_fix_split,'Value')-1),'0','false'),'1','true');
            handles.ctrax.splitdetection_length = get(splitdetection_length,'String');
            handles.ctrax.splitdetection_cost = get(splitdetection_cost,'String');
            handles.ctrax.do_fix_merged = regexprep(regexprep(num2str(get(do_fix_merged,'Value')-1),'0','false'),'1','true');
            handles.ctrax.mergedetection_length = get(mergedetection_length,'String');
            handles.ctrax.mergedetection_distance = get(mergedetection_distance,'String');
            handles.ctrax.do_fix_spurios = regexprep(regexprep(num2str(get(do_fix_spurios,'Value')-1),'0','false'),'1','true');
            handles.ctrax.spuriosdetection_length = get(spuriosdetection_length,'String');
            handles.ctrax.do_fix_lost = regexprep(regexprep(num2str(get(do_fix_lost,'Value')-1),'0','false'),'1','true');
            handles.ctrax.lostdetection_length = get(lostdetection_length,'String');
            handles.ctrax.start_frame = get(start_frame,'String');
            handles.ctrax.arena_center_x = get(arena_center_x,'String');
            handles.ctrax.arena_center_y = get(arena_center_y,'String');
            handles.ctrax.arena_radius = get(arena_radius,'String');
            close(dlg);
          
        end     
    end
    function Create_CTrax_File()                                            % Create the overall string to submit to the home directory temporary ctrax file.
        handles.temp.ctraxfile = ['Ctrax header\nversion:0.1.2\nbg_type: ' handles.ctrax.bg_type '\nn_bg_std_thresh: ' handles.ctrax.n_bg_std_thresh '\nn_bg_std_thresh_low: ' handles.ctrax.n_bg_std_thresh_low '\nbg_std_min: ' handles.ctrax.bg_std_min '\nbg_std_max: ' handles.ctrax.bg_std_max '\nn_bg_frames: ' handles.ctrax.n_bg_frames '\nmin_nonarena: ' handles.ctrax.min_nonarena '\nmax_nonarena: ' handles.ctrax.max_nonarena '\narena_center_x: ' handles.ctrax.arena_center_x '\narena_center_y: ' handles.ctrax.arena_center_y '\narena_radius: ' handles.ctrax.arena_radius '\ndo_set_circular_arena: ' handles.ctrax.do_set_circular_arena '\ndo_use_morphology: ' handles.ctrax.do_use_morphology '\nopening_radius: ' handles.ctrax.opening_radius '\nclosing_radius: ' handles.ctrax.closing_radius '\nbg_algorithm: ' handles.ctrax.bg_algorithm '\nhm_cutoff: ' handles.ctrax.hm_cutoff '\nhm_boost: ' handles.ctrax.hm_boost '\nhm_order: ' handles.ctrax.hm_order '\nmaxarea: ' handles.ctrax.maxarea '\nmaxmajor: ' handles.ctrax.maxmajor '\nmaxminor: ' handles.ctrax.maxminor '\nmaxecc: ' handles.ctrax.maxecc '\nminarea: ' handles.ctrax.minarea '\nminmajor: ' handles.ctrax.minmajor '\nminminor: ' handles.ctrax.minminor '\nminecc: ' handles.ctrax.minecc '\nmeanarea: ' handles.ctrax.meanarea '\nmeanmajor: ' handles.ctrax.meanmajor '\nmeanminor: ' handles.ctrax.meanminor '\nmeanecc: ' handles.ctrax.meanecc '\nnframes_size: ' handles.ctrax.nframes_size '\nnstr_shape: ' handles.ctrax.nstr_shape '\nmax_jump: ' handles.ctrax.max_jump '\nang_dist_wt: ' handles.ctrax.ang_dist_wt '\ncenter_dampen: ' handles.ctrax.center_dampen '\nangle_dampen: ' handles.ctrax.angle_dampen '\nvelocity_angle_weight: ' handles.ctrax.velocity_angle_weight '\nmax_velocity_angle_weight: ' handles.ctrax.max_velocity_angle_weight '\nminbackthresh: ' handles.ctrax.minbackthresh '\nmaxpenaltymerge: ' handles.ctrax.maxpenaltymerge '\nmaxareadelete: ' handles.ctrax.maxareadelete '\nminareaignore: ' handles.ctrax.minareaignore '\ndo_fix_split: ' handles.ctrax.do_fix_split '\nsplitdetection_length: ' handles.ctrax.splitdetection_length '\nsplitdetection_cost: ' handles.ctrax.splitdetection_cost '\ndo_fix_merged: ' handles.ctrax.do_fix_merged '\nmergedetection_length: ' handles.ctrax.mergedetection_length '\nmergedetection_distance: ' handles.ctrax.mergedetection_distance '\ndo_fix_spurios: ' handles.ctrax.do_fix_spurios '\nspuriosdetection_length: ' handles.ctrax.spuriosdetection_length '\ndo_fix_lost: ' handles.ctrax.do_fix_lost '\nlostdetection_length: ' handles.ctrax.lostdetection_length '\nstart_frame: ' handles.ctrax.start_frame '\ndata format:identity x y major minor angle\nend header\n'];
        fid = fopen([handles.networkdrive ':' handles.ctrax_settings],'w');
        fprintf(fid,handles.temp.ctraxfile);
        fclose(fid);
    end
    function Delete_CTrax_Logs()                                            % delete CTraxSettings.ann in home directory
          delete([handles.networkdrive ':\CTraxSettings.ann']); 
        if isempty(dir([handles.networkdrive ':\CTraxSettings.ann']))
            UpdateStatus(['Deleting CTrax settings: successful. '],'white');
        else
            UpdateStatus(['Deleting CTrax settings: failed. '],'red');
        end
    end
    function Analyze_Tracking()                                             % Analyze the quality of the tracking (how many flies found in which frame, ...)
        color1 = 'b';
        reference_color = 'r';
        number_of_plots = length(handles.temp.ctrax_filelist)
    
        max_value = 0;
    
        fig = figure('Name','Analysis of tracking quality I','Color',[1 1 1]); 
    
        for a=1:number_of_plots
            S = load(handles.temp.ctrax_filelist(a).local, '-mat');
        
            % Figure: Rel. histogram of errors in number of detected flies
            subplot(ceil(sqrt(number_of_plots)),ceil(sqrt(number_of_plots)),a);
            [N, X] = hist(S.ntargets);
            h = bar(X, N./sum(N), 1,'histc');
            set(h,'facecolor',color1)
            xlim([0 max(S.ntargets)+1]);
            ylim([0 1]); 
            box off
            drawnow
            if max(S.ntargets)+1 > max_value
                max_value = max(S.ntargets)+1;
            end
        end
    
        save2pdf([handles.networkdrive ':\tracking_quality_overview.pdf'],fig,150);

        % And a summary figure with the mean and stddev tracking quality of all
        % tracks in the previous plots. 
        value = zeros(max_value+1,number_of_plots);
    
        fig2 = figure('Name','Analysis of tracking quality II','Color',[1 1 1]); 
   
        % calculate the mean
        for b=1:max_value
        for a=1:number_of_plots
            S = load(handles.temp.ctrax_filelist(a).local, '-mat');
            value(b,a) = length(find(S.ntargets == b-1))/length(S.ntargets);  
        end
    end
    bar([0:1:max_value],mean(value,2))
    hold on
    errorbar([0:1:max_value],mean(value,2),std(value,0,2),['.' reference_color]);

    title(['Summary of tracking-quality']);
    box off
    
    save2pdf([handles.networkdrive ':\tracking_quality_summary.pdf'],fig2,150);
        
        % 1. put one analysis per video
        % 2. one overall analysis for all tracked videos.
    end

    %% Miscellaneous Functions
    function Abort_Callback(hObject, eventdata)                             % Abort current jobs on the cluster
         [status,result] = dos([handles.path_to_plink ' -ssh ' handles.hostname ' -l ' handles.username ' -pw ' handles.password ' env PATH=/sge/current/bin/lx24-amd64:/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin SGE_EXECD_PORT=1539 SGE_ROOT=/sge/current SGE_QMASTER_PORT=1538 qdel -u ' handles.username ';exit']);
             if status ~= 0
                UpdateStatus(result,'red');
             else
                UpdateStatus(result,'white');
             end
             stop(handles.timer);
              UpdateStatus(['Current jobs aborted...'],'green');
              EnableAfterRun();
     end
    function DisableDuringRun()                                             % Disable buttons during run
        set(handles.select_files,'Enable','off');
        set(handles.get_directory,'Enable','off');
        set(handles.clear_files,'Enable','off');
        set(handles.change_sbconvert_param,'Enable','off');
        set(handles.change_ctrax_param,'Enable','off');
        set(handles.start_conversion,'Enable','off');
       
        set(handles.analyze_sbfmfs,'Enable','off');
        set(handles.sbfmf_warninglevel,'Enable','off');
        set(handles.onlyconvert,'Enable','off');
        set(handles.timeout,'Enable','off');
        set(handles.timeoutvalue,'Enable','off');
        set(handles.delete_logs,'Enable','off');
        set(handles.analyze_tracking,'Enable','off');
        set(handles.change_global_params,'Enable','off');
         set(handles.load_settings,'Enable','off');
         set(handles.save_settings,'Enable','off');
         
        
        
        set(handles.abort,'Enable','on');
        set(handles.quit,'Enable','off');  
    end
    function EnableAfterRun()                                               % Enable buttons after run
        set(handles.select_files,'Enable','on');
        set(handles.get_directory,'Enable','on');
        set(handles.clear_files,'Enable','on');
        set(handles.change_sbconvert_param,'Enable','on');
        set(handles.change_ctrax_param,'Enable','on');
        set(handles.start_conversion,'Enable','on');
        set(handles.settings,'Visible','on');
        set(handles.abort,'Enable','off');
        set(handles.quit,'Enable','on');  
         set(handles.analyze_sbfmfs,'Enable','on');
        set(handles.sbfmf_warninglevel,'Enable','on');
        set(handles.onlyconvert,'Enable','on');
        set(handles.timeout,'Enable','on');
        set(handles.timeoutvalue,'Enable','on');
        set(handles.delete_logs,'Enable','on');
        set(handles.analyze_tracking,'Enable','on');
        set(handles.change_global_params,'Enable','on');
         set(handles.load_settings,'Enable','on');
         set(handles.save_settings,'Enable','on');
    end
    function Load_Settings_Callback(hObject,eventdata)                      % Load settings
        [FileName,PathName,FilterIndex] = uigetfile('*.mat','Load settings file');
        S = load([PathName FileName] ,'-mat');
        handles.var = S.handles.var;
        handles.ctrax = S.handles.ctrax;
        handles.sbparam = S.handles.sbparam;
        handles.sbconvert_settings = S.handles.sbconvert_settings;
        handles.networkdrive = S.handles.networkdrive;
        handles.abs_home_path = S.handles.abs_home_path;
        handles.hostname = S.handles.hostname;
        handles.username = S.handles.username;
        handles.password = S.handles.password;
        handles.path_to_plink = S.handles.path_to_plink;
        handles.timer_frequency = S.handles.timer_frequency;
        handles.timer = S.handles.timer;
        handles.ctrax_settings = S.handles.ctrax_settings;
        
        set(handles.onlyconvert,'Value',handles.var.onlyconvert);
        set(handles.analyze_sbfmfs,'Value',handles.var.analyze_sbfmf);
        set(handles.sbfmf_warninglevel,'String',handles.var.sbfmf_warninglevel);
        set(handles.timeout,'Value',handles.var.timeout);
        set(handles.timeoutvalue,'String',handles.var.timeoutvalue);
        set(handles.delete_logs,'Value',handles.var.delete_logs);
        set(handles.analyze_tracking,'Value',handles.var.analyze_tracking);
        
    end
    function Save_Settings_Callback(hObject,eventdata)                      % Save settings
         [filename, pathname] = uiputfile('settings.mat','Save program');
         File = fullfile(pathname,filename);
         handles.var.sbfmf_warninglevel = get(handles.sbfmf_warninglevel,'String');
         handles.var.timeoutvalue = get(handles.timeoutvalue,'String');
         save(File,'handles');  
    end
    function Quit_Callback(hObject,eventdata)                               % Save and quit
        handles.var.avi_filelist = '';
        handles.var.sbfmf_filelist = '';
        handles.var.ctrax_filelist = '';
         handles.var.sbfmf_warninglevel = get(handles.sbfmf_warninglevel,'String');
         handles.var.timeoutvalue = get(handles.timeoutvalue,'String');
         close(handles.mygui);
         save('./required/settings','handles');  
         
    end
    function Change_Globals_Callback(hObject,eventdata)                     % Change global settings
          dlg = dialog('Units','pixels','Position',[400 300 500 650],'name','Global settings','WindowStyle','normal');
         save = uicontrol('Units','pixels','Style','Pushbutton','String','Write Settings','Position',[20 620 200 20],'Callback',{@Save_Settings_Callback});   
        
        uicontrol('Units','pixels','String','Location SBConvert Settings file:','Style','text','Position',[20 590 200 15],'HorizontalAlignment','left');
        sbconvert_settings = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.sbconvert_settings,'Position',[220 590 200 20]);
        uicontrol('Units','pixels','String','Location CTrax Settings file:','Style','text','Position',[20 560 200 15],'HorizontalAlignment','left');
        ctrax_settings = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.ctrax_settings,'Position',[220 560 200 20]);
        uicontrol('Units','pixels','String','Letter of networkdrive:','Style','text','Position',[20 530 200 15],'HorizontalAlignment','left');
        networkdrive = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.networkdrive,'Position',[220 530 200 20]);
        uicontrol('Units','pixels','String','Absolute home path on network:','Style','text','Position',[20 500 200 15],'HorizontalAlignment','left');
        abs_home_path = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.abs_home_path,'Position',[220 500 200 20]);
        uicontrol('Units','pixels','String','Username:','Style','text','Position',[20 470 200 15],'HorizontalAlignment','left');
        username = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.username,'Position',[220 470 200 20]);
        uicontrol('Units','pixels','String','Password:','Style','text','Position',[20 440 200 15],'HorizontalAlignment','left');
        password = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String','','Position',[220 440 200 20]);
        uicontrol('Units','pixels','String','Timer update frequency:','Style','text','Position',[20 410 200 15],'HorizontalAlignment','left');
        timer_frequency = uicontrol('Units','pixels','Style','edit','BackgroundColor','white','String',handles.timer_frequency,'Position',[220 410 200 20]);
        
        
          function Save_Settings_Callback(hObject,eventdata)
           
            handles.sbconvert_settings = get(sbconvert_settings,'String');
            handles.ctrax_settings = get(ctrax_settings,'String');
            handles.networkdrive = get(networkdrive,'String');
            handles.abs_home_path = get(abs_home_path,'String');
            handles.username = get(username,'String');
            handles.password = get(password,'String');
            handles.timer_frequency = get(timer_frequency,'String');
            close(dlg);
        end     
       
        
        

      
    end

end



