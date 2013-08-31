function [errorCode, ControllerStatusString] = ControllerStatusStringGet(socketId, ControllerStatusCode)
%ControllerStatusStringGet :  Return the controller status string corresponding to the controller status code
%
%	[errorCode, ControllerStatusString] = ControllerStatusStringGet(socketId, ControllerStatusCode)
%
%	* Input parameters :
%		int32 socketId
%		int32 ControllerStatusCode
%	* Output parameters :
%		int32 errorCode
%		cstring ControllerStatusString


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
ControllerStatusString = '';
for i = 1:103
	ControllerStatusString = [ControllerStatusString '          '];
end

% lib call
[errorCode, ControllerStatusString] = calllib('XPS_C8_drivers', 'ControllerStatusStringGet', socketId, ControllerStatusCode, ControllerStatusString);
