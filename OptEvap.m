%Loads Optical Evap

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

ODTAOM.ss('on',0,'end')
ODTVVA.ss(MaxODTPwr,0,'end')

% ODTVVA.linear(MaxODTPwr,OptEvapEndPwr,0,OptEvapSweepTime)
ODTVVA.ss(OptEvapEndPwr,0,'end')
ODTVVA.quadratic(a2,a1,a0,0,OptEvapSweepTime)
if RECOMPRESSODT
%     ODTVVA.linear(OptEvapEndPwr,RecompressValue,OptEvapSweepTime,RecompressTime+OptEvapSweepTime)
    ODTVVA.linear(OptEvapODTVVAEnd,RecompressValue,OptEvapSweepTime,RecompressTime+OptEvapSweepTime)
    ODTVVA.ss(RecompressValue,RecompressTime+OptEvapSweepTime, 'end')
end


RFSwitch.ss('on',0,'end')


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
XBias.ss(XOptEvap,0,OptEvapSweepTime)
YBias.ss(YOptEvap,0,OptEvapSweepTime)
ZBias.ss(ZOptEvap,0,OptEvapSweepTime)
if RECOMPRESSODT
%     XBias.ss(XOptEvap,OptEvapSweepTime,OptEvapSweepTime+RecompressTime)
%     YBias.ss(YOptEvap,OptEvapSweepTime,OptEvapSweepTime+RecompressTime)
%     ZBias.ss(ZOptEvap,OptEvapSweepTime,OptEvapSweepTime+RecompressTime)

%     XBias.linear(XOptEvap,XOptEvapHold,OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime)
%     YBias.linear(YOptEvap,YOptEvapHold,OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime)
%     ZBias.linear(ZOptEvap,ZOptEvapHold,OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime)

    XBias.linear(XOptEvap,XOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    YBias.linear(YOptEvap,YOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    ZBias.linear(ZOptEvap,ZOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)


%     XBias.ss(XOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,'end')
%     YBias.ss(YOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,'end')
%     ZBias.ss(ZOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,'end')

    XBias.ss(XOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')
    YBias.ss(YOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')
    ZBias.ss(ZOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')


%     XBias.ss(XOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime+MagHoldTime)
%     YBias.ss(YOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime+MagHoldTime)
%     ZBias.ss(ZOptEvapHold,MagSweepTime+OptEvapSweepTime+RecompressTime,MagSweepTime+OptEvapSweepTime+RecompressTime+MagHoldTime)
else
    XBias.linear(XOptEvap,XOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    YBias.linear(YOptEvap,YOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    ZBias.linear(ZOptEvap,ZOptEvapHold,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    
    XBias.ss(XOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')
    YBias.ss(YOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')
    ZBias.ss(ZOptEvapHold,MagSweepTime+OptEvapSweepTime,'end')
end


Quadrupole.linear(OptEvapStartBGrad,OptEvapEndBGrad,0,OptEvapSweepTime)
if RECOMPRESSODT
%     Quadrupole.ss(OptEvapEndBGrad,OptEvapSweepTime, OptEvapSweepTime + RecompressTime)
%     Quadrupole.linear(OptEvapEndBGrad,HoldBGrad,OptEvapSweepTime+RecompressTime,RecompressTime+OptEvapSweepTime+MagSweepTime)
%     Quadrupole.ss(HoldBGrad,OptEvapSweepTime+RecompressTime+MagSweepTime,'end')

    Quadrupole.linear(OptEvapEndBGrad,HoldBGrad,OptEvapSweepTime,MagSweepTime+OptEvapSweepTime)
    Quadrupole.ss(HoldBGrad,OptEvapSweepTime+MagSweepTime,'end')
else
    Quadrupole.linear(OptEvapEndBGrad,HoldBGrad,OptEvapSweepTime,OptEvapSweepTime+MagSweepTime)
    Quadrupole.ss(HoldBGrad,OptEvapSweepTime+MagSweepTime,'end')
end

MOTRVVA.ss(0,0,'end')
ImagingVVA.ss(0,0,'end')

RFVVA.ss(RFVVASet,0,'end')

MagellanImgCoil.ss(0,0,'end')
MacroDimpleVoltage.ss(0,0,'end')
MagellanXCoil.ss(0,0,'end')
MagellanCompressCoil.ss(0,0,'end')
MagellanZCoil.ss(0,0,'end')
MagellanZTrigger.ss(0,0,'end')
BiasMacroVoltage.ss(0,0,'end')
CentralMacroVoltage.ss(0,0,'end')
AxialMacroVoltage.ss(0,0,'end')
ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')
CentralMicroVoltage.ss(0,0,'end')

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
RFFreq.setfreq(Evap2LowFreq,0,'end')
