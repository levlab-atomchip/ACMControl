function [errorCode, list] = ReferencingSensorListGet(socketId)
%ReferencingSensorListGet :  Get referencing sensor list
%
%	[errorCode, list] = ReferencingSensorListGet(socketId)
%
%	* Input parameters :
%		int32 socketId
%	* Output parameters :
%		int32 errorCode
%		cstring list


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
list = '';
for i = 1:205
	list = [list '          '];
end

% lib call
[errorCode, list] = calllib('XPS_C8_drivers', 'ReferencingSensorListGet', socketId, list);
