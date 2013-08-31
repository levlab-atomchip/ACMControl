classdef LineData < handle
    properties
        dispstat
        lineName
        array
        devLine
    end
    
    properties (Abstract = true)
        mode
    end
    
    properties (SetAccess = protected)
    end
    
    methods
        %Constructor
        function obj = LineData(lineName,mode,dispstat,devLine)
            if ~ischar(lineName)
                error('LineData lineName must be a string.')
            end
            
            obj.lineName = lineName;
            
            obj.mode = mode;
            
            if isempty(dispstat)
                obj.dispstat = [];
            else
                switch dispstat
                    case {1 'on'}
                        obj.dispstat = 1;
                    case {0 'off'}
                        obj.dispstat = 0;
                    otherwise
                        error('LineData dispstat must be ''on'' (1) or ''off'' (0).')
                end
            end
            
            obj.devLine = devLine;
            
            obj.array = [];
        end
        
        %Accessor Methods
        function set.dispstat(obj,value)
            if isempty(value)
                obj.dispstat = [];
            else
                switch value
                    case {1 'on'}
                        obj.dispstat = 1;
                    case {0 'off'}
                        obj.dispstat = 0;
                    otherwise
                        error('LineData dispstat must be ''on'' (1) or ''off'' (0).')
                end
            end
        end
        function value = get.dispstat(obj)
            value = obj.dispstat;
        end
        
        function value = get.lineName(obj)
            value = obj.lineName;
        end
        
        function set.array(obj,value)
            obj.array = value;
        end
        function value = get.array(obj)
            value = obj.array;
        end
        
        %Main methods
        function value = arraytime(obj,time1,time2)
            switch nargin
                case 2
                    obj.checktime(time1)
                    itime1 = round(time1/obj.dt)+1;
                    obj.checkindices(itime1)
                    value = obj.array(itime1);
                case 3
                    obj.checktime(time1)
                    obj.checktime(time2)
                    itime1 = round(time1/obj.dt)+1;
                    itime2 = round(time2/obj.dt);
                    obj.checkindices(itime1,itime2);
                    value = obj.array(itime1:itime2);
                otherwise
                    error('Incorrect number of inputs')
            end
        end
        
        function checkarray(obj,ind)
            if ind(2) > length(obj.array)
                obj.array((length(obj.array)+1):ind(2),1) = NaN;
            end
        end
        
        function nobj = copy(obj)
            nobj = feval(class(obj));
            po = properties(obj);
            pn = properties(nobj);
            for i = 1:length(po)
                if ~sum(strcmp(po{i},pn))
                    addprop(nobj,po{i});
                    nobj.(po{i}) = obj.(po{i}).copy;
                elseif sum(strcmp(po{i},{'on' 'off'}))
                    continue
                else
                    nobj.(po{i}) = obj.(po{i});
                end
            end
        end
    end
    
    methods (Static)
        function checktime(time)
            if ~isnumeric(time) || time < 0
                error('Times must be numbers greater than or equal to zero.')
            end
        end
        
        function istart = checkindices(ind,istart,istop)
            if nargin == 2
                istop = istart;
            end
            if istop < istart
                error('Start index cannot be greater than end index.')
            end
            if istop > ind(2)
                error('Cannot write in SubBlocks after current SubBlock.')
            end
            if istart < 1
                istart = 1;
                warning('Attempted to write at time less than zero.')
            end
            if istart < ind(1)
%                 warning('Overwriting entries in previous SubBlock(s).')
            end
        end
    end
        
end