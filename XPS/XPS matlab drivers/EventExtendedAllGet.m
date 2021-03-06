function [errorCode, EventActionConfigurations] = EventExtendedAllGet(socketId)
%EventExtendedAllGet :  Read all event and action configurations
%
%	[errorCode, EventActionConfigurations] = EventExtendedAllGet(socketId)
%
%	* Input parameters :
%		int32 socketId
%	* Output parameters :
%		int32 errorCode
%		cstring EventActionConfigurations


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
EventActionConfigurations = '';
for i = 1:103
	EventActionConfigurations = [EventActionConfigurations '          '];
end

% lib call
[errorCode, EventActionConfigurations] = calllib('XPS_C8_drivers', 'EventExtendedAllGet', socketId, EventActionConfigurations);
