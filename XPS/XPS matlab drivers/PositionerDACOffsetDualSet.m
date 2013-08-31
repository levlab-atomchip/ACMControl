function [errorCode] = PositionerDACOffsetDualSet(socketId, PositionerName, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2)
%PositionerDACOffsetDualSet :  Set dual DAC offsets
%
%	[errorCode] = PositionerDACOffsetDualSet(socketId, PositionerName, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		int32 PrimaryDACOffset1
%		int32 PrimaryDACOffset2
%		int32 SecondaryDACOffset1
%		int32 SecondaryDACOffset2
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerDACOffsetDualSet', socketId, PositionerName, PrimaryDACOffset1, PrimaryDACOffset2, SecondaryDACOffset1, SecondaryDACOffset2);
