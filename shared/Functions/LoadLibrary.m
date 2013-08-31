clc
warning off all
cd(fileparts(mfilename('fullpath')))
block = Block;
block.initializeLibrary('..\')
clear block;
warning on all
disp('Library Loaded.')