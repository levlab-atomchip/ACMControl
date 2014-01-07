oldDir = 'old/';
newDir = 'new/';

% oldDir = strcat(oldDir,'*.mat');
% newDir = strcat(newDir,'*.mat');


oldNames = what(oldDir);
newNames = what(newDir);

numFiles = length(newNames.mat);

for i=1:numFiles
    block_old = load(strcat(oldDir,oldNames.mat{i}),'ACMBlock');
    block_new = load(strcat(newDir,newNames.mat{i}),'ACMBlock');
    
    block_old = block_old.ACMBlock;
    block_new = block_new.ACMBlock;
    
    
    disp(sprintf('Comparing %s and %s', oldNames.mat{i},newNames.mat{i}))
    compareBlocks(block_new,block_old)
end