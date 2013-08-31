function [errorCode, MinimumPosition, MaximumPosition, PositionStep, EnableState] = PositionerTimeFlasherGet(socketId, PositionerName)
%PositionerTimeFlasherGet :  Read time flasher parameters
%
%	[errorCode, MinimumPosition, MaximumPosition, PositionStep, EnableState] = PositionerTimeFlasherGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		doublePtr MinimumPosition
%		doublePtr MaximumPosition
%		doublePtr PositionStep
%		uint16Ptr EnableState


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
MinimumPosition = 0;
MaximumPosition = 0;
PositionStep = 0;
EnableState = 0;

% lib call
[errorCode, PositionerName, MinimumPosition, MaximumPosition, PositionStep, EnableState] = calllib('XPS_C8_drivers', 'PositionerTimeFlasherGet', socketId, PositionerName, MinimumPosition, MaximumPosition, PositionStep, EnableState);
