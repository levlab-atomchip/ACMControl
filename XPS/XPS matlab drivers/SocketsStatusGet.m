function [errorCode, SocketsStatus] = SocketsStatusGet(socketId)
%SocketsStatusGet :  Get sockets current status
%
%	[errorCode, SocketsStatus] = SocketsStatusGet(socketId)
%
%	* Input parameters :
%		int32 socketId
%	* Output parameters :
%		int32 errorCode
%		cstring SocketsStatus


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
SocketsStatus = '';
for i = 1:103
	SocketsStatus = [SocketsStatus '          '];
end

% lib call
[errorCode, SocketsStatus] = calllib('XPS_C8_drivers', 'SocketsStatusGet', socketId, SocketsStatus);
