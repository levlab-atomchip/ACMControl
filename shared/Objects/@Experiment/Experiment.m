
classdef Experiment < dynamicprops
    properties
        dt
        subBlocks
        lines
        output
        time
        currSubBlock
        calledSubBlocks
        currLine
        explength
        
        %DDS Digital Lines
        ddsWrite
        ddsReset
        ddsPowerdown
        ddsIOUpdate
        ddsInputArray
        ddsProfile0
        ddsProfile1
        ddsProfile2
        ddsProfile3

    end
    
    methods
        %Constructor
        function obj = Experiment(dt)
            if ~nargin
                dt = [];
            end
            obj.dt = dt;
            obj.subBlocks = cell(0);
            obj.lines = cell(0);
            obj.output = [];
            obj.currSubBlock = '';
            obj.calledSubBlocks = 0;
            obj.currLine = '';
            obj.ddsInputArray = cell(0,1);
        end
        
        %Accessors
        function list = get.subBlocks(obj)
            list = obj.subBlocks;
        end
        
        function list = get.lines(obj)
            list = obj.lines;
        end
        
        %Main methods
        function addLine(obj,type,lineName,a,b,c,d,e,f)
            if sum(strcmp(obj.lines,lineName))
                error(['LineData already exists with name ' lineName '.'])
            end
            addprop(obj,lineName);
            switch type
                case {'digital' 'Digital' 'd' 'D'}
                    switch (nargin-1)
                        case 4
                            obj.(lineName) = DigitalLineData(lineName,a,b);
                        case 6
                            obj.(lineName) = DigitalLineData(lineName,a,b,c,d);
                        case 7
                            obj.(lineName) = DigitalLineData(lineName,a,b,c,d,e);
                        otherwise
                            error('Incorrect number of inputs for DigitalLineData.')
                    end
                    
                case {'analog' 'Analog' 'a' 'A'}
                    switch (nargin-1)
                        case 5
                            obj.(lineName) = AnalogLineData(lineName,a,b,c);
                        case 7
                            obj.(lineName) = AnalogLineData(lineName,a,b,c,d,e);
                        case 8
                            obj.(lineName) = AnalogLineData(lineName,a,b,c,d,e,f);
                        otherwise
                            error('Incorrect number of inputs for AnalogLineData.')
                    end
                    
                case {'dds' 'DDS'}
                    switch (nargin)
                        case 6
                            obj.(lineName) = DDSLineData(lineName,a,b,c);
                        case 7
                            obj.(lineName) = DDSLineData(lineName,a,b,c,d);
                        case 8
                            obj.(lineName) = DDSLineData(lineName,a,b,c,d,e);
                        otherwise
                            error('Incorrect number of inputs for DDSLineData.')
                    end
                    
                otherwise
                    error('LineData type must be ''digital,'' ''analog,'' or ''dds''.')
            end
            obj.lines = [obj.lines lineName];
        end
        
        function addSubBlock(obj,subBlockName,time,position)
            if ~ischar(subBlockName)
                error('SubBlock name must be a string.')
            end
            if sum(strcmp(obj.subBlocks,subBlockName))
                error(['A SubBlock already exists with name ' subBlockName '.'])
            end
            if length(obj.subBlocks) >= position && ~isempty(obj.subBlocks{position})
                error(['A SubBlock already exists at position ' num2str(position) '.'])
            end
            if floor(position) ~= position || position <= 0
                error('SubBlock position must be an integer greater than zero.')
            end
            
            addprop(obj,subBlockName);
            
            obj.(subBlockName) = SubBlock(subBlockName,time,position);
            obj.subBlocks{position} = subBlockName;
            
            obj.calledSubBlocks(length(obj.calledSubBlocks):position) = 0;
        end
        
        function ddscompile(obj,parnum,ddsCOMPort)
            wait = round(500e-6/obj.dt);
            expprops = properties(obj);
            writes = [];
            ddslines = {};
            channels = [];
            for i = 1:length(expprops)
                if strcmp('DDSLineData',class(obj.(expprops{i})))
                    lineName = expprops{i};
                    obj.(lineName).freqcompile
                    writes = [writes; obj.(lineName).Writes];
                    switch writes(end,end)
                        case 0
                            ch0 = obj.(lineName).lineName;
                        case 1
                            ch1 = obj.(lineName).lineName;
                        case 2
                            ch2 = obj.(lineName).lineName;
                        case 3
                            ch3 = obj.(lineName).lineName;
                    end
                    ddslines = [ddslines lineName];
                    channels = [channels obj.(lineName).ch];
                end
            end
            
            if isempty(ddslines)
                return;
            end
            ddslength = length(obj.(ddslines{1}).freqarray);
            obj.ddsWrite = ones(ddslength,1);
            obj.ddsReset = zeros(ddslength,1);
            obj.ddsPowerdown = zeros(ddslength,1);
            obj.ddsIOUpdate = zeros(ddslength,1);
            
            obj.ddsProfile3 = ones(ddslength,1);
            obj.ddsProfile2 = ones(ddslength,1);
            obj.ddsProfile1 = ones(ddslength,1);
            obj.ddsProfile0 = ones(ddslength,1);
            
            writes = sortrows(sortrows(writes,5),1);
            
            if any(isnan(writes(:,2))) || any(writes(:,2)==-Inf)
                for i = 1:size(writes,1)
                    if isnan(writes(i,2)) || writes(i,2)==-Inf
                        rind = writes(i,1);
                        ochannels = sort(channels(channels~=writes(i,5)));
                        counter = 2;
                        for j = 1:length(ochannels)
                            for k = 1:size(writes,1)
                                if (isnan(writes(k,2)) || writes(k,2)==-Inf) && all(writes(k,[1 5])==[rind ochannels(j)])
                                    writes(k,:) = [counter*wait+1 Inf writes(k,3:5)];
                                    counter = counter+1;
                                    break
                                elseif k==size(writes,1)
                                    error('problem')
                                end
                            end
                        end
                    end
                end
            end
            
            if any((diff(writes(:,1))*obj.dt)<500e-6)
                disp(writes)
                error('not sufficient time to write DDS sequence')
            end
            
            for i = 1:length(writes(:,1))
                istart = writes(i,1);
                idur = writes(i,2);
                fstart = writes(i,3);
                fjump = writes(i,3);
                fstop = writes(i,4);
                ch = writes(i,5);
                
                switch ch
                    case 0
                        lineName = ch0;
                    case 1
                        lineName = ch1;
                    case 2
                        lineName = ch2;
                    case 3
                        lineName = ch3;
                end
                
                if idur==-Inf
                    obj.writenoreset(istart,ddslines)
                    istart = istart+wait;
                    obj.writejump(lineName,fjump,istart)
                
                elseif isnan(idur)
                    obj.writereset(istart,ddslines)
                    istart = istart+wait;
                    obj.writejump(lineName,fjump,istart)
                    
                elseif isinf(idur)
                    if istart==1
                        istart = istart+wait;
                    end
                    obj.writejump(lineName,fjump,istart)
                    
                else
                    obj.writesweep(lineName,fstart,fstop,istart,idur)
                    
                end
            end
            
            ddsInputArrays = obj.ddsInputArray;
            save(['DDSCode' num2str(parnum)],'ddsInputArrays','ddsCOMPort')
%             genhex(obj.ddsInputArray,['DDSCode' num2str(parnum)])
        end
        
        function writereset(obj,istart,ddslines)
            obj.ddsReset(istart) = 1;
            obj.ddsWrite(istart) = 1;
            obj.ddsPowerdown(istart) = 0;
            obj.ddsIOUpdate(istart) = 0;
            for i = 1:length(ddslines)
                obj.(ddslines{i}).enabled = 0;
            end
        end
        
        function writenoreset(obj,istart,ddslines)
            obj.ddsReset(istart) = 0;
            obj.ddsWrite(istart) = 1;
            obj.ddsPowerdown(istart) = 0;
            obj.ddsIOUpdate(istart) = 0;
            for i = 1:length(ddslines)
                obj.(ddslines{i}).enabled = 0;
            end
        end
        
        function writejump(obj,lineName,fjump,istart)
            reg00 = 0;
            switch obj.(lineName).ch
                case 0
                    csr = bin2dec('00010000');
                case 1
                    csr = bin2dec('00100000');
                case 2
                    csr = bin2dec('01000000');
                case 3
                    csr = bin2dec('10000000');
            end
            
            if ~obj.(lineName).enabled && ~(obj.(lineName).ch==2)
                reg01 = 1;
                pllstr = dec2bin(obj.(lineName).ratioPLL,5);
%                 pllarr = pllstr == '1';
                fr1 = [bin2dec(['1' pllstr '00']) 0 0];
%                 fr1 = [1 pllarr 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                obj.(lineName).enabled = 1;
            else
                reg01 = [];
                fr1 = [];
            end
            
            if ~strcmp(obj.(lineName).opMode,'singletone')
                reg03 = 3;
                cfr = [bin2dec('00000000') bin2dec('00000011')  bin2dec('00000000')]; %disable linear sweep
                obj.(lineName).opMode = 'singletone';
            else
                reg03 = [];
                cfr = [];
            end
            
            reg04 = 4;
            cftw0str = dec2bin(round(2^32 * fjump/obj.(lineName).sysFreq),32);%write frequency
            cftw0 = [bin2dec(cftw0str(1:8)) bin2dec(cftw0str(9:16)) bin2dec(cftw0str(17:24)) bin2dec(cftw0str(25:32))];
%             cftw0 = cftw0str == '1';
            
            writearray = [reg00 csr reg01 fr1 reg03 cfr reg04 cftw0];
            
            obj.addwrite(writearray);
            
            obj.ddsIOUpdate(istart) = 1;
        end
        
        function writesweep(obj,lineName,fstart,fstop,istart,idur)
            ch = obj.(lineName).ch;
            
            fmin = min([fstart fstop]);
            fmax = max([fstart fstop]);
            
            if strcmp(obj.(lineName).opMode,'linswpnrm')
                flow = fmin;
                fhigh = fmax;
            elseif strcmp(obj.(lineName).opMode,'linswpinv')
                flow = obj.(lineName).sysFreq - fmax;
                fhigh = obj.(lineName).sysFreq - fmin;
            elseif fstart < fstop
                flow = fstart;
                fhigh = fstop;
            elseif fstart > fstop
                flow = obj.(lineName).sysFreq - fstart;
                fhigh = obj.(lineName).sysFreq - fstop;
            end
            
            
            delta = fhigh - flow;
            
            tdur = idur*obj.dt;
            
            reg00 = 0;
            switch ch
                case 0
                    csr = bin2dec('00010000');
                case 1
                    csr = bin2dec('00100000');
                case 2
                    csr = bin2dec('01000000');
                case 3
                    csr = bin2dec('10000000');
            end
            
            if ~obj.(lineName).enabled
                reg01 = 1;
                pllstr = dec2bin(obj.(lineName).ratioPLL,5);
%                 pllarr = pllstr == '1';
                fr1 = [bin2dec(['1' pllstr '00']) 0 0];
%                 fr1 = [1 pllarr 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
                obj.(lineName).enabled = 1;
            else
                reg01 = [];
                fr1 = [];
            end
            
            if ~any(strcmp(obj.(lineName).opMode,{'linswpnrm' 'linswpinv'}))
                reg03 = 3;
                cfr = [bin2dec('10000000')  bin2dec('01000011')  bin2dec('00000000')]; %enable linear sweep
                if fstart < fstop
                    obj.(lineName).opMode = 'linswpnrm';
                elseif fstart > fstop
                    obj.(lineName).opMode = 'linswpinv';
                end
            else
                reg03 = [];
                cfr = [];
            end
            
            if isempty(obj.(lineName).lowFreq) || obj.(lineName).lowFreq ~= flow
                reg04 = 4;
                cftw0str = dec2bin(round(2^32 * flow/obj.(lineName).sysFreq),32);%write frequency
                cftw0 = [bin2dec(cftw0str(1:8)) bin2dec(cftw0str(9:16)) bin2dec(cftw0str(17:24)) bin2dec(cftw0str(25:32))];
%                 cftw0 = cftw0str == '1';
                obj.(lineName).lowFreq = flow;
            else
                reg04 = [];
                cftw0 = [];
            end
            
            if isempty(obj.(lineName).highFreq) || obj.(lineName).highFreq ~= fhigh
                reg0A = 10;
                cw1str = dec2bin(round(2^32 * fhigh/obj.(lineName).sysFreq),32);%write frequency
                cw1 = [bin2dec(cw1str(1:8)) bin2dec(cw1str(9:16)) bin2dec(cw1str(17:24)) bin2dec(cw1str(25:32))];
%                 cw1 = cw1str == '1';
                obj.(lineName).highFreq = fhigh;
            else
                reg0A = [];
                cw1 = [];
            end
            
            %srr
            reg07 = 7;
            srr = 0;
            r_freq_error = 1;
            while (r_freq_error > obj.(lineName).freqTol) && (srr < 2^8)
                srr = srr + 1;
                dw = round((abs(delta)*2^32*4*srr)/(obj.(lineName).sysFreq^2 * tdur));
                r_freq_error = abs(((dw * obj.(lineName).sysFreq^2 * tdur)/(4*2^32 * srr) - abs(delta))/abs(delta));
            end
            lsrr = [srr srr];
%             lsrrstr = [num2str(dec2bin(srr,8)) num2str(dec2bin(srr,8))];
%             lsrr = lsrrstr == '1';
            
            %dw
            reg08 = [];
            lsrrdw = [];
            reg09 = [];
            lsrfdw = [];
            dwstr = dec2bin(dw,32);
            dwarray = [bin2dec(dwstr(1:8))  bin2dec(dwstr(9:16)) bin2dec(dwstr(17:24)) bin2dec(dwstr(25:32))];
%             dwarray = dwstr == '1';
            if strcmp(obj.(lineName).opMode,'linswpnrm')
                if fstart < fstop
                    reg08 = 8;
                    lsrrdw = dwarray;
                else
                    reg09 = 9;
                    lsrfdw = dwarray;
                end
            elseif strcmp(obj.(lineName).opMode,'linswpinv')
                if fstart > fstop
                    reg08 = 8;
                    lsrrdw = dwarray;
                else
                    reg09 = 9;
                    lsrfdw = dwarray;
                end
            end
            
            writearray = [reg00 csr reg01 fr1 reg03 cfr reg04 cftw0 reg0A cw1 reg07 lsrr reg08 lsrrdw reg09 lsrfdw];
            
            obj.addwrite(writearray);
            
            obj.ddsIOUpdate(istart) = 1;
            
            if strcmp(obj.(lineName).opMode,'linswpnrm')
                if fstart > fstop
                    obj.(['ddsProfile' num2str(ch)])(istart:end) = 0;
                else
                    obj.(['ddsProfile' num2str(ch)])(istart:end) = 1;
                end
            elseif strcmp(obj.(lineName).opMode,'linswpinv')
                if fstart > fstop
                    obj.(['ddsProfile' num2str(ch)])(istart:end) = 1;
                else
                    obj.(['ddsProfile' num2str(ch)])(istart:end) = 0;
                end
            end
            
        end
        
        function addwrite(obj,writestring)
            ws = length(obj.ddsInputArray(:,1));
            obj.ddsInputArray{ws+1,1} = [length(writestring) writestring];
            lastupdate = max([find(obj.ddsIOUpdate==1,1,'last') find(obj.ddsReset==1,1,'last')]);
            obj.ddsWrite(sum(lastupdate)+1) = 0;
        end
        
        function varargout = loadExpSubBlocks(obj,expName,lines)
            if ~any(strcmp(obj.subBlocks,'Reset')) || ~any(strcmp(obj.subBlocks,'Imaging'))
                error('Must include ''Imaging'' and ''Reset'' SubBlocks.')
            end
            lSBs = '';
            for i = 1:length(obj.subBlocks)
                if isempty(obj.subBlocks{i}) || any(strcmp(obj.subBlocks{i},{'Imaging' 'Reset'}))
                    continue
                end
                obj.(obj.subBlocks{i}).load(expName,lines)
                lSBs = [lSBs obj.subBlocks{i} ' '];
            end
            varargout = {lSBs};
            disp(['     Experiment SubBlocks: ' lSBs])
        end
        
        function loadImgRstSubBlocks(obj,expName,lines)
            if ~any(strcmp(obj.subBlocks,'Reset')) || ~any(strcmp(obj.subBlocks,'Imaging'))
                error('Must include ''Imaging'' and ''Reset'' SubBlocks.')
            end
            for i = 1:length(obj.subBlocks)
                if isempty(obj.subBlocks{i}) || ~any(strcmp(obj.subBlocks{i},{'Imaging' 'Reset'}))
                    continue
                end
                obj.(obj.subBlocks{i}).load(expName,lines)
            end
        end
        
        function block = fillblock(obj,block,ddslines)
            DDSChs = [];
            addArgs={};
            for i = 1:length(obj.lines)
                addArgs = {};
                lineName = obj.lines{i};
                switch class(obj.(lineName))
                    case 'AnalogLineData'
                        addArgs = {obj.(lineName).min obj.(lineName).max};
                    case 'DDSLineData'
                        DDSChs = [DDSChs obj.(lineName).ch];
                        continue;
                end
                devLine = obj.(lineName).devLine;
                idev = find(devLine=='/',1,'first')-1;
                dev = devLine(1:idev);
                block = block.addLine(dev,lineName,devLine,addArgs{:});
            end
            
            if ~isempty(DDSChs)
                block = block.addLine(ddslines.write(1:4), 'DDSWrite',ddslines.write);
                block = block.addLine(ddslines.ioupdate(1:4), 'DDSIOUpdate',ddslines.ioupdate);
                block = block.addLine(ddslines.reset(1:4), 'DDSReset',ddslines.reset);
                for i = 1:length(DDSChs)
                    switch DDSChs(i)
                        case 0
                            block = block.addLine(ddslines.profile0(1:4), 'DDSProfile0',ddslines.profile0);
                        case 1
                            block = block.addLine(ddslines.profile1(1:4), 'DDSProfile1',ddslines.profile1);
                        case 2
                            block = block.addLine(ddslines.profile2(1:4), 'DDSProfile2',ddslines.profile2);
                        case 3
                            block = block.addLine(ddslines.profile3(1:4), 'DDSProfile3',ddslines.profile3);
                    end
                end
            end
            
            block = block.initializeAllDevices();
            
            for i = 1:length(obj.lines)
                lineName = obj.lines{i};
                if strcmp(class(obj.(lineName)),'DDSLineData')
                    continue;
                end
                devLine = obj.(lineName).devLine;
                idev = find(devLine=='/',1,'first')-1;
                dev = devLine(1:idev);
                block = block.addLineData(dev, lineName, 0, obj.(lineName).array);
            end
            
            if ~isempty(DDSChs)
                block = block.addLineData(ddslines.write(1:4), 'DDSWrite',0, obj.ddsWrite);
                block = block.addLineData(ddslines.reset(1:4), 'DDSReset',0, obj.ddsReset);
                block = block.addLineData(ddslines.ioupdate(1:4), 'DDSIOUpdate',0, obj.ddsIOUpdate);
                for i = 1:length(DDSChs)
                    switch DDSChs(i)
                        case 0
                            block = block.addLineData(ddslines.profile0(1:4), 'DDSProfile0',0, obj.ddsProfile0);
                        case 1
                            block = block.addLineData(ddslines.profile1(1:4), 'DDSProfile1',0, obj.ddsProfile1);
                        case 2
                            block = block.addLineData(ddslines.profile2(1:4), 'DDSProfile2',0, obj.ddsProfile2);
                        case 3
                            block = block.addLineData(ddslines.profile3(1:4), 'DDSProfile3',0, obj.ddsProfile3);
                    end
                end
            end
        end
        
        
        function checks(obj,camera)
            obj.checkSubBlocks
            obj.checkLines
            if nargin == 2
                obj.checkimaging(camera)
            end
        end
        
        function checkSubBlocks(obj)
            if ~isempty(obj.subBlocks(~obj.calledSubBlocks))
                notcalled = obj.subBlocks(~obj.calledSubBlocks);
                uncalledFlag = 0;
                for i = 1:length(notcalled)
                    if ~isempty(notcalled{i})
                        if ~exist('list','var')
                            list = notcalled{i};
                        else
                            list = [list ', ' notcalled{i}];
                        end
                        uncalledFlag = 1;
                    end
                end
                if uncalledFlag
                    disp('Uncalled SubBlock(s):')
                    disp(list)
                    disp(' ')
                    error('Some SubBlocks are not called.')
                end
            end
        end
        
        function checkLines(obj)
            nanflag = 0;
            lengthflag = 0;
            maxlength = length(obj.(obj.lines{1}).array);
            for i = 1:length(obj.lines)
                if length(obj.(obj.lines{i}).array)~=maxlength
                    lengthflag = 1;
                    maxlength = max([maxlength length(obj.(obj.lines{i}).array)]);
                end
                
                nans{i} = find(isnan(obj.(obj.lines{i}).array));
                if ~isempty(nans{i})
                    d = [diff(nans{i})' 1];
                    times{i} = num2str(nans{i}(1)*obj.dt);
                    for j = 2:length(d)
                        if d(j)==1 && d(j-1)~=1
                            times{i} = [times{i} ', ' num2str(nans{i}(j)*obj.dt)];
                        elseif d(j-1)==1 && d(j)~= 1
                            times{i} = [times{i} '-' num2str(nans{i}(j)*obj.dt)];
                        end
                    end
                    if  (length(d)-1)~=0 && d(length(d)-1)==1
                        times{i} = [times{i} '-' num2str(nans{i}(end)*obj.dt)];
                    elseif (length(d)-1)~=0
                        times{i} = [times{i} ', ' num2str(nans{i}(end)*obj.dt)];
                    end
                    nanflag = 1;
                end
            end
            obj.explength = maxlength;
            if lengthflag
                shortlines = '';
                for i = 1:length(obj.lines)
                    if length(obj.(obj.lines{i}).array) < maxlength
                        if ~isempty(shortlines)
                            shortlines = [shortlines  ', '];
                        end
                        shortlines = [shortlines obj.lines{i}];
                    end
                end
                disp('Lines missing SubBlocks:')
                disp(shortlines)
                disp(' ')
                error('Some lines are missing SubBlocks.')
            end
            if nanflag
                for i = 1:length(obj.lines)
                    if ~isempty(nans{i})
                        disp([obj.lines{i} ' contains NaNs at time(s): '])
                        disp(times{i})
                        disp(' ')
                    end
                end
                t0 = 0;
                disp('Timing of SubBlocks for your reference:')
                for i = 1:length(obj.subBlocks)
                    if isempty(obj.subBlocks{i})
                        continue
                    end
                    disp([obj.subBlocks{i} ': ' num2str(t0) '-' num2str(obj.(obj.subBlocks{i}).length+t0)])
                    t0 = obj.(obj.subBlocks{i}).length+t0;
                end
                error('NaNs persist in the code.')
            end
        end
        
        function checkVal = checkValueCondition(obj, line,conditionValue,conditionDirection, duration)
            % Checks a line of experiment exp for condition over a duration.  Condition direction is either >= or <=.  If the
            % condition is met for duration then checkLine returns checkVal = 1.  If
            % the condition is not met then checkLine returns checkVal = 0.
            lineArray = obj.(line).array;
            if strcmp('greater',conditionDirection)
                ind = find(lineArray >= conditionValue);
            elseif strcmp('less', conditionDirection)
                ind = find(lineArray <= conditionValue);
            elseif strcmp('greaterAbs', conditionDirection)
                ind = find(abs(lineArray) >= conditionValue);
            elseif strcmp('lessAbs', conditionDirection)
                ind = find(abs(lineArray) <= conditionValue);
            else
                error('Condition direction must be given as "greater" "less" "greaterAbs" or "lessAbs');
            end
            if isempty(ind) %if the condition is never met then return checkVal = 1
                checkVal = 0;
                return
            end
            lsub = 0;
            tsub = 0;
            last = 0;
            for i=1:length(ind) %Finds the longest continuous period conditionValue is met
                if i==1
                    last = ind(i);
                    lsub = 1;
                    tsub = 1;
                elseif ind(i) == last + 1
                    last = ind(i);
                    tsub = tsub + 1;
                elseif tsub > lsub
                    lsub = tsub;
                    tsub = 1;
                    last = ind(i);
                else
                    tsub = 1;
                    last = ind(i);
                end
                if i == length(ind) && lsub == 1
                    lsub = tsub;
                end
            end  
            if lsub >= floor(duration/obj.dt) 
                checkVal = 1;
            else
                checkVal = 0;
            end
        end

        function checkimaging(obj,camera)
            if ~any(strcmp(camera,obj.lines))
                error('Imaging line provided is incorrect.')
            end
            switch obj.(camera).mode
                case 'normal'
                    trigger = 1;
                case 'inverted'
                    trigger = 0;
                otherwise
                    error('Camera mode should be ''normal'' or ''inverted''.')
            end
            difftrig = diff(obj.(camera).array);
            ntrigs = nnz(difftrig)/2;
            if ntrigs ~= 3
                error('Three camera triggers must be specified for absorption imaging.')
            end
            ftrig = find(difftrig,1,'first');
            ftrigval = difftrig(ftrig);
            trigs = find(difftrig==ftrigval);
            triglen = diff(find(difftrig,2,'first'));
            trig0 = trigs(1) - (trigs(2) - trigs(1));
            obj.(camera).array(trig0:(trig0+triglen-1)) = trigger;
        end
        
        function varargout = subsref(obj,S)
            switch length(S)
                case 4
                    if any(strcmp(obj.subBlocks,S(1).subs)) && any(strcmp(obj.lines,S(2).subs))
                        if any(strcmp(obj.currSubBlock,{S(1).subs ''}))
                            subBlockName = S(1).subs;
                            t0 =0;
                            for i = 1:(obj.(subBlockName).position-1)
                                if isempty(obj.subBlocks{i})
                                    continue
                                end
                                t0 = t0 + round(obj.(obj.subBlocks{i}).length/obj.dt);
                            end
                            ind1 = t0 + 1;
                            ind2 = ind1 + round(obj.(subBlockName).length/obj.dt) - 1;
                            ind = [ind1 ind2];
                            lineName = S(2).subs;
                            method = S(3).subs;
                            args = [obj.dt ind S(4).subs];
                            obj.(lineName).(method)(args{:});
                            obj.calledSubBlocks(obj.(subBlockName).position) = 1;
                        end
                    else
                        if nargout == 0
                            builtin('subsref',obj,S)
                        else
                            varargout =  {builtin('subsref',obj,S)};
                        end
                    end
                    
                otherwise
                    if any(strcmp(obj.lines,S(1).subs)) && any(strcmp('freqcompile',S(2).subs))
                        lineName = S(1).subs;
                        freqcompile = S(2).subs;
                        obj.(lineName).(freqcompile)(obj.dt)
                        
                    elseif length(S)>=2 && any(strcmp(S(2).subs,'load'))
                        subBlockName = S(1).subs;
                        expName = inputname(1);
                        obj.(subBlockName).load(expName,obj.lines);
                        
                    elseif strcmp(S(1).subs,'loadExpSubBlocks')
                        expName = inputname(1);
                        varargout = {obj.(S(1).subs)(expName,obj.lines)};
                        
                    elseif strcmp(S(1).subs,'loadImgRstSubBlocks')
                        expName = inputname(1);
                        obj.(S(1).subs)(expName,obj.lines);
                        
                    elseif nargout == 0
                        builtin('subsref',obj,S)
                        
                    else
                        varargout =  {builtin('subsref',obj,S)};
                    end
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
                else
                    nobj.(po{i}) = obj.(po{i});
                end
            end
        end
    end
end