function TCP_SetTimeout ( socketId, timeOut )
%TCP_SetTimeout : Set the timeOut
%   This is a simple function that set the time out of the TCP
%   connection to the XPS.

if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return
end

calllib ('XPS_C8_drivers', 'TCP_SetTimeout', socketId, timeOut) ;
