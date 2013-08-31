disp('Reseting DDS')
timeLine = TimeLine;
timeLine.durationTime = .1;
RESETDDS = Block('RESETDDS',timeLine);
RESETDDS = RESETDDS.addDevice('Dev1', 1/.001); %Device names must map to hardware!
RESETDDS.primaryDevice = 'Dev1';
RESETDDS = RESETDDS.addLine('Dev1', 'DDSReset','Dev1/port1/line4');
RESETDDS = RESETDDS.initializeAllDevices();
RESETDDS = RESETDDS.addLineData('Dev1', 'DDSReset',0, [ones(50,1); zeros(50,1)]);
RESETDDS = RESETDDS.initializeHardware;
RESETDDS = RESETDDS.run;
RESETDDS = RESETDDS.clearTasks;
clear RESETDDS;
disp('Done.')