function [errorCode] = OptionalModuleExecute(socketId, ModuleFileName, TaskName)
%OptionalModuleExecute :  Execute an optional module
%
%	[errorCode] = OptionalModuleExecute(socketId, ModuleFileName, TaskName)
%
%	* Input parameters :
%		int32 socketId
%		cstring ModuleFileName
%		cstring TaskName
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, ModuleFileName, TaskName] = calllib('XPS_C8_drivers', 'OptionalModuleExecute', socketId, ModuleFileName, TaskName);
