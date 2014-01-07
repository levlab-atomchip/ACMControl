oldDir = 'oldDDS/';
newDir = 'newDDS/';

% oldDir = strcat(oldDir,'*.mat');
% newDir = strcat(newDir,'*.mat');


oldNames = what(oldDir);
newNames = what(newDir);

numFiles = length(newNames.mat);

for i=1:numFiles
    block_old = load(strcat(oldDir,oldNames.mat{i}));
    block_new = load(strcat(newDir,newNames.mat{i}));
       
    
    disp(sprintf('Comparing %s and %s', oldNames.mat{i},newNames.mat{i}))
    compareDDS(block_new,block_old)
end