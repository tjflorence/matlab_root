classdef flyTempObj
   %flyTempObj 
   % simplifies tracking of thermal properites for thermal control
   % to add: loading data back into object; would simplify plotting
   
    properties
        
        % pointer to current save location
        p = 0;
        
        % property histories - all have 's'
        mtemps        = nan(1,300*50);
        timeStamps    = nan(1,300*50);
        dTimes        = nan(1,300*50);
        stemps        = nan(1,300*50);  
        errors        = nan(1,300*50);  
        derivatives   = nan(1,300*50);
        integrals     = nan(1,300*50);
        outputs       = nan(300*50,2);
        
        % current state of measured, set, error
        current_mtemp = nan;
        current_stemp = nan;
        current_error = nan;
        current_output = nan(1,2);
        
        % metadata
        setTemps = [24 32 34 35 36 38 40];
        thermCalc = [.0051 -75.5];
        K_ivals = [.4 .3 .3];
        K_dvals = [0 0 0];
        

    end
    
    methods
        
        %% constructor, save, and desctructor methods
        function obj = flyTempObj()
        %% class constructor
        
        % pointer to current save location
            obj.p = 0;
            
        % property histories
            obj.mtemps       = nan(1,300*50);
            obj.timeStamps    = nan(1,300*50);
            obj.dTimes        = nan(1,300*50);
            obj.stemps       = nan(1,300*50);  
            obj.errors        = nan(1,300*50);  
            obj.derivatives   = nan(1,300*50);
            obj.integrals     = nan(1,300*50);
            obj.outputs       = nan(1,300*50);
        
        % current state of measured, set, error
            obj.current_mtemp = nan;
            obj.current_stemp = nan;
            obj.current_error = nan;
            obj.current_output = nan;
        
        % metadata
            obj.setTemps = [24 32 34 35 36 38 40];
            obj.thermCalc = [.0051 -75.5];
            obj.K_ivals = [.4 .3 .3];
            obj.K_dvals = [0 0 0];
        end
        
        % save data when we want to!
        function obj = saveData(obj, save_name)
            
            thermal_data.mtemps     = obj.mtemps;
            thermal_data.stemps     = obj.stemps;
            thermal_data.timeStamp  = obj.timeStamp;
            thermal_data.dTime      = obj.dTime;
            thermal_data.error      = obj.error;
            
            save(save_name, 'thermal_data')
            
        end

        
        % increase pointer value
        function obj = advance(obj)
            
            obj.p = obj.p + 1;
            
        end
        
        % read in measured temp from camera
        function obj = read_mtemp(obj, mtemp)
            
           obj.current_mtemp = mtemp;
           obj.mtemps(1,obj.p) = mtemp;
            
        end
        
        % read in measured temp from camera
        function obj = read_stemp(obj, idx)
           
           stemp = obj.setTemps(idx); 
           obj.current_stemp = stemp;
           obj.stemps(1,obj.p) = stemp;
            
        end
        
        function obj = calc_error(obj)
           
            obj.current_error(obj.p) = obj.current_stemp(obj.p) - obj.current_mtemp(obj.p);
            obj.errors(obj.p) = obj.current_error;
            
        end
        
        % calculate output
        function obj = calc_output(obj)
            
            % first part: handle calculation of derivative & integral (requires dTime)
            if obj.p < 2 
                % handle first frame
                obj.dTimes(1)        = 0;
                obj.integrals(1)     = 0;
                obj.derivatives(1)   = 0;
            else
                % for every other frame
                obj.dTimes(obj.p)          = obj.timeStamps(obj.p)-obj.timeStamps(obj.p-1);
                obj.derivatives(obj.p)     = (obj.errors(obj.p)-obj.errors(obj.p-1))/obj.dTimes(obj.p);

                if obj.current_stemp   ~= obj.stemps(obj.p-1);
                    obj.integrals(obj.p)   = 0;
                else
                    obj.integrals(obj.p)   = obj.integrals(obj.p-1) + (obj.errors(obj.p)*obj.dTimes(obj.p));
                end
            end
        
            % handles of 
            if obj.current_error > 0  
                output = (obj.K_ivals(1) * obj.errors(obj.p)) + (obj.K_ivals(2)  * obj.integrals(obj.p))...
                    + (obj.K_ivals(3) * obj.derivatives(obj.p));
            else
                output = (obj.K_dvals(1) * obj.errors(obj.p)) + (obj.K_dvals(2)  * obj.integrals(obj.p))...
                    + (obj.K_dvals(3) * obj.derivatives(obj.p));
            end
        
            %% 
            if obj.current_stemp(obj.p) == obj.setTemps(1)
            
                if obj.current_error > 5
                    output = [-4.99 0]; %% if error positive, cool off!
                else
                    output = [-4.99 5];
                end
                
            elseif obj.current_stemp(obj.p) == obj.setTemps(2)
                output = [-3.3 5];
                
            elseif  tempData.setPoint(tempData.p) > metaData.setTemps(2)...
                && tempData.setPoint(tempData.p) < metaData.setTemps(6)
                output = [-3.4 5];
            else
                output = [-3.1 5];
            end
       
            obj.current_output = output;
            obj.outputs(tempData.p,:) = output;
        

        
        end
        
        function obj = simple_plot(obj)
            
            f1 = figure;
            subplot(2,1,1)
            plot(obj.timeStamps(1:obj.p), obj.mtemps(1:obj.p), 'r')
            hold on
            plot(obj.timeStamps(1:obj.p), obj.stemps(1:obj.p), 'b')
            ylim([20 40])
            ylabel('°C')
            title(['frame rate =' num2str( (obj.p) / (obj.timeStamps(obj.p) - obj.timeStamps(1)) ) 'Hz'])

        
            subplot(2,1,2)
            plot(obj.timeStamps(1:obj.p), obj.outputs(1:obj.p), 'r')
            ylim([-5 0])
            ylabel('output')
            xlabel('time (s)')    

        end
        
        
             
        
    end
    
    
end