function output = compareBlocks(block1,block2)
%compares blocks by output

    if block1.deviceCount ~= block2.deviceCount
        output = 0;
        disp('different deviceCount')
        return
    end

    if ~strcmp(block1.primaryDevice,block2.primaryDevice)
        output = 0;
        disp('different primary Device')
        return
    end
    devCount = block1.deviceCount;
    
    devices1 = block1.devices;
    devices2 = block2.devices;
    
    for i=1:devCount
        if ~strcmp(devices1{i,1},devices2{i,1})
            output = 0;
            disp('different device names')
            return
        end
        dig1 = devices1{i,2}.rawStorage{1};
        analog1 = devices1{i,2}.rawStorage{2};
        
        dig2 = devices2{i,2}.rawStorage{1};
        analog2 = devices2{i,2}.rawStorage{2};
        
%         if devices1{i.2}.sampleRate ~= devices2{i,2}.sampleRate
%             disp('Different sampleRate')
%             output = 0
%             return
%         end
        if (~isequal(dig1,dig2) && (size(dig1,1) ~=0 || size(dig2,1) ~=0)) || (~isequal(analog1, analog2) && (size(analog1,1) ~=0 || size(analog2,1) ~=0))
            disp('different rawStorage')
            disp(sprintf('Device: %i', i))
            if ~isequal(dig1,dig2)
                disp('digital lines unequal')
                disp(size(dig1))
                disp(size(dig2))
%                 disp(max(max(dig1-dig2)))
%                 disp(min(min(dig1-dig2)))
%                 disp(class(dig1))
%                 disp(class(dig2))
%                 disp(isequal(dig1,dig2))
                for j=1:size(dig1,1)
                    p = isequal(dig1(j,:),dig2(j,:));
                    if ~p
%                         disp(find(dig1(j,:) ~= dig2(j,:)))
%                         plot(dig1(j,:),'x')
%                         hold on;
%                         plot(dig2(j,:),'o')
                    end
                    disp(sprintf('Line %i is %i', [j,p]))
                end
                
            elseif ~isequal(analog1,analog2)
                disp(size(analog1))
                disp(size(analog2))
                disp('analog lines unequal')
                for j=1:size(analog1,1)
                    p = isequal(analog1(j,:),analog2(j,:));
                    if ~p
%                         disp(find(dig1(j,:) ~= dig2(j,:)))
%                         plot(dig1(j,:),'x')
%                         hold on;
%                         plot(dig2(j,:),'o')
                    end
                    disp(sprintf('Line %i is %i', [j,p]))
                end
%                 disp(max(max(analog1-analog2)))
%                 disp(min(min(analog1-analog2)))
                
            end
            
            output = 0;
%             return
        end
       
        
    end
    output = 1;
    return