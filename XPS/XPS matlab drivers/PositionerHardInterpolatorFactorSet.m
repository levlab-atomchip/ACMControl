function [errorCode] = PositionerHardInterpolatorFactorSet(socketId, PositionerName, InterpolationFactor)
%PositionerHardInterpolatorFactorSet :  Set hard interpolator parameters
%
%	[errorCode] = PositionerHardInterpolatorFactorSet(socketId, PositionerName, InterpolationFactor)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		int32 InterpolationFactor
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerHardInterpolatorFactorSet', socketId, PositionerName, InterpolationFactor);
