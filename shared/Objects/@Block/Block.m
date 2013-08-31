
classdef Block
    properties
       blockName
       timeLine
       primaryDevice
    end
    
    properties (SetAccess = private)
       devices = cell(1,2);
       deviceCount = 0;
    end
    
    properties (SetAccess = private, GetAccess = private)
       deviceNames = java.util.HashMap; 
    end
    
    methods
        %Constructor
        function obj = Block(bname, tline)
            if(nargin == 0)
               obj.blockName = '';
               obj.timeLine = [];
            else
                obj.blockName = bname;
                obj.timeLine = tline;
            end
            
            obj.deviceNames = java.util.HashMap;
            obj.devices = cell(1,2);
            obj.deviceCount = 0;
        end
        
        %Accessor Methods
        function obj = set.blockName(obj,value)
           obj.blockName = value;  
        end
        function value = get.blockName(obj)
           value = obj.blockName;
        end

        function obj = set.timeLine(obj,value)
           obj.timeLine = value;  
        end
        function value = get.timeLine(obj)
           value = obj.timeLine;
        end
        
        function obj = set.primaryDevice(obj,value)
           obj.primaryDevice = value;  
        end
        function value = get.primaryDevice(obj)
           value = obj.primaryDevice;
        end

        function obj = set.devices(obj,value)
           obj.devices = value;  
        end
        function value = get.devices(obj)
           value = obj.devices;
        end
        
        function obj = set.deviceCount(obj,value)
           obj.deviceCount = value;  
        end
        function value = get.deviceCount(obj)
           value = obj.deviceCount;
        end
        
        function obj = set.deviceNames(obj,value)
           obj.deviceNames = value;  
        end
        function value = get.deviceNames(obj)
           value = obj.deviceNames;
        end
        
        
        %Main methods
        
        function obj = addDevice(obj,deviceName, sampleRate)
            
            if(obj.deviceNames.containsKey(deviceName))
                display('Device already exists!');
            else
                obj.deviceCount = obj.deviceCount + 1;
                
                obj.deviceNames.put(deviceName,obj.deviceCount);
                obj.devices{obj.deviceCount,1} = deviceName;
                obj.devices{obj.deviceCount,2} = pDAQDevice;
                obj.devices{obj.deviceCount,2}.sampleRate = sampleRate;
                obj.devices{obj.deviceCount,2}.taskHandle = 0;
                
                obj.devices{obj.deviceCount,2}.timeLine = obj.timeLine;
            end
        end
        
        function obj = removeDevice(obj,deviceName)
            
            if(obj.deviceNames.containsKey(deviceName))
               
               obj.deviceNames.clear;
               newcells = cell(obj.deviceCount - 1, 2);
               p = 1;
               for i = 1:obj.deviceCount
                   if(strcmp(obj.devices{i,1},deviceName) == 0)
                       newcells{p,1} = obj.devices{i,1};
                       newcells{p,2} = obj.devices{i,2};
                       obj.deviceNames.put(obj.devices{i,1},p)
                       
                       p = p + 1;
                   end
               end
               
               clear(obj.devices);
               obj.devices = newcells;
            end
        end
        
        function obj = addLine(obj, deviceName, lineName, hdwName, minV,...
                maxV)
            
            if(obj.deviceNames.containsKey(deviceName))
                deviceIndex = obj.deviceNames.get(deviceName);
                
                if( nargin == 4)
                    line = DigitalLine(lineName,...
                        obj.devices{deviceIndex,2} ...
                        .deviceMap.digitalLinesCount+1,hdwName);
                elseif  (nargin == 6)
                    line = AnalogLine(lineName,...
                        obj.devices{deviceIndex,2}...
                        .deviceMap.analogLinesCount+1,hdwName, minV, maxV);
                end
                obj.devices{deviceIndex,2}.deviceMap = ...
                    obj.devices{deviceIndex,2}.deviceMap.addLine(line);
            else
                error('Device not found!');
            end
            
        end
        
        function obj = removeLine(obj, deviceName, lineIndex)
           
            if(obj.deviceNames.containsKey(deviceName))
                deviceIndex = obj.deviceNames.get(deviceName);
                device = obj.devices{deviceIndex,2};
                device.deviceMap = device.deviceMap.removeLine(lineIndex);
            else
                error('Device not found!');
            end
        end
        
        function obj = initializeDevice(obj, deviceName)
            if(obj.deviceNames.containsKey(deviceName))
                deviceIndex = obj.deviceNames.get(deviceName);
                
                obj.devices{deviceIndex,2} = obj.devices{...
                    deviceIndex,2}.initialize();
            else
                error('Device not found!');
            end
        end
        
        function obj = initializeAllDevices(obj)
                for i = 1:size(obj.devices,1)
                   obj.devices{i,2} = obj.devices{i,2}.initialize();
                end
        end
        
        function obj = addLineData(obj, deviceName, lineIndex,...
                startTime, lineData)
            if(obj.deviceNames.containsKey(deviceName))
                deviceIndex = obj.deviceNames.get(deviceName);
                
                obj.devices{deviceIndex,2} = ...
                    obj.devices{deviceIndex,2}.addLineData(lineIndex,...
                    startTime, lineData);
            else
                error('Device not found!');
            end
        end
        
        %HARDWARE DEFINITIONS
        
        function obj = initializeHardware(obj,deviceName)
            if(nargin == 1)
                deviceName = obj.primaryDevice;
            end
            
            p = obj.deviceNames.get(deviceName);
            if(~obj.devices{p,2}.initialized)
                display('Master device has not been initialzed!');
                return;
            end
            
            obj = obj.assocTasksToDevices;
            obj = obj.createHardwareLines;
            obj = obj.setClocks(deviceName);
        end
        
        function obj = run(obj,deviceName)
        %This is full sequence running including task setup and so forth
        %This may be run multiple times
            if(nargin == 1)
                deviceName = obj.primaryDevice;
            end

            p = obj.deviceNames.get(deviceName);
            if(~obj.devices{p,2}.initialized)
                display('Master device has not been initialzed!');
                return;
            end

            obj = obj.writeToHardware;

            for i = 1:size(obj.devices,1)
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                if(i~=p)
                    
                   %display(['Starting: '  obj.devices{i,1}]);
                   [errorStartTask] = calllib('ni','DAQmxStartTask',...
                       uint32(obj.devices{i,2}.taskHandle));
                    
                   if(errorStartTask <0)
                        error(num2Str(errorStartTask),...
                            'Could not start task!');
                   end
                end
            end
           
            %Start Master Task
           [errorStartTask] = calllib('ni','DAQmxStartTask',...
               uint32(obj.devices{p,2}.taskHandle));

           if(errorStartTask <0)
                error(num2Str(errorStartTask),...
                    'Could not start master task!');
           end
           
           %Wait for Other tasks to end
           %{ 
           for i = 1:size(obj.devices,1)
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                if(i~=p)
                    taskdone = int32(0);
                    taskdoneptr = libpointer('uint32Ptr',taskdone);
                    [errorTaskQuery] = calllib('ni','DAQmxIsTaskDone',...
                    uint32(obj.devices{i,2}.taskHandle),taskdoneptr);
                    while(get(taskdoneptr,'Value')==0 && errorTaskQuery==0)
                        [errorTaskQuery] = calllib('ni','DAQmxIsTaskDone',...
                        uint32(obj.devices{i,2}.taskHandle),taskdoneptr);
                    end
                    if(errorTaskQuery < 0)
                        error(num2str(errorTaskQuery),...
                            'Error during task exec!');
                    end
                end
            end
           %}
           
           %Wait For Main Task to End
            taskdone = int32(0);
            taskdoneptr = libpointer('uint32Ptr',taskdone);
            [errorTaskQuery] = calllib('ni','DAQmxIsTaskDone',...
                uint32(obj.devices{p,2}.taskHandle),taskdoneptr);
            while(get(taskdoneptr,'Value')==0 && errorTaskQuery==0)
                [errorTaskQuery] = calllib('ni','DAQmxIsTaskDone',...
                    uint32(obj.devices{p,2}.taskHandle),taskdoneptr);
            end
            if(errorTaskQuery < 0)
                error(num2str(errorTaskQuery),'Error during task exec!');
            end
            
            obj = obj.stopTasks;
        end
        
        function obj = stopTasks(obj)
             for i = 1:size(obj.devices,1)
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                   [errorStopTask] = calllib('ni','DAQmxStopTask',...
                       uint32(obj.devices{i,2}.taskHandle));
                    
                   if(errorStopTask <0)
                        error(num2Str(errorStopTask),...
                            'Could not clear task!');
                   end
            end
        end
        
        function obj = clearTasks(obj)
            for i = 1:size(obj.devices,1)
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                   [errorClearTask] = calllib('ni','DAQmxClearTask',...
                       uint32(obj.devices{i,2}.taskHandle));
                    
                   if(errorClearTask <0)
                        error(num2Str(errorClearTask),...
                            'Could not clear task!');
                   end
            end
        end
        
        function displayAll(obj)
            %Show entire block structure 
            %Actual data is not shown
            display(sprintf('Block Name: %s\n',obj.blockName));
            for i = 1:size(obj.devices,1)
                if(isempty(obj.devices{i,1}))
                    continue
                end
                
                display(sprintf('Device name: %s',obj.devices{i,1}));
                display(sprintf('Device name: %d',...
                    obj.devices{i,2}.taskHandle));
                display(sprintf('Device Sample Rate: %3.2e',...
                    obj.devices{i,2}.sampleRate));
                display(sprintf('Device Status: %d',...
                    obj.devices{i,2}.initialized));
                
                m = obj.devices{i,2}.deviceMap;
                display(sprintf('Digital Line Count: %d',...
                    m.digitalLinesCount));
                display(sprintf('Analog Line Count: %d\n',...
                    m.analogLinesCount));
                
                lines = m.getAllLines;
                for j = 1:size(lines,2)
                    if(isempty(lines{j}))
                        continue;
                    elseif(isa(lines{j},'DigitalLine'))
                        display(sprintf('Digital Line'));
                        display(sprintf('Line Index: %s',...
                            lines{j}.lineIndex));
                        display(sprintf('Line Hdw: %s\n',...
                            lines{j}.hdwName));
                   elseif(isa(lines{j},'AnalogLine'))
                        display(sprintf('Analog Line'));
                        display(sprintf('Line Index: %s',...
                            lines{j}.lineIndex));
                        display(sprintf('Line Hdw: %s',...
                            lines{j}.hdwName));
                        display(sprintf('Min Volts: %3.2e',...
                            lines{j}.minVoltage));
                        display(sprintf('Max Volts: %3.2e\n',...
                            lines{j}.maxVoltage));
                   end
                end
            end
        end
        
    end
    
    methods (Access = private)
        
        function obj = assocTasksToDevices(obj)
            for i = 1:size(obj.devices,1)
               if(~obj.devices{i,2}.initialized)
                   continue
               end
                
               deviceHandle = -1;
                   [initError, ~, deviceHandle] = ...
                       calllib('ni','DAQmxCreateTask','',deviceHandle);
                  
               if(initError < 0)
                error('Could not get task handle! Try resetting via MAX');
               end
                    
               obj.devices{i,2}.taskHandle = deviceHandle;
            end     
        end
        
        function obj = createHardwareLines(obj)
            for i = 1:size(obj.devices,1)
                
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
               m = obj.devices{i,2}.deviceMap;
               lines = m.getAllLines;
               for j = 1:size(lines,2)
                   line = lines{j};
                  if(isa(line,'DigitalLine'))
                        
                      [errorHdw] = calllib('ni',...
                          'DAQmxCreateDOChan',...
                          uint32(obj.devices{i,2}.taskHandle),...
                          line.hdwName,'',int32(0));

                      if(errorHdw<0)
                          error(num2str(errorHdw),...
                              'Could not open digital line');
                      end

                  elseif(isa(line,'AnalogLine'))
                      [errorHdw] = calllib('ni',...
                          'DAQmxCreateAOVoltageChan',...
                          uint32(obj.devices{i,2}.taskHandle),...
                          line.hdwName,'',line.minVoltage,...
                          line.maxVoltage,uint32(10348),'');

                      if(errorHdw<0)
                          error(num2str(errorHdw),...
                              'Could not open analog line');
                      end
                  end
               end
            end
        end
        
        function obj = setClocks(obj,deviceName)
            %Use deviceName for primary device
            p = obj.deviceNames.get(deviceName);
            
            for i = 1:size(obj.devices,1)
                
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                if(i~=p)
                    clckSrc = ['/' deviceName '/DO/SampleClock'];
                else
                    clckSrc = '';
                end
                
                [error] = calllib('ni','DAQmxCfgSampClkTiming',...
                    uint32(obj.devices{i,2}.taskHandle),...
                    clckSrc,...
                    obj.devices{i,2}.sampleRate,...
                    int32(10171),...
                    int32(10178),...
                    uint64(obj.timeLine.durationTime*...
                    obj.devices{i,2}.sampleRate));

                if(error<0)
                    display('Could not set clocks!')
                end
            end
        end
        
        function obj = writeToHardware(obj)
            
            for i = 1:size(obj.devices,1)
                
                if(~obj.devices{i,2}.initialized)
                    continue
                end
                
                m = obj.devices{i,2}.deviceMap;

                if(m.digitalLinesCount > 0)
                    p = libpointer;
                    samplesWrittenDigital = int32(0);
                    sptr1 = libpointer('int32Ptr',samplesWrittenDigital);
                    
                    writeFcn = 'DAQmxWriteDigitalLines';
                    
                    outputPostData = reshape(obj.devices{i,2}.rawStorage{1},[],1);
                    
                    [errorWrite] = calllib('ni',writeFcn,...
                        uint32(obj.devices{i,2}.taskHandle),...
                        int32(obj.timeLine.durationTime*...
                        obj.devices{i,2}.sampleRate),int32(0), -1,...
                        int32(1),...
                        int32(outputPostData), sptr1,p);
                    
                    if(errorWrite < 0)
                        error(['Digital write failure! ' ...
                            num2str(errorWrite)]);
                    else
                        %display(get(sptr1,'value'));
                    end
                end
                
                if(m.analogLinesCount > 0)
                    p = libpointer;
                    samplesWrittenAnalog = int32(0);
                    sptr1 = libpointer('int32Ptr',samplesWrittenAnalog);
                    
                    writeFcn = 'DAQmxWriteAnalogF64';
                    outputPostData = reshape(obj.devices{i,2}.rawStorage{2},[],1);
                    
                    [errorWrite] = calllib('ni',writeFcn,...
                        uint32(obj.devices{i,2}.taskHandle),...
                        int32(obj.timeLine.durationTime*...
                        obj.devices{i,2}.sampleRate),int32(0), -1,...
                        int32(1),...
                        outputPostData, sptr1,p);    
                    
                    if(errorWrite < 0)
                        error(['Analog write failure! ' ...
                            num2str(errorWrite)]);
                    end
                end
            end
        end
    end
    
    methods (Static = true)
       
        function initializeLibrary(libPath)
            if(nargin == 0)
                libPath = '.\';
            end
            
            [notfound, warnings] = loadlibrary('nicaiu.dll',...
               [libPath 'headers\NIDAQmx.h'],'alias','ni');
        end
        
        function data = createDigitalTTL(totalLength, periodLength)
            
        end
        
    end
    
end
