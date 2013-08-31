function [errorCode, DACOffset1, DACOffset2] = PositionerDACOffsetGet(socketId, PositionerName)
%PositionerDACOffsetGet :  Get DAC offsets
%
%	[errorCode, DACOffset1, DACOffset2] = PositionerDACOffsetGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		int32Ptr DACOffset1
%		int32Ptr DACOffset2


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
DACOffset1 = 0;
DACOffset2 = 0;

% lib call
[errorCode, PositionerName, DACOffset1, DACOffset2] = calllib('XPS_C8_drivers', 'PositionerDACOffsetGet', socketId, PositionerName, DACOffset1, DACOffset2);
