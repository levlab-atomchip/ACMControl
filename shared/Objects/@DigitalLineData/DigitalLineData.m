classdef DigitalLineData < LineData
    properties
        mode
        delayon
        delayoff
    end
    
    properties (Dependent = true)
        on
        off
    end
    
    methods
        %Constructor
        function obj = DigitalLineData(lineName,mode,varargin)%delayon,delayoff,dispstat,devLine)
            if ~isempty(varargin)
                devLine = varargin{end};
                varargin(end) = [];
            end
            switch (nargin-1)
                case -1
                    lineName = '';
                    mode = '';
                    delayon = 0;
                    delayoff = 0;
                    dispstat = [];
                    devLine = '';
                case 2
                    delayon = 0;
                    delayoff = 0;
                    dispstat = 0;
                case 4
                    delayon = varargin{1};
                    delayoff = varargin{2};
                    dispstat = 0;
                case {1 3}
                    error('Incorrect number of inputs.')
                otherwise
                    delayon = varargin{1};
                    delayoff = varargin{2};
                    dispstat = varargin{3};
            end
            
            if ~(strcmp(mode,'normal') || strcmp(mode,'inverted') || strcmp(mode,''))
                error('Digital mode must be ''normal'' or ''inverted''.')
            end
            
            obj@LineData(lineName,mode,dispstat,devLine)
            
            obj.checktime(delayon)
            obj.delayon = delayon;
            
            obj.checktime(delayoff)
            obj.delayoff = delayoff;
        end
        
        %Accessor
        function set.mode(obj,value)
            if ~sum(strcmp(value,{'normal' 'inverted' ''}))
                error('Digital mode must be ''normal'' or ''inverted''.')
            end
            obj.mode = value;
        end
        function value = get.mode(obj)
            value = obj.mode;
        end
        
        function value = get.on(obj)
            switch obj.mode
                case 'normal'
                    value = 1;
                case 'inverted'
                    value = 0;
            end
        end
        
        function value = get.off(obj)
            switch obj.mode
                case 'normal'
                    value = 0;
                case 'inverted'
                    value = 1;
            end
        end
        
        %Main methods
        function startdur(obj,dt,ind,state,tstart,duration)
            state = obj.checkstate(state);
            delay = obj.setdelay(state);
            obj.checkarray(ind);
            obj.checktime(tstart);
            obj.checktime(duration);
            
            tstop = tstart + duration;
           
            istart = round((tstart-delay)/dt)+ind(1);
            istop = round(tstop/dt)+ind(1)-1;
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = obj.(state);
        end
        
        function stopdur(obj,dt,ind,state,tstop,duration)
            state = obj.checkstate(state);
            delay = obj.setdelay(state);
            obj.checkarray(ind);
            
            obj.checktime(tstop);
            obj.checktime(duration);
            
            tstart = tstop - duration;
            obj.checktime(tstart);
            
            istart = round((tstart-delay)/dt)+ind(1);
            istop = round(tstop/dt)+ind(1)-1;
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = obj.(state);
        end
        
        function ss(obj,dt,ind,state,tstart,tstop)
            obj.startstop(dt,ind,state,tstart,tstop)
        end
        
        function startstop(obj,dt,ind,state,tstart,tstop)
            state = obj.checkstate(state);
            delay = obj.setdelay(state);
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            istart = round((tstart-delay)/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt)+ind(1)-1;
            end
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = obj.(state);
        end
        
        function pulse(obj,dt,ind,state,tstart,duration)
            state = obj.checkstate(state);
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            obj.checktime(duration)
            
            tstop = tstart + duration;
            
            istart = round(tstart/dt)+ind(1);
            istop = round(tstop/dt)+ind(1)-1;
            
            istart = obj.checkindices(ind,istart,istop);
            
            if (istart-1) > 0 && obj.array(istart-1)==obj.(state)
                warning('Value preceeding the digital pulse is the same as the pulse value.')
            end
            
            obj.array(istart:istop) = obj.(state);
            
            if istop+1 < length(obj.array)
                obj.array(istop+1:end) = ~(obj.(state));
            end
        end
        
        function delay = setdelay(obj,state)
            switch state
                case 'on'
                    delay = obj.delayon;
                case 'off'
                    delay = obj.delayoff;
            end
        end
        

    end
    
    methods (Static)
        
        function state = checkstate(state)
            if strcmp(state,'open') || all(state==1)
                state = 'on';
            elseif strcmp(state,'closed') || all(state==0)
                state = 'off';
            end
            if ~(strcmp(state,'on') || strcmp(state,'off'))
                error('Digital state must be ''on'' (''open'') or ''off'' (''closed'').')
            end
        end
    end
end
                