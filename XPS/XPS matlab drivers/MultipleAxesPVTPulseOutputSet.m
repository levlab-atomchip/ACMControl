function [errorCode] = MultipleAxesPVTPulseOutputSet(socketId, GroupName, StartElement, EndElement, TimeInterval)
%MultipleAxesPVTPulseOutputSet :  Configure pulse output on trajectory
%
%	[errorCode] = MultipleAxesPVTPulseOutputSet(socketId, GroupName, StartElement, EndElement, TimeInterval)
%
%	* Input parameters :
%		int32 socketId
%		cstring GroupName
%		int32 StartElement
%		int32 EndElement
%		double TimeInterval
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, GroupName] = calllib('XPS_C8_drivers', 'MultipleAxesPVTPulseOutputSet', socketId, GroupName, StartElement, EndElement, TimeInterval);
