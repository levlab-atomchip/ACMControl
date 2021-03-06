function [errorCode, Velocity, Acceleration] = GroupJogCurrentGet(socketId, GroupName, nbElement)
%GroupJogCurrentGet :  Get Jog current on selected group
%
%	[errorCode, Velocity, Acceleration] = GroupJogCurrentGet(socketId, GroupName, nbElement)
%
%	* Input parameters :
%		int32 socketId
%		cstring GroupName
%		int32 nbElement
%	* Output parameters :
%		int32 errorCode
%		doublePtr Velocity
%		doublePtr Acceleration


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
Velocity = [];
Acceleration = [];
for i = 1:nbElement
	Velocity = [Velocity 0];
	Acceleration = [Acceleration 0];
end

% lib call
[errorCode, GroupName, Velocity, Acceleration] = calllib('XPS_C8_drivers', 'GroupJogCurrentGet', socketId, GroupName, nbElement, Velocity, Acceleration);
