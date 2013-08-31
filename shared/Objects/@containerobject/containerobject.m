classdef containerobject < dynamicprops
    properties
        digitaldata
    end
    
    methods
        function obj = containerobject()
            obj.digitaldata = cell(0);
        end
        
        function newData = addDigital(obj,lineName,a,b,c,d)
            dt = .1;
            sbtime = 10;
            ddlength = length(obj.digitaldata) + 1;
            switch nargin
                case 3
                    obj.digitaldata{ddlength} = lineName;
                    addprop(obj,lineName);
                    obj.(lineName) = DigitalLineData(lineName,a);
                    return
                case 5
                    obj.digitaldata{ddlength} = lineName;
                    addprop(obj,lineName);
                    obj.(lineName) = DigitalLineData(lineName,a,b,c);
                    return
                case 6
                    obj.digitaldata{ddlength} = lineName;
                    addprop(obj,lineName);
                    obj.(lineName) = DigitalLineData(lineName,a,b,c,d);
                    return
                otherwise
                    error('Incorrect number of inputs for DigitalLineData.')
            end
        end
    end
end