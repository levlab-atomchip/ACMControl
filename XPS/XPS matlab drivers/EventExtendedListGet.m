function [errorCode, EventList] = EventExtendedListGet(socketId)
%EventExtendedListGet : 

% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
EventList = '';

% lib call
[errorCode, EventList] = calllib('XPS_C8_drivers', 'EventExtendedListGet', socketId, EventList);
