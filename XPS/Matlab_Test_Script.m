%Matlab test script, mostly copied verbatim from XPS Software Drivers
%Manual, pg 32; Will Turner 5/4/12

%Load the library
xps_load_drivers;

%Set Connection parameters
IP = '192.168.0.254';
Port = 5001;
TimeOut = 60.0;

% Connect to XPS
socketID = TCP_ConnectToServer(IP,Port,TimeOut);

%Check Connection
if (socketID < 0)
    disp('Connection to XPS failed, check IP and Port');
    return;
end

%Define the positioner
group = 
positioner =

%Kill the group
[errorCode] = GroupKill(socketID,group);
if(errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupKill!']);
    return;
end

%Initialize the group
[errorCode] = GroupInitialize(socketID,group);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupInitialize!']);
    return;
end

% Home Search
[errorCode] = GroupHomeSearch(socketID,group);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupHomeSearch!']);
    return;
end

% Make a move
[errorCode] = GroupMoveAbsolute(socketID,positioner,move_pos);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupMoveAbsolute!']);
    return;
end

% Get current position
[errorCode,currentPosition] = GroupPositionCurrentGet(socketID,positioner,1);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupPositionCurrentGet!']);
    return;
else
    disp(['Positioner ' positioner ' is in position ' num2str(currentPosition)]);
end

% Close Connection
TCP_CloseSocket(socketID);

