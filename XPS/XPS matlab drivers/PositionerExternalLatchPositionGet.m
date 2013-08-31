function [errorCode, Position] = PositionerExternalLatchPositionGet(socketId, PositionerName)
%PositionerExternalLatchPositionGet :  Read external latch position
%
%	[errorCode, Position] = PositionerExternalLatchPositionGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		doublePtr Position


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
Position = 0;

% lib call
[errorCode, PositionerName, Position] = calllib('XPS_C8_drivers', 'PositionerExternalLatchPositionGet', socketId, PositionerName, Position);
