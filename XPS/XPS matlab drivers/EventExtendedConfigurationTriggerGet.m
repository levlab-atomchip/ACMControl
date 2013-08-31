function [errorCode, EventTriggerConfiguration] = EventExtendedConfigurationTriggerGet(socketId)
%EventExtendedConfigurationTriggerGet :  Read the event configuration
%
%	[errorCode, EventTriggerConfiguration] = EventExtendedConfigurationTriggerGet(socketId)
%
%	* Input parameters :
%		int32 socketId
%	* Output parameters :
%		int32 errorCode
%		cstring EventTriggerConfiguration


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
EventTriggerConfiguration = '';
for i = 1:205
	EventTriggerConfiguration = [EventTriggerConfiguration '          '];
end

% lib call
[errorCode, EventTriggerConfiguration] = calllib('XPS_C8_drivers', 'EventExtendedConfigurationTriggerGet', socketId, EventTriggerConfiguration);
