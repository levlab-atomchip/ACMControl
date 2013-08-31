function [ version ] = GetLibraryVersion ( )
%GetLibraryVersion : Returns dll version

if (~libisloaded('XPS_C8_drivers'))
	disp 'Please load XPS_C8_drivers library before using XPS functions';
	return
end

version = calllib ('XPS_C8_drivers', 'GetLibraryVersion') ;
