
classdef Line
    properties
        lineIndex = -1;
        lineName = '';
        hdwName = '';
    end
    methods (Abstract)
        %Converter
        obj = Java(obj)
    end
    
    methods
        %Constructor
        function obj = Line(lineIndex, lineName, hdwName)
            obj.lineName = lineName;
            obj.lineIndex = lineIndex;
            obj.hdwName = hdwName;
        end
                
        %Accessor Methods
        function obj = set.lineName(obj,value)
            if(strcmp(value,'') == 1)
                error('lineName can not be empty')
            else
                obj.lineName = value;
            end
        end
        function value = get.lineName(obj)
            value = obj.lineName;
        end
        
        function obj = set.lineIndex(obj,value)
            if(value < 0)
                error('lineIndex can not be negative');
            else
                obj.lineIndex = value;
            end
        end
        function value = get.lineIndex(obj)
            value = obj.lineIndex;
        end
        
        function obj = set.hdwName(obj,value)
            if(strcmp(value,'')==1)
                error('lineName can not be empty')
            else
                obj.hdwName = value;
            end
        end
        function value = get.hdwName(obj)
            value = obj.hdwName;
        end 
    end
end
