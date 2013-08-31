%Loads Macro Compress

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

ODTAOM.ss('off',0,'end')
ODTVVA.ss(0,0,'end')

% RFSwitch.ss('on',0,'end')
RFSwitch.ss('off',0,'end')

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

% RFVVA.ss(0,0,'end')
RFVVA.ss(MacroCompRFVVA,0, 'end')

% RFVVA.ss(MacroCompRFVVAMin,0, 'end')
% RFVVA.linear(MacroCompRFVVAMax,MacroCompRFVVAMin,MacroCompRampTime,MacroCompRampTime + MacroCompRFSweepTime)


MagellanCompressCoil.ss(0,0,'end')
MagellanImgCoil.ss(YMacComp,0,'end')
MagellanImgCoil.linear(YMacCap,YMacComp,0,MacroCompRampTime)
MagellanXCoil.ss(XMacComp,0,'end')
MagellanXCoil.linear(XMacCap,XMacComp,0,MacroCompRampTime)
MagellanZCoil.ss(ZMacComp,0,'end')
MagellanZCoil.linear(ZMacCap,ZMacComp,0,MacroCompRampTime)

BiasMacroVoltage.ss(BiasMacComp,0,'end')
CentralMacroVoltage.ss(CentralMacComp,0,'end')
AxialMacroVoltage.ss(AxialMacComp,0,'end')
MacroDimpleVoltage.ss(DimpleMacroComp,0,'end')

BiasMacroVoltage.linear(BiasMacCap,BiasMacComp,0,MacroCompRampTime)
CentralMacroVoltage.linear(CentralMacCap,CentralMacComp,0,MacroCompRampTime)
AxialMacroVoltage.linear(AxialMacCap,AxialMacComp,0,MacroCompRampTime)

MacroDimpleVoltage.linear(DimpleMacroCap,DimpleMacroComp,0,MacroCompRampTime)
MagellanZTrigger.ss(0,0,'end')

% CentralMicroVoltage.ss(CentralMicroCap,0,'end')
CentralMicroVoltage.ss(0,0,'end')

% CentralMacroVoltage.sinoffset(CentralMacComp,MacroCompParaAmp,MacroCompParaFreq,MacroCompRampTime,'end')
% disp('Central Mac Trap Dither')
% CentralMicroVoltage.ss(0,0,'end')

ArmsMicroVoltage.ss(0,0,'end')

%CHIPTEST DELETE PLEASE 6/9/2013
% ArmsMicroVoltage.ss(ArmsMacComp,0,'end')

DimpleMicroVoltage.ss(0,0,'end')

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
% RFFreq.setfreq(Evap2LowFreq,0,'end')

% RFFreq.setfreqsweep(MacroCompRFHigh,MacroCompRFLow,0,'end')

%% Evap during Wait Time
RFFreq.setfreq(MacroCompRFHigh,0,MacroCompRampTime)
RFFreq.setfreq(MacroCompRFLow,MacroCompRampTime + MacroCompRFSweepTime,'end')
RFFreq.setfreqsweep(MacroCompRFHigh,MacroCompRFLow,MacroCompRampTime,MacroCompRampTime + MacroCompRFSweepTime)
