function [errorCode] = EEPROMINTSet(socketId, CardNumber, ReferenceString)
%EEPROMINTSet :  Set INT EEPROM reference string
%
%	[errorCode] = EEPROMINTSet(socketId, CardNumber, ReferenceString)
%
%	* Input parameters :
%		int32 socketId
%		int32 CardNumber
%		cstring ReferenceString
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, ReferenceString] = calllib('XPS_C8_drivers', 'EEPROMINTSet', socketId, CardNumber, ReferenceString);
