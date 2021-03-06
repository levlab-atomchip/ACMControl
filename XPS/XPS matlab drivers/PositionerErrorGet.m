function [errorCode, ErrorCode] = PositionerErrorGet(socketId, PositionerName)
%PositionerErrorGet :  Read and clear positioner error code
%
%	[errorCode, ErrorCode] = PositionerErrorGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		int32Ptr ErrorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
ErrorCode = 0;

% lib call
[errorCode, PositionerName, ErrorCode] = calllib('XPS_C8_drivers', 'PositionerErrorGet', socketId, PositionerName, ErrorCode);
