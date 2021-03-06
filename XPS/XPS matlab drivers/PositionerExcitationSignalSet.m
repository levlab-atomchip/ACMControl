function [errorCode] = PositionerExcitationSignalSet(socketId, PositionerName, Mode, Frequency, Amplitude, Time)
%PositionerExcitationSignalSet :  Update disturbing signal parameters
%
%	[errorCode] = PositionerExcitationSignalSet(socketId, PositionerName, Mode, Frequency, Amplitude, Time)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		int32 Mode
%		double Frequency
%		double Amplitude
%		double Time
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerExcitationSignalSet', socketId, PositionerName, Mode, Frequency, Amplitude, Time);
