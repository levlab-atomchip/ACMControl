function [errorCode] = PositionerCorrectorNotchFiltersSet(socketId, PositionerName, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2)
%PositionerCorrectorNotchFiltersSet :  Update filters parameters 
%
%	[errorCode] = PositionerCorrectorNotchFiltersSet(socketId, PositionerName, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		double NotchFrequency1
%		double NotchBandwith1
%		double NotchGain1
%		double NotchFrequency2
%		double NotchBandwith2
%		double NotchGain2
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerCorrectorNotchFiltersSet', socketId, PositionerName, NotchFrequency1, NotchBandwith1, NotchGain1, NotchFrequency2, NotchBandwith2, NotchGain2);
