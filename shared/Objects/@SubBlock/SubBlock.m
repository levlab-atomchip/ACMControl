classdef SubBlock < handle
    properties
        subBlockName
        length
        position
    end
    
    properties (Dependent)
    end
    
    methods
        %Constructor
        function obj = SubBlock(subBlockName,length,position)
            if nargin == 0
                subBlockName = '';
                length = 1;
                position = 1;
            end
            
            if ~ischar(subBlockName)
                error('SubBlock name must be a string.')
            end
            obj.subBlockName = subBlockName;
            
            if ~isnumeric(length) || length <= 0
                error('SubBlock timeduration must be a number greater than zero.')
            end
            obj.length = length;
            
            if floor(position) ~= position || position <= 0
                error('SubBlock position must be an integer greater than zero.')
            end
            obj.position = position;
        end
        
        %Accessors
        
        %Main methods
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
        
        function load(obj,expName,lines)
            if ~exist([obj.subBlockName '.m'],'file')
                error(['SubBlock file ' obj.subBlockName ' does not exist.'])
            end
            sbfile = fopen([obj.subBlockName '.m'],'r+');
            exestr = '';
            fulltext = fscanf(sbfile,'%c');
            fseek(sbfile,0,'bof');
            sbtext = fgetl(sbfile);
            while ischar(sbtext)
                periods = find(sbtext=='.');
                for i = length(periods):-1:1
                    cend = periods(i)-1;
                    c0 = find(sbtext(1:periods(i))==' ',1,'last');
                    if isempty(c0)
                        c1 = 1;
                    else
                        c1 = c0+1;
                    end
                    % test = strfind(lines,sbtext(c1:cend));
                    test = strcmp(sbtext(c1:cend),lines);
                    if any(test) %~isempty([test{:}])
                        sbtext = [sbtext(1:c0) expName '.' obj.subBlockName '.' sbtext(c1:end)];
                    end
                end
                sbtext = [sbtext '\n'];
%                 if ~isempty(strfind(sbtext,'.'))%~(isempty(sbtext) || strcmp(sbtext(1),'%'))
%                     linestr = [expName '.' obj.subBlockName '.' sbtext '\n'];
%                 else
%                     linestr = [sbtext '\n'];
%                 end
                exestr = [exestr sbtext];
                sbtext = fgetl(sbfile);
            end
            exestr = strrep(exestr,'%','%%');
            fseek(sbfile,0,'bof');
            fprintf(sbfile,exestr);
            fclose(sbfile);
            try
                evalin('base',['rehash;' obj.subBlockName]);
            catch msg
                sbfile = fopen([obj.subBlockName '.m'],'w');
                fprintf(sbfile,'%c',fulltext);
                fclose(sbfile);
                rethrow(msg)
            end
            sbfile = fopen([obj.subBlockName '.m'],'w');
            fprintf(sbfile,'%c',fulltext);
            fclose(sbfile);
        end
    end
end