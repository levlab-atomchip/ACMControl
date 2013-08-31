classdef DigitalLine < Line
    properties
    end
    
    methods
        function obj = DigitalLine(a, b, c)
            if nargin > 1
                lineIndex = a;
                lineName = b;
                hdwName = c;
            else
                lineIndex = a.get(0);
                lineName = a.get(1);
                hdwName = a.get(2);
            end
            
            obj = obj@Line(lineIndex,lineName, hdwName);
        end
        
        %Converter
        function objr = Java(obj)
            objr = java.util.ArrayList;
            objr.add(obj.lineIndex);
            objr.add(obj.lineName);
            objr.add(obj.hdwName);
        end
    end
end