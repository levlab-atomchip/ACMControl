
classdef pDAQDevice
    properties
       taskHandle = -1;
       %isprimary = 0; %By default this is not master device 
       deviceMap = DeviceMap; %Will contain device lines
       timeLine %Contains information about the entire time line
       sampleRate %Contains information about sampling rate for device
    end
    
    properties (SetAccess = private)
        initialized = 0; %Initialized status
    end
    
    properties (SetAccess = private)
      rawStorage %Will contain parallel device based data  
    end
    
    methods
        function obj = pDAQDevice()
            obj.taskHandle = -1;
            obj.deviceMap = DeviceMap;
            obj.timeLine = [];
            obj.sampleRate = 0;
        end
        
        %Accessor Methods
        function obj = set.taskHandle(obj,value)
           obj.taskHandle = value;  
        end
        function value = get.taskHandle(obj)
           value = obj.taskHandle; 
        end
        
        %{
        function obj = set.isprimary(obj,value)
           obj.isprimary = value;  
        end
        function value = get.isprimary(obj)
           value = obj.isprimary; 
        end
        %}
                
        function obj = set.deviceMap(obj,value)
           obj.deviceMap = value;  
        end
        function value = get.deviceMap(obj)
           value = obj.deviceMap; 
        end
               
        function obj = set.timeLine(obj,value)
           obj.timeLine = value;  
        end
        function value = get.timeLine(obj)
           value = obj.timeLine; 
        end
        
        function obj = set.rawStorage(obj,value)
           obj.rawStorage = value;  
        end
        function value = get.rawStorage(obj)
           value = obj.rawStorage; 
        end
        
        function obj = set.sampleRate(obj,value)
           obj.sampleRate = value;  
        end
        function value = get.sampleRate(obj)
           value = obj.sampleRate; 
        end
        
        %Main Functions
        function obj = initialize(obj)
            %This function is responsible for creating the total 
            %array that will contain the analog/digital data.
            %This REQURIES timeLine to be setup along with sampleRate
            %Once initalized device cannot be changed. To change it must
            %be reset first.
            
            obj.rawStorage = cell(1, 2);
            
            %display(obj.deviceMap.digitalLinesCount*obj.timeLine.durationTime*obj.sampleRate);
            
%             disp(sprintf('dig: %i',obj.deviceMap.digitalLinesCount))
%             disp(sprintf('analog: %i',obj.deviceMap.analogLinesCount))
%             disp(sprintf('time: %i',obj.timeLine.durationTime*obj.sampleRate))
%             disp(sprintf('timeline: %i',obj.timeLine.durationTime))
            t = round(obj.timeLine.durationTime*obj.sampleRate);
%             size(zeros(obj.deviceMap.digitalLinesCount,t))
            obj.rawStorage(1) = {zeros(obj.deviceMap.digitalLinesCount,t)};
            obj.rawStorage(2) = {zeros(obj.deviceMap.analogLinesCount,t)};
            
            
%             obj.rawStorage(1) = {zeros(obj.deviceMap.digitalLinesCount,obj.timeLine.durationTime*obj.sampleRate)};
%             obj.rawStorage(2) = {zeros(obj.deviceMap.analogLinesCount,obj.timeLine.durationTime*obj.sampleRate)};
            %%block rawStorage size is one unit smaller than Experiment's
            %%%array length...in all cases?
%             obj.rawStorage(1) = {zeros(obj.deviceMap.digitalLinesCount,obj.timeLine.durationTime*obj.sampleRate+1)};
%             obj.rawStorage(2) = {zeros(obj.deviceMap.analogLinesCount,obj.timeLine.durationTime*obj.sampleRate+1)};

%             disp(sprintf('length of rawStorage(1): %f' ,size(obj.rawStorage{1},2)))
%             disp(sprintf('length of rawStorage(2): %f' ,size(obj.rawStorage{2},2)))
%             disp(size(obj.rawStorage{1}))
            obj.initialized = 1; %Initialization Lock            
        end
        
        %Generic function to add data to a line
        %Automatically figures out whether line is analog or digital
        function obj = addLineData(obj, lineIndex, startTime, data)
  
            if(obj.initialized ~= 1)
                error('Device has not been initialized!')
            end
            
            lines = obj.deviceMap.lineCollection;
            
            if(~lines.containsKey(lineIndex))
                error('Line is not present. Can not add data!')
            else
                
                line = lines.get(lineIndex);
                ap = int32(startTime*obj.sampleRate) + 1;
                ep = int32(size(data,1));
                loc = int32(line.get(1));
                
                p = 0;
                if(size(line) == 3)
                    %Digital Line
                    p = 1;
                else 
                    p=2;
                end
%                 disp(sprintf('Size of data: %f,%f',[size(data,1),size(data,2)]))
%                 disp(sprintf('Size of rawStorage: %f,%f',[size(obj.rawStorage{p}(loc,:),1),size(obj.rawStorage{p}(loc,:),2)]))
                obj.rawStorage{p}(loc,:) = data;
                
            end
        end
        
        function obj = removeLineData(obj, lineIndex)
            if(obj.initialized ~= 1)
                error('Device has not been initialized!')
            end
            
            lines = obj.deviceMap.lineCollection;
            
            if(~lines.containsKey(lineIndex))
                error('Line is not present. Can not remove data!')
            else
                line = lines.get(lineIndex);
                loc = int32(line.get(1));
                
                p = 0;
                if(size(line) == 3)
                    %Digital Line
                    p = 1;
                else 
                    p=2;
                end
                    
                    disp(loc)
                    disp(size(obj.rawStorage{p}))
                    obj.rawStorage{p}(loc,:) = [];
                    
            end
            return
        end
        
        
        
    end
end