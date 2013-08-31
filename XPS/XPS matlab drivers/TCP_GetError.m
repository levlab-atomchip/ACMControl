function [ error ] = TCP_GetError ( socketId )
%TCP_GetError : Returns socket error
%   This function checks and returns any error related to the
%   connection and the socket.

if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return
end

error = calllib ('XPS_C8_drivers', 'TCP_GetError', socketId) ;
