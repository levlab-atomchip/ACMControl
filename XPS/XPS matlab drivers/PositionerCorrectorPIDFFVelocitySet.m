function [errorCode] = PositionerCorrectorPIDFFVelocitySet(socketId, PositionerName, ClosedLoopStatus, KP, KI, KD, KS, IntegrationTime, DerivativeFilterCutOffFrequency, GKP, GKI, GKD, KForm, FeedForwardGainVelocity)
%PositionerCorrectorPIDFFVelocitySet :  Update corrector parameters
%
%	[errorCode] = PositionerCorrectorPIDFFVelocitySet(socketId, PositionerName, ClosedLoopStatus, KP, KI, KD, KS, IntegrationTime, DerivativeFilterCutOffFrequency, GKP, GKI, GKD, KForm, FeedForwardGainVelocity)
%
%	* Input parameters :
%		int32 socketId
%		cstring PositionerName
%		uint16 ClosedLoopStatus
%		double KP
%		double KI
%		double KD
%		double KS
%		double IntegrationTime
%		double DerivativeFilterCutOffFrequency
%		double GKP
%		double GKI
%		double GKD
%		double KForm
%		double FeedForwardGainVelocity
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% lib call
[errorCode, PositionerName] = calllib('XPS_C8_drivers', 'PositionerCorrectorPIDFFVelocitySet', socketId, PositionerName, ClosedLoopStatus, KP, KI, KD, KS, IntegrationTime, DerivativeFilterCutOffFrequency, GKP, GKI, GKD, KForm, FeedForwardGainVelocity);
