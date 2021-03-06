function [errorCode] = GatheringConfigurationSet(socketId, Type)
%GatheringConfigurationSet :  Configuration acquisition
%
%	[errorCode] = GatheringConfigurationSet(socketId, Type)
%
%	* Input parameters :
%		int32 socketId
%		cstring Type
%	* Output parameters :
%		int32 errorCode


% Test that library is loaded
if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return;
end

% Count the number of element in the API
[temp, iMax] = size(Type);
i = 1;
nbElement = 0;
while (i < iMax)
	if (Type(i) == ' ')
		nbElement = nbElement + 1;
		while (i < iMax & Type(i) == ' ')
			i = i + 1;
		end
	end
	if (i == (iMax-1) & Type(i) ~= ' ')
		nbElement = nbElement + 1;
	end
	i = i + 1;
end

% lib call
[errorCode, Type] = calllib('XPS_C8_drivers', 'GatheringConfigurationSet', socketId, nbElement, Type);
