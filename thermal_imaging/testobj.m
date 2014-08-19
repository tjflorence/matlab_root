classdef testobj
    
% I'm just testing out object oriented programming

    properties
        current_number = 0;
    end
    
    methods
        
        function obj = testobj()
            obj.current_number = 0;
        end
        
        function obj = addOne(obj)
            obj.current_number  = obj.current_number+1;
        end
        
        function obj = subtractOne(obj)
            obj.current_number = obj.current_number-1;
        end
        
    end
       
end
        
    