classdef AnalogLine < Line
    properties
        minVoltage
        maxVoltage
    end
    methods
        function obj = AnalogLine(a, b, c, d, e)
            if nargin > 1
                lineIndex = a;
                lineName = b;
                hdwName = c;
                minvoltage = d;
                maxvoltage = e;
            else
                lineIndex = a.get(0);
                lineName = a.get(1);
                hdwName = a.get(2);
                minvoltage = a.get(3);
                maxvoltage = a.get(4);
            end
            
            obj = obj@Line(lineIndex,lineName, hdwName);
            obj.minVoltage = minvoltage;
            obj.maxVoltage = maxvoltage;
        end

                %Converter
        function objr = Java(obj)
            objr = java.util.ArrayList;
            objr.add(obj.lineIndex);
            objr.add(obj.lineName);
            objr.add(obj.hdwName);
            objr.add(obj.minVoltage);
            objr.add(obj.maxVoltage);
        end
        
        function obj = set.minVoltage(obj,value)
            if(strcmp(value,'')==1)
                error('lineName can not be empty')
            else
                obj.minVoltage = value;
            end
        end
        function value = get.minVoltage(obj)
            value = obj.minVoltage;
        end
        
        function obj = set.maxVoltage(obj,value)
            if(strcmp(value,'')==1)
                error('lineName can not be empty')
            else
                obj.maxVoltage = value;
            end
        end
        function value = get.maxVoltage(obj)
            value = obj.maxVoltage;
        end
        
    end
end