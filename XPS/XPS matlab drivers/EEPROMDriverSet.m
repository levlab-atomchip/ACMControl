function [errorCode] = EEPROMDriverSet(socketId, PlugNumber, ReferenceString)
%EEPROMDriverSet :  Set Driver EEPROM reference string
%
%	[errorCode] = EEPROMDriverSet(socketId, PlugNumber, ReferenceString)
%
%	* Input parameters :
%		int32 socketId
%		int32 PlugNumber
%		cstring ReferenceString
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, ReferenceString] = calllib('XPS_C8_drivers', 'EEPROMDriverSet', socketId, PlugNumber, ReferenceString);
