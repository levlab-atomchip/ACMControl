function [errorCode, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2] = PositionerCorrectorNotchFiltersGet(socketId, PositionerName)
%PositionerCorrectorNotchFiltersGet :  Read filters parameters 
%
%	[errorCode, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2] = PositionerCorrectorNotchFiltersGet(socketId, PositionerName)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%	* Output parameters :
%		int32 errorCode
%		doublePtr NotchFrequency1
%		doublePtr NotchBandwith1
%		doublePtr NotchGain1
%		doublePtr NotchFrequency2
%		doublePtr NotchBandwith2
%		doublePtr NotchGain2


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Declaration of internal variables
%    (cstring need to be initialized for dll to run fine)
NotchFrequency1 = 0;
NotchBandwith1 = 0;
NotchGain1 = 0;
NotchFrequency2 = 0;
NotchBandwith2 = 0;
NotchGain2 = 0;

% lib call
[errorCode, PositionerName, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2] = calllib('XPS_C8_drivers', 'PositionerCorrectorNotchFiltersGet', socketId, PositionerName, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2);
