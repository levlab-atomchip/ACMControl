function uploadArduino(filename)
mlock

persistent lastupload

fullfilename = [filename '.mat'];
if ~exist(fullfilename,'file')
    fprintf(2,'No DDS Code\n');
    return;
end

S = load(fullfilename,'ddsInputArrays','ddsCOMPort');
ddsInputArrays = S.ddsInputArrays;
ddsCOMPort = S.ddsCOMPort;

for i = 1:length(ddsInputArrays)
    if ~iscell(lastupload) || length(lastupload)~=length(ddsInputArrays) || ~isequal(ddsInputArrays{i},lastupload{i})
        break;
    elseif i==length(ddsInputArrays)
        disp('DDS code already uploaded.')
        return;
    end
end

disp('Uploading...')
ard = serial(ddsCOMPort,'BaudRate',9600,'DataTerminalReady','off');
fopen(ard);
fwrite(ard,255);

tic
while ard.BytesAvailable < 1 && toc < .5
end
if ard.BytesAvailable == 0 || fread(ard,1)~=255
    fclose(ard);
    delete(ard);
    error('Arduino Upload Error.')
end

for i = 1:length(ddsInputArrays)
    for j = 1:length(ddsInputArrays{i})
        fwrite(ard,ddsInputArrays{i}(j));
    end
    
    tic
    while ard.BytesAvailable < 1 && toc < .5
    end
    if ard.BytesAvailable == 0 || fread(ard,1)~=255
        fclose(ard);
        delete(ard);
        error('Arduino Upload Error.')
    end
end

fclose(ard);
delete(ard);
lastupload = ddsInputArrays;
disp('Done.')

%% OLD VERSION 2012-31-7
% hexFile = [filename '\obj\' filename '.pde.hex'];
% if ~exist(hexFile,'file')
%     fprintf(2,'No DDS Code\n');
%     return;
% end
% 
% file = fopen(hexFile);
% thisupload = fscanf(file,'%c');
% fclose(file);
% 
% if strcmp(thisupload,lastupload)
% %     disp('DDS code already uploaded.')
%     return;
% end
% 
% arduinoPath = getenv('ARDUINO_PATH');
% avrdude_port = getenv('ARDUINO_COMPORT');%'COM3';
% mcu = getenv('ARDUINO_MCU');%'atmega328p';
% uploadRate = getenv('ARDUINO_BURNRATE');%'115200';
% 
% [hexDir,hexFile,hexExt]=fileparts(hexFile);
% hexFile = [hexFile hexExt];
% avrPath=fullfile(arduinoPath,'hardware','tools','avr');
% avrPath=strrep(avrPath,'\','/');
% 
% avrdude_conf = sprintf('%s/etc/avrdude.conf', avrPath);
% avrdude =  sprintf('%s/bin/avrdude', avrPath);
% 
% avrdude_flags = sprintf('-C %s -p %s -c stk500v1 -P//./%s -b %s -U flash:w:%s',...
%     avrdude_conf, mcu, avrdude_port, uploadRate, hexFile);
% 
% cmd = sprintf('%s %s',avrdude, avrdude_flags);
% 
% 
% disp('Uploading...');
% 
% origDir = cd(hexDir);
% [s,w] = system(cmd);
% 
% cd(origDir)
% 
% if (s~=0)
%     disp('Failed.')
%     disp(' ')
%     disp(w)
%     error('RTW:arduino:downloadFailed',...
%         ['Upload failed.\nCheck your serial connection and check you have '...
%         'specified the correct MCU.']);
% else
%     lastupload = thisupload;
%     disp('Done.')
%     clc
% end