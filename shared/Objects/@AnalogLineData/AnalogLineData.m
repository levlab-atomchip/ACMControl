classdef AnalogLineData < LineData
    properties
        cal
        mode
        max
        min
    end
    
    methods
        %Constructor
        function obj = AnalogLineData(lineName,cal,mode,varargin)%min,max,dispstat,devLine
            if ~isempty(varargin)
                devLine = varargin{end};
                varargin(end) = [];
            end
            switch (nargin-1)
                case -1
                    lineName = '';
                    cal = [];
                    mode = '';
                    min = [];
                    max = [];
                    dispstat = 0;
                    devLine = '';
                case 3
                    min = -10;
                    max = 10;
                    dispstat = 0;
                case 5
                    min = varargin{1};
                    max = varargin{2};
                    dispstat = 0;
                case {1 2 4}
                    error('Incorrect number of inputs.')
                otherwise
                    min = varargin{1};
                    max = varargin{2};
                    dispstat = varargin{3};
            end
            
            if ~(strcmp(mode,'value') || strcmp(mode,'fraction') || nargin==0)
                error('Analog mode must be ''value'' or ''fraction''.')
            end
            
            obj@LineData(lineName,mode,dispstat,devLine)
            
            if abs(min) > 10
                error('Analog min cannot exceed +/- 10.')
            end
            if abs(max) > 10
                error('Analog max cannot exceed +/- 10.')
            end
            if min > max
                error('Analog max must be greater than min.')
            end
            obj.min = min;
            obj.max = max;
            
            if strcmp(mode,'fraction') && cal > max
                error('In fraction mode, the calibration cannot exceed the max value.')
            end
            obj.cal = cal;
        end
        
        %Accessor
        function set.mode(obj,mode)
            if ~(strcmp(mode,{'value' 'fraction' ''}))
                error('Analog mode must be ''value'' or ''fraction''.')
            end
            obj.mode = mode;
        end
        function value = get.mode(obj)
            value = obj.mode;
        end
        
        function value = get.cal(obj)
            value = obj.cal;
        end
        
        function value = get.max(obj)
            value = obj.max;
        end
        
        function value = get.min(obj)
            value = obj.min;
        end
        
        %Main methods
        function startdur(obj,dt,ind,value,tstart,duration)
            obj.checkvalue(value);
            obj.checkarray(ind);
            
            obj.checktime(tstart);
            obj.checktime(duration);
            
            tstop = tstart + duration;
            
            istart = round(tstart/dt)+ind(1);
            istop = round(tstop/dt)+ind(1)-1;
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = value*obj.cal;
        end
        
        function stopdur(obj,dt,ind,value,tstop,duration)
            obj.checkvalue(value)
            obj.checkarray(ind);
            
            obj.checktime(tstop);
            obj.checktime(duration);
            
            tstart = tstop - duration;
            obj.checktime(tstart);
            
            istart = round(tstart/dt)+ind(1);
            istop = round(tstop/dt)+ind(1)-1;
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = value*obj.cal;
        end
        
        function startstop(obj,dt,ind,value,tstart,tstop)
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            istart = round(tstart/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt) + ind(1)-1;
            end
            
            if strcmp(value,'current')
                if ~isnan(obj.array(istart))
                    value = obj.array(istart)/obj.cal;
                elseif ~isnan(obj.array(istart-1))
                    value = obj.array(istart-1)/obj.cal;
                else
                    error('Must specify value leading up to call using ''current''.')
                end
            end
            obj.checkvalue(value);
            
            istart = obj.checkindices(ind,istart,istop);
            obj.array(istart:istop) = value*obj.cal;
        end
        
        function ss(obj,dt,ind,value,tstart,tstop)
            obj.startstop(dt,ind,value,tstart,tstop)
        end
        
        function linear(obj,dt,ind,value1,value2,tstart,tstop)
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            
            istart = round(tstart/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt) + ind(1)-1;
            end
            
            if strcmp(value1,'current')
                if ~isnan(obj.array(istart))
                    value1 = obj.array(istart)/obj.cal;
                elseif ~isnan(obj.array(istart-1))
                    value1 = obj.array(istart-1)/obj.cal;
                else
                    error('Must specify value leading up to call using ''current''.')
                end
            end
            obj.checkvalue(value1);
            
            if strcmp(value2,'current')
                error('Final value of linear sweet cannot be ''current''.')
            end
            obj.checkvalue(value2)
            
            istart = obj.checkindices(ind,istart,istop);
            
            obj.array(istart:istop) = linspace(value1*obj.cal,value2*obj.cal,istop-istart+1);
        end
        
       function quadratic(obj,dt,ind,a2,a1,a0,tstart,tstop)
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            
            istart = round(tstart/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round(tstop/dt) + ind(1)-1;
            end
            
%             if strcmp(value1,'current')
%                 if ~isnan(obj.array(istart))
%                     value1 = obj.array(istart)/obj.cal;
%                 elseif ~isnan(obj.array(istart-1))
%                     value1 = obj.array(istart-1)/obj.cal;
%                 else
%                     error('Must specify value leading up to call using ''current''.')
%                 end
%             end
%             obj.checkvalue(value1);
%             
%             if strcmp(value2,'current')
%                 error('Final value of linear sweet cannot be ''current''.')
%             end
%             obj.checkvalue(value2)
            
            istart = obj.checkindices(ind,istart,istop);
            
            t = linspace(0,tstop-tstart,istop-istart+1);
            y = a2*t.^2 + a1*t+a0;            
            obj.array(istart:istop) = y;
        end
        
        function erf(obj,dt,ind,value1,value2,tstart,tstop,delay)
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            
            istart = round((tstart-delay)/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round((tstop-delay)/dt) + ind(1)-1;
            end
            
            if strcmp(value1,'current')
                if ~isnan(obj.array(istart))
                    value1 = obj.array(istart)/obj.cal;
                elseif ~isnan(obj.array(istart-1))
                    value1 = obj.array(istart-1)/obj.cal;
                else
                    error('Must specify value leading up to call using ''current''.')
                end
            end
            obj.checkvalue(value1);
            
            if strcmp(value2,'current')
                error('Final value of linear sweet cannot be ''current''.')
            end
            obj.checkvalue(value2)
            
            istart = obj.checkindices(ind,istart,istop);
            
            t = linspace(-2,2,istop-istart+1);
            y = (value2-value1)/2*(1+erf(t)) + value1;            
            obj.array(istart:istop) = y;
        end
        
        function sinoffset(obj,dt,ind,dcAmp,modAmp,modFreq,tstart,tstop)
            obj.checkarray(ind);
            
            obj.checktime(tstart)
            
            istart = round((tstart)/dt)+ind(1);
            
            if strcmp(tstop,'end')
                istop = ind(2);
            else
                obj.checktime(tstop)
                istop = round((tstop)/dt) + ind(1)-1;
            end
            
            if strcmp(dcAmp,'current')
                if ~isnan(obj.array(istart))
                    value1 = obj.array(istart)/obj.cal;
                elseif ~isnan(obj.array(istart-1))
                    value1 = obj.array(istart-1)/obj.cal;
                else
                    error('Must specify value leading up to call using ''current''.')
                end
            end
            obj.checkvalue(dcAmp);
            
            if strcmp(dcAmp,'current')
                error('Final value of linear sweet cannot be ''current''.')
            end
            obj.checkvalue(dcAmp)
            
            istart = obj.checkindices(ind,istart,istop);
            
            t = linspace(istart*dt,istop*dt,istop-istart+1);
            y = dcAmp + modAmp*sin(2*pi*modFreq*t);            
            obj.array(istart:istop) = y;
        end
       
        function powerevap(obj,dt,ind,max,ti,tf,t0,tau,beta)
            obj.checktime(t0)
            obj.checktime(ti)
            obj.checktime(tf)
            obj.checkarray(ind);
            
            if ti < t0
                error('Start time must be greater than or equal to the defined zero time.')
            end
            if ~isnumeric(tau) || tau < 0
                error('Time constant, tau, must be greater than zero.')
            end
            
            obj.checkvalue(max)
            
            iti = round(ti/dt)+ind(1);
            itf = round(tf/dt)+ind(1)-1;
            iti = obj.checkindices(ind,iti,itf);
            
            itime = (round((ti-t0)/dt)+1):round((tf-t0)/dt);
            itau = tau/dt;
            
            curve = max*((1+itime(1)/itau)./(1+itime/itau)).^beta;
            obj.checkvalue(curve)
            
            obj.array(iti:itf) = obj.cal*curve;
        end
        
        function holdcurrent(obj,dt,ind,tstart,tstop)
            obj.startstop(dt,ind,'current',tstart,tstop)
        end
        
        function checkvalue(obj,value)
            switch obj.mode
                case 'value'
                    if sum(obj.cal*value > obj.max) || sum(obj.cal*value < obj.min)
                        error('Analog value is outside range.')
                    end
                case 'fraction'
                    if sum(value > 1) || sum(value < 0)
                        error('Analog fraction is not valid.')
                    end
            end
        end
        
    end
    
    methods (Static)
    end
end
                