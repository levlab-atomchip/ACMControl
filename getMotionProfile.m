function [motionProfile,port,host] = getMotionProfile(AllFiles)

ind = find(strcmp('Variables.m', AllFiles);
variables = AllFiles{ind+length(AllFiles)};

portStart = strfind(variables, 'soloistPort');