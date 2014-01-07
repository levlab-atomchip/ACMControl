%Loads Micro Capture

%% Digital
ZShutters.ss('closed',0,'end')

MOTRepumper.ss('off',0,'end')
MOTRShutter.ss('closed',0,'end')

MOTPower.ss('closed',0,'end')

ZSAOM.ss('off',0,'end')

CameraTrigger.ss('off',0,'end')
BeatNoteLock.ss('on',0,'end')
Uniblitz.ss('closed',0,'end')

IMG1Shutter.ss('closed',0,'end')
IMGAOM.ss('off',0,'end')
IMG2Shutter.ss('closed',0,'end')
CameraShutter.ss('closed',0,'end')

% RFSwitch.ss('on',0,'end')
RFSwitch.ss('off',0,'end')

ODTAOM.ss('off',0,'end')
ODTVVA.ss(0,0,'end')

SigPlusShutter.ss('closed',0,'end')
SigMinusShutter.ss('closed',0,'end')

ACRShutter.ss('closed',0,'end')

PumpAOM.ss('off',0,'end')
Indicator.ss('off',0,'end')
MagellanCameraTrigger.ss('off',0,'end')
MagellanVerticalIMGShutter.ss('off',0,'end')
SoloistTrigger.ss('off',0,'end')
MagellanRepumper.ss('off',0,'end')

ODTIMGShutter.ss('off',0,'end')

%% Coils
XBias.ss(0,0,'end')
YBias.ss(0,0,'end')
ZBias.ss(0,0,'end')
Quadrupole.ss(0,0,'end')


MOTRVVA.ss(0,0,'end')
ImagingVVA.ss(0,0,'end')



MagellanImgCoil.ss(YMicroCap,0,'end')
MagellanImgCoil.linear(YMacComp,YMicroCap,0,MicroRampTime)
MagellanXCoil.ss(XMicroCap,0,'end')
MagellanXCoil.linear(XMacComp,XMicroCap,0,MicroRampTime)
MagellanZCoil.ss(ZMicroCap,0,'end')
MagellanZCoil.linear(ZMacComp,ZMicroCap,0,MicroRampTime)

BiasMacroVoltage.ss(BiasMacroMicro,0,'end')
CentralMacroVoltage.ss(CentralMacroMicro,0,'end')
AxialMacroVoltage.ss(AxialMacroMicro,0,'end')
MagellanCompressCoil.ss(CompressMacroMicro,0,'end')

BiasMacroVoltage.ss(BiasMacComp,0,MacroMicroWaitTime)
CentralMacroVoltage.ss(CentralMacComp,0,MacroMicroWaitTime)
AxialMacroVoltage.ss(AxialMacComp,0,MacroMicroWaitTime)
MagellanCompressCoil.ss(CompressMacroComp,0,MacroMicroWaitTime)


MagellanCompressCoil.linear(CompressMacroComp,CompressMacroMicro,MacroMicroWaitTime,MacroMicroWaitTime+MacroMicroRampTime)
BiasMacroVoltage.linear(BiasMacComp,BiasMacroMicro,MacroMicroWaitTime,MacroMicroWaitTime+MacroMicroRampTime)
CentralMacroVoltage.linear(CentralMacComp,CentralMacroMicro,MacroMicroWaitTime,MacroMicroWaitTime+MacroMicroRampTime)
AxialMacroVoltage.linear(AxialMacComp,AxialMacroMicro,MacroMicroWaitTime,MacroMicroWaitTime+MacroMicroRampTime)

MacroDimpleVoltage.ss(0,0,'end')
MagellanZTrigger.ss(0,0,'end')

CentralMicroVoltage.ss(CentralMicroCap,0,'end')
ArmsMicroVoltage.ss(ArmsMicroCap,0,'end')
DimpleMicroVoltage.ss(DimpleMicroCap,0,'end')

CentralMicroVoltage.linear(0,CentralMicroCap,0,MicroRampTime)
ArmsMicroVoltage.linear(0,ArmsMicroCap,0,MicroRampTime)
DimpleMicroVoltage.linear(0,DimpleMicroCap,0,MicroRampTime)
% 

if DimpleToArmTrap
    RFVVA.ss(MicroCapRFVVA,0,'end')
    RFVVA.ss(0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime)
    
    AxialMacroVoltage.linear(AxialMacroMicro,AxialMacroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime)
    ArmsMicroVoltage.linear(ArmsMicroCap,ArmsMicroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime)
    DimpleMicroVoltage.linear(DimpleMicroCap,DimpleMicroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime)
    
    AxialMacroVoltage.ss(AxialMacroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime,'end')
    ArmsMicroVoltage.ss(ArmsMicroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime,'end')
    DimpleMicroVoltage.ss(DimpleMicroRelax,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime,'end')
else
    RFVVA.ss(MicroCapRFVVA,0,'end')
    RFVVA.ss(0,0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime))
    if TWOSTEPMICROEVAP && THREESTEPMICROEVAP
        RFVVA.ss(0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime + MicroCapRFSweepTime2+MicroCapRFSweepTime3,'end')
    elseif TWOSTEPMICROEVAP
        RFVVA.ss(0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime + MicroCapRFSweepTime2,'end')
    else
        RFVVA.ss(0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime,'end')
    end
    %RFVVA.ss(0,MicroCaptureTime-MicroCapRelaxTime,'end')
%     AxialMacroVoltage.linear(AxialMacroMicro,AxialMacroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')
%     ArmsMicroVoltage.linear(ArmsMicroCap,ArmsMicroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')
%     DimpleMicroVoltage.linear(DimpleMicroCap,DimpleMicroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')

end


if EvapThenTranslate
    CentralMicroVoltage.linear(CentralMicroCap,CentralMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    ArmsMicroVoltage.linear(ArmsMicroCap,ArmsMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    DimpleMicroVoltage.linear(DimpleMicroCap,DimpleMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    
    MagellanCompressCoil.linear(CompressMacroMicro,CompressMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    BiasMacroVoltage.linear(BiasMacroMicro,BiasMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    CentralMacroVoltage.linear(CentralMacroMicro,CentralMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    AxialMacroVoltage.linear(AxialMacroMicro,AxialMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)

    MagellanImgCoil.linear(YMicroCap,YMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    MagellanXCoil.linear(XMicroCap,XMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    MagellanZCoil.linear(ZMicroCap,ZMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)

    CentralMicroVoltage.ss(CentralMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    ArmsMicroVoltage.ss(ArmsMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    DimpleMicroVoltage.ss(DimpleMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    
    MagellanCompressCoil.ss(CompressMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    BiasMacroVoltage.ss(BiasMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    CentralMacroVoltage.ss(CentralMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    AxialMacroVoltage.ss(AxialMacroMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)

    MagellanImgCoil.ss(YMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    MagellanXCoil.ss(XMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
    MagellanZCoil.ss(ZMicroTrans,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)

    
    RFVVA.ss(0,MicroCaptureTime - EvapThenTranslate - MicroCapHoldTime,MicroCaptureTime - MicroCapHoldTime)
end

% RFVVA.ss(0,MicroCaptureTime-MicroCapRelaxTime,'end')
% RFVVA.ss(MicroCapRFVVA,MicroRampTime,'end')

%% Parametric Oscillation
% CentralMicroVoltage.sinoffset(CentralMicroCap,MicroCapParaAmp,MicroCompParaFreq,MicroCaptureTime-MicroCapHoldTime,'end')
% disp('Central Micro Trap Dither')

%% Trap Kick
% CentralMicroVoltage.ss(MicroCaptureKickAmp + CentralMicroCap,MicroCaptureTime-MicroCapHoldTime,'end')
% disp('Central Micro Trap Kick')

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
% RFFreq.setfreq(Evap2LowFreq,0,'end')

%%%% Two Step Evap %%%%%%%%%%%%%%
if DimpleToArmTrap
    RFFreq.setfreq(DimpleEvapHigh,0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime))
    RFFreq.setfreqsweep(DimpleEvapHigh,DimpleEvapLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime)
    RFFreq.setfreq(ArmEvapHigh,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime)
    
    RFFreq.setfreqsweep(ArmEvapHigh,ArmEvapLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime + ArmEvapSweepTime)
    RFFreq.setfreq(ArmEvapLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + DimpleEvapSweepTime + DimpleArmTransferTime + ArmEvapSweepTime,'end')
else
    if TWOSTEPMICROEVAP && THREESTEPMICROEVAP
        MagRampTime = max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);   
        RFFreq.setfreq(MicroCapRFHigh,0,MagRampTime)
        RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,MagRampTime,MagRampTime+ MicroCapRFSweepTime) 
        RFFreq.setfreq(MicroCapRFHigh2,MagRampTime + MicroCapRFSweepTime,MagRampTime + MicroCapRFSweepTime+EvapDelayTime)        
        RFFreq.setfreqsweep(MicroCapRFHigh2,MicroCapRFLow2,MagRampTime+ MicroCapRFSweepTime+EvapDelayTime,MagRampTime+ MicroCapRFSweepTime + MicroCapRFSweepTime2 + EvapDelayTime)       
        RFFreq.setfreq(MicroCapRFLow2,MagRampTime + MicroCapRFSweepTime+MicroCapRFSweepTime2 +EvapDelayTime,MagRampTime + MicroCapRFSweepTime+MicroCapRFSweepTime2 +EvapDelayTime + EvapDelayTime3)

                RFFreq.setfreqsweep(MicroCapRFHigh3,MicroCapRFLow3,10e-3+MicroCapRFSweepTime2+EvapDelayTime3+MagRampTime+ MicroCapRFSweepTime+EvapDelayTime,EvapDelayTime3+MagRampTime+ MicroCapRFSweepTime + MicroCapRFSweepTime2+MicroCapRFSweepTime3 + EvapDelayTime)
%         RFFreq.setfreqsweep(MicroCapRFHigh3,MicroCapRFLow3,MicroCapRFSweepTime2-10e-3+EvapDelayTime3+MagRampTime+ MicroCapRFSweepTime+EvapDelayTime,EvapDelayTime3+MagRampTime+ MicroCapRFSweepTime + MicroCapRFSweepTime2+MicroCapRFSweepTime3 + EvapDelayTime)

        RFFreq.setfreq(MicroCapRFLow3,EvapDelayTime3+MagRampTime+ MicroCapRFSweepTime + MicroCapRFSweepTime2+MicroCapRFSweepTime3 + EvapDelayTime,'end')
    
    elseif TWOSTEPMICROEVAP
        MagRampTime = max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);
        RFFreq.setfreq(MicroCapRFHigh,0,MagRampTime)
        RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,MagRampTime,MagRampTime+ MicroCapRFSweepTime)
        RFFreq.setfreq(MicroCapRFHigh2,MagRampTime + MicroCapRFSweepTime,MagRampTime + MicroCapRFSweepTime+EvapDelayTime)
        RFFreq.setfreqsweep(MicroCapRFHigh2,MicroCapRFLow2,MagRampTime+ MicroCapRFSweepTime+EvapDelayTime,MagRampTime+ MicroCapRFSweepTime + MicroCapRFSweepTime2 + EvapDelayTime)
        RFFreq.setfreq(MicroCapRFLow2,MagRampTime + MicroCapRFSweepTime+MicroCapRFSweepTime2 +EvapDelayTime,'end')

        
        
%         RFFreq.setfreq(MicroCapRFHigh,0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime))
%         RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime)+ MicroCapRFSweepTime)
%         RFFreq.setfreq(MicroCapRFHigh2,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime+EvapDelayTime)
%         RFFreq.setfreqsweep(MicroCapRFHigh2,MicroCapRFLow2,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime)+ MicroCapRFSweepTime+EvapDelayTime,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime)+ MicroCapRFSweepTime + MicroCapRFSweepTime2 + EvapDelayTime)
%         RFFreq.setfreq(MicroCapRFLow2,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime+MicroCapRFSweepTime2 +EvapDelayTime,'end')

    else        
        RFFreq.setfreq(MicroCapRFHigh,0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime))
        RFFreq.setfreq(MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime,'end')
        RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime)+ MicroCapRFSweepTime)
    end
    %     RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),'end')
end

%%%%%------------------%%%%%%%%%%%
%Indicator.ss('on',MicroCaptureTime-dt,'end')
%Indicator.ss('on',max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime + MicroCapRFSweepTime2+MicroCapRFSweepTime3,'end')
% Indicator.ss('on',max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + dt)

