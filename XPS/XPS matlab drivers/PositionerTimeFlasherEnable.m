function [errorCode] = PositionerTimeFlasherEnable(socketId, PositionerName)
%PositionerTimeFlasherEnable :  Enable time flasher
%
%	[errorCode] = PositionerTimeFlasherEnable(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerTimeFlasherEnable', socketId, PositionerName);
