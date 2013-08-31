function [errorCode, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2] = PositionerDACOffsetDualGet(socketId, PositionerName)
%PositionerDACOffsetDualGet :  Get dual DAC offsets
%
%	[errorCode, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2] = PositionerDACOffsetDualGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		int32Ptr PrimaryDACOffset1
%		int32Ptr PrimaryDACOffset2
%		int32Ptr SecondaryDACOffset1
%		int32Ptr SecondaryDACOffset2


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
PrimaryDACOffset1 = 0;
PrimaryDACOffset2 = 0;
SecondaryDACOffset1 = 0;
SecondaryDACOffset2 = 0;

% lib call
[errorCode, PositionerName, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2] = calllib('XPS_C8_drivers', 'PositionerDACOffsetDualGet', socketId, PositionerName, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2);
