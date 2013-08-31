function [errorCode] = EEPROMDACOffsetCIESet(socketId, PlugNumber, DAC1Offset, DAC2Offset)
%EEPROMDACOffsetCIESet :  Set CIE DAC offsets
%
%	[errorCode] = EEPROMDACOffsetCIESet(socketId, PlugNumber, DAC1Offset, DAC2Offset)
%
%	* Input parameters :
%		int32 socketId
%		int32 PlugNumber
%		double DAC1Offset
%		double DAC2Offset
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode] = calllib('XPS_C8_drivers', 'EEPROMDACOffsetCIESet', socketId, PlugNumber, DAC1Offset, DAC2Offset);
