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
    RFVVA.ss(0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime,'end')
    
    AxialMacroVoltage.linear(AxialMacroMicro,AxialMacroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')
    ArmsMicroVoltage.linear(ArmsMicroCap,ArmsMicroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')
    DimpleMicroVoltage.linear(DimpleMicroCap,DimpleMicroRelax,MicroCaptureTime-MicroCapRelaxTime,'end')

end



% RFVVA.ss(0,MicroCaptureTime-MicroCapRelaxTime,'end')
% RFVVA.ss(MicroCapRFVVA,MicroRampTime,'end')

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
    RFFreq.setfreq(MicroCapRFHigh,0,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime))
    RFFreq.setfreq(MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime) + MicroCapRFSweepTime,'end')
    RFFreq.setfreqsweep(MicroCapRFHigh,MicroCapRFLow,max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime),max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime)+ MicroCapRFSweepTime)
end

%%%%%------------------%%%%%%%%%%%




