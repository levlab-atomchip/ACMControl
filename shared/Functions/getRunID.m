function [oldID,runID] = getRunID()
    contents = what;
    dotInd = find(contents.mat{1} == '.', 1,'last');
    oldID = contents.mat{1}(dotInd-1);
    if strcmp(oldID,'a')
        runID = 'b';
    else
        runID = 'a';
    end
end