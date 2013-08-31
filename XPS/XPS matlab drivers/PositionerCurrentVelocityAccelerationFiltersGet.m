function [errorCode, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency] = PositionerCurrentVelocityAccelerationFiltersGet(socketId, PositionerName)
%PositionerCurrentVelocityAccelerationFiltersGet :  Get current velocity and acceleration cutoff frequencies
%
%	[errorCode, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency] = PositionerCurrentVelocityAccelerationFiltersGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		doublePtr CurrentVelocityCutOffFrequency
%		doublePtr CurrentAccelerationCutOffFrequency


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
CurrentVelocityCutOffFrequency = 0;
CurrentAccelerationCutOffFrequency = 0;

% lib call
[errorCode, PositionerName, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency] = calllib('XPS_C8_drivers', 'PositionerCurrentVelocityAccelerationFiltersGet', socketId, PositionerName, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency);
