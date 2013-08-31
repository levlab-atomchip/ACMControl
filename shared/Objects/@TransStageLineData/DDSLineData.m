classdef DDSLineData < handle
    properties
        dispstat
        
        enabled
        highFreq
        lowFreq
        opMode
    end
    
    properties (Dependent)
        ratioPLL
        array
    end
    
    properties (SetAccess = protected)
        lineName
        ch
        refFreq
        sysFreq
        maxFreq
        minFreq
        freqTol
        
        
        freqarray
        amparray
        
        Writes
    end
    
    methods
        % Constructor
        function obj = DDSLineData(lineName,channel,refFreq,sysFreq,minFreq,maxFreq,freqTol,dispstat)
            switch nargin
                case 0
                    lineName = '';
                    channel = [];
                    refFreq = [];
                    sysFreq = [];
                    minFreq = [];
                    maxFreq = [];
                    freqTol = [];
                    dispstat = 0;
                case 3
                    minFreq = 0;
                    maxFreq = 200e6;
                    freqTol = .001;
                    dispstat = 0;
                case 4
                    minFreq = 0;
                    maxFreq = 200e6;
                    freqTol = .001;
                    dispstat = 0;
                case 6
                    freqTol = .001;
                    dispstat = 0;
                case 7
                    dispstat = 0;
                otherwise
                    error('Incorrect number of inputs.')
            end
            
            obj.lineName = lineName;
            
            if ~isempty(channel) && ~any(channel==[0 1 2 3])
                error('Channel must be 0, 1, 2, or 3.')
            end
            obj.ch = channel;
            obj.refFreq = refFreq;
            obj.sysFreq = sysFreq;
            
            obj.minFreq = minFreq;
            obj.maxFreq = maxFreq;
            obj.freqTol = freqTol;
            obj.dispstat = dispstat;
            
            obj.highFreq = [];
            obj.lowFreq = [];
            obj.opMode = '';
%             obj.sweepEnabled = 0;
            obj.enabled = 0;
        end
        
        %Accessors
        function value = get.ratioPLL(obj)
            value = round(obj.sysFreq/obj.refFreq);
        end
        
        function value = get.array(obj)
            value = obj.freqarray;
        end
        
        %Main methods
        function setfreq(obj,dt,ind,freq,tstart,tstop)
            obj.checkfreq(freq);
            obj.checkfreqarray(ind);
            
            obj.checktime(tstart)
            istart = round(tstart/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt) + ind(1)-1;
            end
            
            istart = obj.checkindices(ind,istart,istop);
            obj.freqarray(istart:istop) = freq;
        end
        
        function setfreqsweep(obj,dt,ind,fstart,fstop,tstart,tstop)
            obj.checkfreq(fstart);
            obj.checkfreq(fstop);
            obj.checkfreqarray(ind);
            
            obj.checktime(tstart)
            istart = round(tstart/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt) + ind(1)-1;
            end
            
            istart = obj.checkindices(ind,istart,istop);
            
            obj.freqarray(istart:istop) = -1;
            obj.freqarray(istart) = fstart;
            obj.freqarray(istop) = fstop;
        end
        
        function reset(obj,dt,ind,tstart)
            obj.checkfreqarray(ind);
            
            obj.checktime(tstart)
            istart = round(tstart/dt)+ind(1);
            
            istart = obj.checkindices(ind,istart);
            
            obj.freqarray(istart:ind(2)) = 0;
        end
        
        function freqcompile(obj)
            currFreq = obj.freqarray(1);
            pcounter = 1;
            changes = find(diff(obj.freqarray))+1;
            lengths = [changes(1)-1; diff(changes)];
            for j = 1:length(changes)
                i = changes(j);
                ecounter = lengths(j);
                phases(pcounter,1:2) = [currFreq ecounter];
                pcounter = pcounter+1;
                if currFreq > 0 && obj.freqarray(i) > 0
                    phases(pcounter,1:2) = [-2 0];
                    pcounter = pcounter+1;
                end
                currFreq = obj.freqarray(i);
                ecounter = 1;
                if i == length(obj.freqarray)
                    phases(pcounter,1:2) = [currFreq ecounter];
                end
            end
            if i~=length(obj.freqarray)
                lastl = length(obj.freqarray)-changes(end)+1;
                phases(pcounter,1:2) = [currFreq lastl];
            end
            
%             currFreq = obj.freqarray(1);
%             pcounter = 1;
%             ecounter = 1;
%             phases = [];
%             for i = 2:length(obj.freqarray)
%                 if obj.freqarray(i) == currFreq
%                     ecounter = ecounter+1;
%                     if i == length(obj.freqarray)
%                         phases(pcounter,1:2) = [currFreq ecounter];
%                     end
%                 else
%                     phases(pcounter,1:2) = [currFreq ecounter];
%                     pcounter = pcounter+1;
%                     if currFreq > 0 && obj.freqarray(i) > 0
%                         phases(pcounter,1:2) = [-2 0];
%                         pcounter = pcounter+1;
%                     end
%                     currFreq = obj.freqarray(i);
%                     ecounter = 1;
%                     if i == length(obj.freqarray)
%                         phases(pcounter,1:2) = [currFreq ecounter];
%                     end
%                 end
%             end
            
            wcounter = 1;
            
            for i = 1:length(phases(:,1))
                tstart = sum(phases(1:(i-1),2))+1;
                
                switch phases(i,1)
                    case 0
                        %write reset
                        
                        %write next freq
                        fjump = phases(i+1,1);
                        obj.Writes(wcounter,:) = [tstart NaN fjump NaN obj.ch];%
                        
                        wcounter = wcounter+1;
                    case -1
                        %write sweep
                        fstart = phases(i-1,1);
                        fstop = phases(i+1,1);
                        tdur = phases(i,2)+2;
                        obj.Writes(wcounter,:) = [tstart tdur fstart fstop obj.ch];%
                        
                        wcounter = wcounter+1;
                    case -2
                        %write jump
                        fjump = phases(i+1,1);
                        obj.Writes(wcounter,:) = [tstart Inf fjump Inf obj.ch];%
                        
                        wcounter = wcounter+1;
                    otherwise
                        if i==1 %length(phases(:,1))==1
                            fjump = phases(wcounter,1);
                            obj.Writes(1,:) = [tstart Inf fjump Inf obj.ch];
                            wcounter = wcounter+1;
                            warning('DDSLineData:ddst0','First DDS frequency set at t=0. There will be a 400 us lag in setting this frequency.');
                        end
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
                elseif sum(strcmp(po{i},{'ratioPLL' 'array'}))
                    continue
                else
                    nobj.(po{i}) = obj.(po{i});
                end
            end
        end
        
        function checkfreq(obj,freq)
            if freq > obj.maxFreq
                error('Specified frequency is larger than max frequency.')
            elseif freq < obj.minFreq
                error('Specified frequency is smaller than min frequency.')
            end
        end
        
        function checkfreqarray(obj,ind)
            if ind(2) > length(obj.freqarray)
                obj.freqarray((length(obj.freqarray)+1):ind(2),1) = NaN;
            end
        end
    end
    
    methods (Static)
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
                warning('Overwriting entries in previous SubBlock(s).')
            end
        end
        
        function checkdt(dt)
            if 1/dt > 200e6
                error('Max DDS IO is 200 MHz. Increase dt.')
            end
        end
        
        function checktime(time)
            if ~isnumeric(time) || time < 0
                error('Times must be numbers greater than or equal to zero.')
            end
        end
    end
end