clc
clear classes
ticST = tic;
[oldID, runID] = getRunID();
delete('GUIRUN*')
% warning on all
warning off all

% defineRun = 1;
Variables
AllFiles = TextSave;
% AllFiles = '';
%% Setup Control Parameters
ContParName = 'VOID';
VOID = 0;
vars = whos;
vecvar = {'MOTTime' 'MoveDipoleTime' 'AllFiles' 'TOFs' 'ans' 'DipoleBiasSweepTimes' 'DipoleBiasSweepValues' 'XSweep' 'YSweep' 'ZSweep' 'MotionProfile' 'MoveSweep' 'acc' 'spd' 'pos'};
for i = 1:length(vars)
    if any(vars(i).size>1) && ~strcmp(vars(i).class,'char') && ~any(strcmp(vecvar,vars(i).name))
        ContParName = vars(i).name;
        break;
    end
end
ContPar = eval(ContParName);
if strcmp(ContParName,'VOID')
    J = 1;
else
    J = length(ContPar);
end
disp(['Control Parameter is ' ContParName])

%% Make list of blocks at start
[matList,hashList] = makeMATList();

for j = 1:J
    tic
%     tof = TOFs(1);
    %% Compile
    CurrContPar = ContPar(j);
    eval([ContParName '=' num2str(CurrContPar) ';']);
    DepVariables

    disp(['Compiling Files for Parameter ' num2str(j) ' of ' num2str(J)])
    
    %% Experiment
    ex = Experiment(dt);

    %% SubBlocks
    ex.addSubBlock('LoadMOT', MOTTime, 1)
    if SUBDOP
        ex.addSubBlock('SubDop', CoolTime, 2)
    end
    if OPTPUMP
        ex.addSubBlock('OptPump', pumpTime+PumpSweepTime, 3)
    end
    if HYBRID
        ex.addSubBlock('LoadHybrid', HybridTime, 4)
    end
    if RFEVAP
        ex.addSubBlock('HybridEvap', HybridEvapTime, 5)
    end
    if DIPOLE
        ex.addSubBlock('LoadDipole', DipoleTime, 6)
    end
    if OPTEVAP
        ex.addSubBlock('OptEvap', OptEvapTime, 7)
    end
    if MOVEDIPOLE
        ex.addSubBlock('MoveDipole', MoveDipoleTime, 8)
    end
    if MACROCAPTURE
        ex.addSubBlock('MacroCapture', MacroCaptureTime, 9)
    end
    if MACROCOMPRESS
        ex.addSubBlock('MacroCompress',MacroCompressTime,10)
    end
    if MICROCAPTURE
        ex.addSubBlock('MicroCapture',MicroCaptureTime,11)
    end
    ex.addSubBlock('Imaging', ImagingTime, 12) %tof + 2*WaitTime
    ex.addSubBlock('Reset', OffTime, 13)

    
    
    %% Lines
    ex.addLine('d','ZShutters','normal',ZPSHUTONTIME,ZPSHUTOFFTIME,'Dev1/port0/line0')
    ex.addLine('d','MOTRepumper','normal','Dev1/port0/line1')
    ex.addLine('d','MOTPower','normal',MOTPSHUTTERON,MOTPSHUTTEROFF,'Dev1/port0/line2')
%     ex.addLine('d','MOTPower','inverted',MOTPSHUTTERON,MOTPSHUTTEROFF,'Dev1/port0/line2')

    ex.addLine('d','ZSAOM','inverted','Dev1/port0/line3')
    ex.addLine('d','CameraTrigger','inverted',0,0,'Dev1/port0/line4')
    ex.addLine('d','Uniblitz','normal',0,100e-3,'Dev1/port0/line5')
    ex.addLine('d','IMG1Shutter','normal',IMG1SHUTONTIME,IMG1SHUTOFFTIME,'Dev1/port0/line6')
    ex.addLine('d','IMGAOM','normal','Dev1/port0/line7')
    ex.addLine('d','IMG2Shutter','inverted',IMG2SHUTONTIME,IMG2SHUTOFFTIME,'Dev1/port2/line0')
    ex.addLine('d','MOTRShutter','normal',MOTRSHUTONTIME,MOTRSHUTOFFTIME,'Dev1/port2/line1')
    ex.addLine('d','ODTAOM','normal','Dev1/port1/line7')
    ex.addLine('d','RFSwitch','inverted','Dev1/port2/line2')
    ex.addLine('d','SigPlusShutter','normal',SIGPLUSSHUTONTIME,SIGPLUSSHUTOFFTIME,'Dev1/port2/line4')
    ex.addLine('d','ACRShutter','normal',ACRONTIME,ACROFFTIME,'Dev1/port2/line5')
    ex.addLine('d','CameraShutter','normal',CAMERAONTIME,CAMERAOFFTIME,'Dev1/port2/line6')
    ex.addLine('d','BeatNoteLock','normal','Dev1/port3/line0')
    ex.addLine('d','SigMinusShutter','inverted',SIGMINUSSHUTONTIME,SIGMINUSSHUTOFFTIME,'Dev1/port3/line1')
    
    ex.addLine('d','PumpAOM','normal','Dev1/port3/line2')
    ex.addLine('d','Indicator','normal','Dev1/port3/line3')
    ex.addLine('d','MagellanCameraTrigger','inverted','Dev1/port3/line4')
    ex.addLine('d','MagellanVerticalIMGShutter','normal',VERTSHUTONTIME,VERTSHUTOFFTIME,'Dev1/port3/line5')
    ex.addLine('d','SoloistTrigger','normal','Dev1/port3/line6')
    ex.addLine('d','MagellanRepumper','normal',IMAGING4ONTIME,IMAGING4OFFTIME,'Dev1/port3/line7')
    ex.addLine('d','ODTIMGShutter','normal',ODTIMGSHUTTERONTIME,0,'Dev1/port2/line7')
%     ex.addLine('d','ODTIMGShutter','inverted',ODTIMGSHUTTERONTIME,0,'Dev1/port2/line7')
    
    ex.addLine('a','XBias',1,'value','Dev2/ao0') % We use G/cm, after this calibration
    ex.addLine('a','YBias',1,'value','Dev2/ao1') % We use A, after this calibration
    ex.addLine('a','Quadrupole',1,'value','Dev2/ao2')
    ex.addLine('a','ZBias',1,'value','Dev2/ao3')
    ex.addLine('a','MOTRVVA',1,'value','Dev2/ao4') % V
    ex.addLine('a','ImagingVVA',1,'value','Dev2/ao6') % V
    ex.addLine('a','ODTVVA',1,'value','Dev2/ao7') % V
    ex.addLine('a','RFVVA',1,'value','Dev2/ao5') % G
   
    
    ex.addLine('a','MagellanImgCoil',1,'value','Dev3/ao8')
    ex.addLine('a','MacroDimpleVoltage',1,'value','Dev3/ao9')
    ex.addLine('a','MagellanXCoil',1,'value','Dev3/ao10')
    ex.addLine('a','MagellanCompressCoil',1,'value','Dev3/ao11')
    ex.addLine('a','MagellanZCoil',1,'value','Dev3/ao12')
    ex.addLine('a','MagellanZTrigger',1,'value','Dev3/ao13')
    ex.addLine('a','BiasMacroVoltage',1,'value','Dev3/ao14')
    ex.addLine('a','CentralMacroVoltage',1,'value','Dev3/ao15') 
    ex.addLine('a','AxialMacroVoltage',1,'value','Dev3/ao16') 
    ex.addLine('a','ArmsMicroVoltage',1,'value','Dev3/ao17')
    ex.addLine('a','CentralMicroVoltage',1,'value','Dev3/ao18') 
    ex.addLine('a','DimpleMicroVoltage',1,'value','Dev3/ao19') 

    
    ex.addLine('dds','BeatNoteFreq',2,REF_FREQ,SYS_FREQ);
    ex.addLine('dds','RFFreq',3,REF_FREQ,SYS_FREQ);
    ddslines.write = 'Dev1/port1/line0';
    ddslines.reset = 'Dev1/port1/line4';
    ddslines.ioupdate = 'Dev1/port1/line3';
    ddslines.profile2 = 'Dev1/port1/line2';
    ddslines.profile3 = 'Dev1/port2/line3';
    ddslines.comport = 'COM3';
    
    
    %% Main Code; NOT Imaging or Reset
    
%     tic
%     loadFile = strcat('ACMBlock1_1_',oldID,'.mat');
%     load(loadFile,'ACMBlock','hashStruct')
%     disp('Load Block Time')
%     toc

%     SBList = ex.loadExpSubBlocks();
    % Add Imaging and Reset; Fill Block
    for tof = 1:numTOFs
%         tic
%         load('ACMBlock1_1.mat','ACMBlock','hashStruct')
%         disp('Load Block Time')
%         toc
%         disp(sprintf('MOTPower hash: %s', ex.MOTPower.hash))
        
%         disp(sprintf('MOTPower.hashable %i', ex.MOTPower.hashable))
%         disp(sprintf('MOTPower.pass2 %i' ,ex.MOTPower.pass2))
        tic
        SBList = ex.loadAllSubBlocks(); 
        disp(sprintf('First Run: %f', toc))
%         disp(sprintf('MOTPower hash: %s', ex.MOTPower.hash))
%         ex.checkAgainstHashFile(hashFileName); 
%         ex.makeHashFile(hashFileName);
%         disp(sprintf('MOTPower hash: %s', ex.MOTPower.hash))
        tic
        if exist('hashStruct','var')
            ex.checkAgainstHashStruct(hashStruct);
            hashStruct = ex.makeHashStruct();
        else
            hashStruct = ex.makeHashStruct();
            loadedFiles = ex.loadBlock(hashStruct);
            hashStructOld = loadedFiles.hashStruct;
            ACMBlock = loadedFiles.ACMBlock;
            olddds = loadedFiles.ddscode;
            ex.checkAgainstHashStruct(hashStructOld);
        end
        disp(sprintf('Load Block/Hashstruct: %f', toc))
%         loadedFiles = ex.loadBlock(hashStruct);
        
%         disp(sprintf('MOTPower hash: %s', ex.MOTPower.hash))
%         disp(sprintf('MOTPower struct hash: %s',hashStruct.MOTPower))
        tic
        ex.(CameraLine).hashable = 0;
        ex.setSecondPass()
        ex.loadAllSubBlocks();
        ex.checks(CameraLine)
        disp(sprintf('Second Run: %f', toc))

%         DDSLoad = strcat('DDSCode1_',oldID,'.mat');
%         olddds = load(DDSLoad);
        tic
        ex.ddscompile(j,ddslines.comport,olddds.ddsInputArrays,runID)
        disp(sprintf('DDS Compile: %f', toc))
        %% Add Block Definitions
        tf = ex.explength*dt;
        
        %% Add Devices
        sampleRate = 1/dt;
%         tic
%         load('ACMBlock1_1.mat','ACMBlock')
%         disp('Load Block Time')
%         toc
        loadBlock = 1;
        if (ex.explength*dt ~= ACMBlock.timeLine.durationTime && tf ~=0) || ACMBlock.devices{1,2}.sampleRate ~= sampleRate
            tic
            loadBlock = 0;
            disp('Making a new block')
            timeLine = TimeLine;
            timeLine.durationTime = tf;
            ACMBlock = Block('ACMBlock',timeLine);
            ACMBlock = ACMBlock.addDevice('Dev1', sampleRate); %Device names must map to hardware!
            ACMBlock = ACMBlock.addDevice('Dev2', sampleRate); %Device names must map to hardware!
            ACMBlock = ACMBlock.addDevice('Dev3', sampleRate); %Device names must map to hardware!
            ACMBlock.primaryDevice = 'Dev1';
            disp(sprintf('Make New Block Time: %f', toc))
        end
%         format long
        
        
        warning off all
        tic
        ACMBlock = ex.fillblockHashed(ACMBlock,ddslines,loadBlock);
        disp(sprintf('Fill Block: %f', toc))
        %% Reset Hashable Value for next TOF

        ex.resetHashable();

        % ---------Checking for over currents on microwires----------
        if ex.checkValueCondition('CentralMicroVoltage',abs(2.9/CentralMicroCal),'greaterAbs',0)
            error('CentralMicroVoltage is greater than or equal to 2.9amps!')
        end
        if ex.checkValueCondition('ArmsMicroVoltage',abs(1/ArmsMicroCal),'greaterAbs',0)
            error('ArmsMicroVoltage is greater than or equal to 1amps!')
        end
        if ex.checkValueCondition('DimpleMicroVoltage',abs(2/DimpleMicroCal),'greater',0)
            error('DimpleMicroVoltage is greater than or equal to 2amps!')
        end
 
        if ex.checkValueCondition('CentralMicroVoltage',abs(0.001/CentralMicroCal),'greaterAbs',12)
            error('CentralMicroVoltage is on for more than 8 seconds!')
        end
        if ex.checkValueCondition('ArmsMicroVoltage',abs(0.001/ArmsMicroCal),'greaterAbs',12)
            error('ArmsMicroVoltage is on for more than 8 seconds!')
        end
        if ex.checkValueCondition('DimpleMicroVoltage',abs(0.001/DimpleMicroCal),'greater',8)
            error('DimpleMicroVoltage is on for more than 8 seconds!')
        end
        %--------------------------------------------------------
        CurrTOF = TOFs(tof)*1000;
        tic
        save(['ACMBlock' num2str(j) '_' num2str(tof) '_' runID],'ACMBlock','ContParName','CurrContPar','CurrTOF','NumOfTOF','SBList','AllFiles','-v7.3','hashStruct');
        disp(sprintf('Save Time: %f', toc))
        %         clear ACMBlock;
    end
%     clear ACMBlock;
    %% Make run files
    runfiles(ContParName,CurrContPar,j,numTOFs,['DDSCode' num2str(j) '_' runID],runID)
    disp(['Done.'])
    disp(' ')
    toc
end
deleteString = strcat('*',oldID,'.mat');
delete(deleteString)
display(sprintf('Definition Elapsed Time: %.1f s',toc(ticST)))
% 

defineRun = 0;