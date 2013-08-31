function [errorCode, CurrentFollowingError] = GroupCurrentFollowingErrorGet(socketId, GroupName, nbElement)
%GroupCurrentFollowingErrorGet :  Return current following errors
%
%	[errorCode, CurrentFollowingError] = GroupCurrentFollowingErrorGet(socketId, GroupName, nbElement)
%
%	* Input parameters :
%		int32 socketId
%		cstring GroupName
%		int32 nbElement
%	* Output parameters :
%		int32 errorCode
%		doublePtr CurrentFollowingError


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
CurrentFollowingError = [];
for i = 1:nbElement
	CurrentFollowingError = [CurrentFollowingError 0];
end

% lib call
[errorCode, GroupName, CurrentFollowingError] = calllib('XPS_C8_drivers', 'GroupCurrentFollowingErrorGet', socketId, GroupName, nbElement, CurrentFollowingError);
