        function output = compareHashLists(hashStruct1,hashStruct2)
            names1 = fieldnames(hashStruct1);
            names2 = fieldnames(hashStruct2);
            lengthStruct1 = length(names1);
            lengthStruct2 = length(names2);
            output = 0;
            if lengthStruct1 ~= lengthStruct2
                output = max(lengthStruct1,lengthStruct2);
%                 disp('Different Length')
                return
            end
            
%             disp(lengthStruct1)
            for i=1:lengthStruct1
                if ~strcmp(names1{i},names2{i})
                    output = output + 1;                
                elseif hashStruct1.(names1{i}) ~= hashStruct2.(names2{i})
%                     disp('Different Hashes')
                    output = output + 1;
                end
            end
        end