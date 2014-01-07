function [matFiles, hashList] = makeMATList()
    contents = what;
    hashList = struct();
    matFiles = contents.mat;
    for i=1:length(matFiles)
        %MakeFile Name
        dotInd = find(matFiles{i} == '.', 1, 'last');
        strippedName = matFiles{i}(1:dotInd-1);
        if ~strcmp(strippedName(1:3),'DDS')
            loadStruct = load(matFiles{1},'hashStruct');
            hashList.(strippedName) = loadStruct.hashStruct;
        end
    end
end