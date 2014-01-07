function moveXPS(XPS_Pos)

%Matlab test script, mostly copied verbatim from XPS Software Drivers
%Manual, pg 32; Will Turner 5/4/12

%Load the library
xps_load_drivers;
Variables;

%X = -.0105
%Y = 0.5
%Z = -1


%Set Connection parameters
IP = XPS_IP;
Port = XPS_Port;
TimeOut = 60.0;

% GroupReferencingStart(GroupName)
% GroupReferencingActionExecute(PositionerName,
% "SetPosition","None",KnownCurrentPosition)
%GroupReferencingStop(GroupName)

% Connect to XPS
socketID = TCP_ConnectToServer(IP,Port,TimeOut);

%Check Connection
if (socketID < 0)
    disp('Connection to XPS failed, check IP and Port');
    return;
end

%Define the positioner
group = 'SampleStage';
positionerX = 'SampleStage.X'; 
positionerY = 'SampleStage.Y'; 
positionerZ = 'SampleStage.Z'; 

[errorCode, GroupStatus] = GroupStatusGet(socketID,group);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupStatusGet!']);
    return;
else
    [errorCode, GroupStatusString] = GroupStatusStringGet(socketID,GroupStatus);
    if errorCode ~= 0
        disp(['Error' num2str(errorCode) 'occured while doing GroupStatusStringGet!']);
        return;
    end
    disp(['GroupStatus is ' GroupStatusString]);
end

if GroupStatus ~= 12
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
end



% Make a move
[errorCode] = GroupMoveAbsolute(socketID,positionerX,XPS_Pos(1));
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupMoveAbsolute!']);
    return;
end
[errorCode] = GroupMoveAbsolute(socketID,positionerY,XPS_Pos(2));
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupMoveAbsolute!']);
    return;
end
[errorCode] = GroupMoveAbsolute(socketID,positionerZ,XPS_Pos(3));
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupMoveAbsolute!']);
    return;
end

% Get current position
[errorCode,currentPosition] = GroupPositionCurrentGet(socketID,positionerX,1);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupPositionCurrentGet!']);
    return;
else
    disp(['Positioner ' positionerX ' is in position ' num2str(currentPosition)]);
end
[errorCode,currentPosition] = GroupPositionCurrentGet(socketID,positionerY,1);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupPositionCurrentGet!']);
    return;
else
    disp(['Positioner ' positionerY ' is in position ' num2str(currentPosition)]);
end
[errorCode,currentPosition] = GroupPositionCurrentGet(socketID,positionerZ,1);
if (errorCode ~= 0)
    disp(['Error' num2str(errorCode) 'occured while doing GroupPositionCurrentGet!']);
    return;
else
    disp(['Positioner ' positionerZ ' is in position ' num2str(currentPosition)]);
end

% Close Connection
TCP_CloseSocket(socketID);

