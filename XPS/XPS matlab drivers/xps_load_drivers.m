function [ errorCode ] = xps_load_drivers( )
%xps_load_drivers : load XPS dll
%   This is a simple function to load the dll library of the XPS into
%   memory. This function has to be called once before using any other XPS
%   function.

if (libisloaded('XPS_C8_drivers'))
	disp 'XPS library for Matlab already loaded';
	errorCode = -1
else
	loadlibrary ('XPS_C8_drivers', 'xps_load_drivers.h');
	if (~libisloaded('XPS_C8_drivers'))
		disp 'Error : could not load XPS library for Matlab';
		errorCode = -1
	end
end

errorCode = 0;

