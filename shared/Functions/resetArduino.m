clc
disp('Reseting Arduino')
ard = serial('COM3','BaudRate',9600,'DataTerminalReady','on');
fopen(ard);
pause(.1)
ard.DataTerminalReady = 'off';
fclose(ard);
delete(ard);
munlock uploadArduino
clear uploadArduino
disp('Done.')