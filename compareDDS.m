function output = compareDDS(DDS1,DDS2)

if ~strcmp(DDS1.ddsCOMPort,DDS2.ddsCOMPort)
    disp('Different Comports')
    output = 0;
    return
end

if length(DDS1.ddsInputArrays) ~= length(DDS2.ddsInputArrays)
    disp('Different length ddsInputArrays')
    output = 0;
    return
end

for i=1:length(DDS1.ddsInputArrays)
    if ~isequal(DDS1.ddsInputArrays{i},DDS2.ddsInputArrays{i})
        disp('Different ddsInputArrays')
        disp(i)
        output = 0;
        return
    end         
end
output = 1;