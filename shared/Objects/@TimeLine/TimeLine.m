
classdef TimeLine
   properties
      durationTime = 0;
      unit %deprecated for now
   end
   
   methods
        function obj = set.durationTime(obj,value)
           obj.durationTime = value;  
        end
        function value = get.durationTime(obj)
           value = obj.durationTime; 
        end
   end
end