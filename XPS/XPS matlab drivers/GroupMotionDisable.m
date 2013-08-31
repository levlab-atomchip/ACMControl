function [errorCode] = GroupMotionDisable(socketId, GroupName)
%GroupMotionDisable :  Set Motion disable on selected group
%
%	[errorCode] = GroupMotionDisable(socketId, GroupName)
%
%	* Input parameters :
%		int32 socketId
%		cstring GroupName
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, GroupName] = calllib('XPS_C8_drivers', 'GroupMotionDisable', socketId, GroupName);
