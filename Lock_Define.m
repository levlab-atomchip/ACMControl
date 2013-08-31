clc
clear classes
ticST = tic;
delete('ACMBlock*','GUIRUN*','DDSCode*')
warning on all

defineRun = 1;
Variables
AllFiles = TextSave;

%% Setup Control Parameter
ContParName = 'VOID';
VOID = 0;
vars = whos;
for i = 1:length(vars)
    if any(vars(i).size>1) && ~strcmp(vars(i).class,'char') && ~any(strcmp({'AllFiles' 'TOFs' 'ans'},vars(i).name))
        ContParName = vars(i).name;
        break;
    end
end
ContPar = eval(ContParName);
J = length(ContPar);
J = 1;
disp(['Control Parameter is ' ContParName])
disp(' ')
for j = 1:J
%     tof = TOFs(1);
    %% Compile
    CurrContPar = ContPar(j);
    eval([ContParName '=' num2str(CurrContPar) ';']);
    
    disp(['Compiling Files for Parameter ' num2str(j) ' of ' num2str(J)])
    
    %% Experiment
    ex = Experiment(dt);

    %% SubBlocks
    ex.addSubBlock('LoadMOT', LoadTime, 1)
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
        DipoleTime
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
    
    ex.addSubBlock('Imaging', ImagingTime, 10) %tof + 2*WaitTime
    ex.addSubBlock('Reset', OffTime, 11)
    
    
    
    %% Lines
    ex.addLine('d','ZShutters','normal',ZPSHUTONTIME,ZPSHUTOFFTIME,'Dev1/port0/line0')
    ex.addLine('d','MOTRepumper','normal','Dev1/port0/line1')
    ex.addLine('d','MOTPower','normal',MOTPSHUTTERON,MOTPSHUTTEROFF,'Dev1/port0/line2')
    ex.addLine('d','ZSAOM','inverted','Dev1/port0/line3')
    ex.addLine('d','CameraTrigger','normal',0,0,'Dev1/port0/line4')
    ex.addLine('d','Uniblitz','normal','Dev1/port0/line5')
    ex.addLine('d','IMG1Shutter','normal',IMG1SHUTONTIME,IMG1SHUTOFFTIME,'Dev1/port0/line6')
    ex.addLine('d','IMGAOM','normal','Dev1/port0/line7')
    ex.addLine('d','IMG2Shutter','inverted',IMG2SHUTONTIME,IMG2SHUTOFFTIME,'Dev1/port2/line0')
    ex.addLine('d','MOTRShutter','normal',MOTRSHUTONTIME,MOTRSHUTOFFTIME,'Dev1/port2/line1')
    ex.addLine('d','ODTAOM','normal','Dev1/port1/line7')
    ex.addLine('d','RFSwitch','normal','Dev1/port2/line2')
    ex.addLine('d','SigPlusShutter','normal',SIGPLUSSHUTONTIME,SIGPLUSSHUTOFFTIME,'Dev1/port2/line4')
    ex.addLine('d','ACRShutter','normal',ACRONTIME,ACROFFTIME,'Dev1/port2/line5')
    ex.addLine('d','CameraShutter','normal',CAMERAONTIME,CAMERAOFFTIME,'Dev1/port2/line6')
    ex.addLine('d','BeatNoteLock','normal','Dev1/port3/line0')
    ex.addLine('d','SigMinusShutter','normal',SIGMINUSSHUTONTIME,SIGMINUSSHUTOFFTIME,'Dev1/port3/line1')
    
    ex.addLine('d','PumpAOM','normal','Dev1/port3/line2')
    ex.addLine('d','Indicator','normal','Dev1/port3/line3')
    ex.addLine('d','MagellanCameraTrigger','normal','Dev1/port3/line4')
    ex.addLine('d','MagellanVerticalIMGShutter','normal',VERTSHUTONTIME,VERTSHUTOFFTIME,'Dev1/port3/line5')
    ex.addLine('d','SoloistTrigger','normal','Dev1/port3/line6')
    ex.addLine('d','MagellanRepumper','normal',IMAGING4ONTIME,IMAGING4OFFTIME,'Dev1/port3/line7')
    
    
    ex.addLine('a','XBias',1,'value','Dev2/ao0') % We use G/cm, after this calibration
    ex.addLine('a','YBias',1,'value','Dev2/ao1') % We use A, after this calibration
    ex.addLine('a','Quadrupole',1,'value','Dev2/ao2')
    ex.addLine('a','ZBias',1,'value','Dev2/ao3')
    ex.addLine('a','MOTRVVA',1,'value','Dev2/ao4') % V
    ex.addLine('a','ImagingVVA',1,'value','Dev2/ao6') % V
    ex.addLine('a','ODTVVA',1,'value','Dev2/ao7') % V
    ex.addLine('a','DimpleMacroVoltage',1,'value','Dev2/ao5') % G
    
    ex.addLine('a','MagellanImgCoil',1,'value','Dev3/ao8')
    ex.addLine('a','MagellanImgTrigger',1,'value','Dev3/ao9')
    ex.addLine('a','MagellanXCoil',1,'value','Dev3/ao10')
    ex.addLine('a','MagellanXTrigger',1,'value','Dev3/ao11')
    ex.addLine('a','MagellanZCoil',1,'value','Dev3/ao12')
    ex.addLine('a','MagellanZTrigger',1,'value','Dev3/ao13')
    ex.addLine('a','BiasMacroVoltage',1,'value','Dev3/ao14')
    ex.addLine('a','CentralMacroVoltage',1,'value','Dev3/ao15') 
    ex.addLine('a','AxialMacroVoltage',1,'value','Dev3/ao16') 
    ex.addLine('a','ArmsMicroVoltage',1,'value','Dev3/ao17')
    ex.addLine('a','CentralMicroVoltage',1,'value','Dev3/ao18') 
    ex.addLine('a','DimpleMicroVoltage',1,'value','Dev3/ao19') 

    
    ex.addLine('dds','BeatNoteFreq',0,REF_FREQ,SYS_FREQ);
    ex.addLine('dds','RFFreq',1,REF_FREQ,SYS_FREQ);
    ddslines.write = 'Dev1/port1/line0';
    ddslines.reset = 'Dev1/port1/line4';
    ddslines.ioupdate = 'Dev1/port1/line3';
    ddslines.profile0 = 'Dev1/port1/line2';
    ddslines.profile1 = 'Dev1/port2/line3';
    ddslines.comport = 'COM3';
    
    %% Main Code; NOT Imaging or Reset
    SBList = ex.loadExpSubBlocks();
    % Add Imaging and Reset; Fill Block
    for tof = 1:numTOFs
        nex = ex.copy();
        nex.loadImgRstSubBlocks()
        nex.checks(CameraLine)
%         swiCoil = [abs(diff(nex.MOTHelmholtz.array))' 0];
%         if any(nex.MOTCoil.array(swiCoil)) < 0
%             error('don''t switch while coil has current')
%         end
        
        nex.ddscompile(j,ddslines.comport)
        
        %% Add Block Definitions
        tf = nex.explength*dt;
        timeLine = TimeLine;
        timeLine.durationTime = tf;
        ACMBlock = Block('ACMBlock',timeLine);
        
        %% Add Devices
        sampleRate = 1/dt;
        ACMBlock = ACMBlock.addDevice('Dev1', sampleRate); %Device names must map to hardware!
        ACMBlock = ACMBlock.addDevice('Dev2', sampleRate); %Device names must map to hardware!
        ACMBlock = ACMBlock.addDevice('Dev3', sampleRate); %Device names must map to hardware!
        ACMBlock.primaryDevice = 'Dev1';
        
        warning off all
        
        ACMBlock = nex.fillblock(ACMBlock,ddslines);
        
        CurrTOF = TOFs(tof)*1000;
        save(['ACMBlock' num2str(j) '_' num2str(tof)],'ACMBlock','ContParName','CurrContPar','CurrTOF','SBList','AllFiles','-v7.3');
        clear ACMBlock;
    end
    %% Make run files
    runfiles(ContParName,CurrContPar,j,numTOFs,['DDSCode' num2str(j)])
    disp(['Done.'])
    disp(' ')
end
display(sprintf('Definition Elapsed Time: %.1f s',toc(ticST)))
% 
defineRun = 0;