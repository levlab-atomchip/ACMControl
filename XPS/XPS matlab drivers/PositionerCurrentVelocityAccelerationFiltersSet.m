function [errorCode] = PositionerCurrentVelocityAccelerationFiltersSet(socketId, PositionerName, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency)
%PositionerCurrentVelocityAccelerationFiltersSet :  Set current velocity and acceleration cutoff frequencies
%
%	[errorCode] = PositionerCurrentVelocityAccelerationFiltersSet(socketId, PositionerName, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		double CurrentVelocityCutOffFrequency
%		double CurrentAccelerationCutOffFrequency
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerCurrentVelocityAccelerationFiltersSet', socketId, PositionerName, CurrentVelocityCutOffFrequency, CurrentAccelerationCutOffFrequency);
