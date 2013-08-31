function [errorCode] = PositionerDACOffsetSet(socketId, PositionerName, DACOffset1, DACOffset2)
%PositionerDACOffsetSet :  Set DAC offsets
%
%	[errorCode] = PositionerDACOffsetSet(socketId, PositionerName, DACOffset1, DACOffset2)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		int32 DACOffset1
%		int32 DACOffset2
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerDACOffsetSet', socketId, PositionerName, DACOffset1, DACOffset2);
