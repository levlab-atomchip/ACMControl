%Loads Macro Capture

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

RFSwitch.ss('off',0,'end')
% RFSwitch.ss('on',0,'end')


% ODTAOM.ss('on',0,'end')
% ODTVVA.ss(MaxODTPwr,0,ODTWaitTime)
% ODTVVA.linear(MaxODTPwr,0,ODTWaitTime,ODTRampTime+ODTWaitTime)
% ODTVVA.ss(0,ODTRampTime+ODTWaitTime,'end')
% ODTAOM.ss('off',ODTRampTime+ODTWaitTime,'end')

ODTAOM.ss('on',0,'end')
ODTVVA.ss(MaxODTPwr,0,ODTWaitTime)
ODTVVA.linear(MaxODTPwr,ODTEndVoltage,ODTWaitTime,ODTRampTime+ODTWaitTime)
ODTVVA.ss(ODTEndVoltage,ODTRampTime+ODTWaitTime,'end')
if ODTEndVoltage == 0
    ODTAOM.ss('off',ODTRampTime+ODTWaitTime,'end')
end

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

RFVVA.ss(0,0,'end')

MagellanImgCoil.ss(YMacCap,0,'end')
MagellanImgCoil.linear(0,YMacCap,0,MacroRampTime)
MagellanXCoil.ss(XMacCap,0,'end')
MagellanXCoil.linear(0,XMacCap,0,MacroRampTime)
MagellanZCoil.ss(ZMacCap,0,'end')
MagellanZCoil.linear(0,ZMacCap,0,MacroRampTime)

BiasMacroVoltage.ss(BiasMacCap,0,'end')
CentralMacroVoltage.ss(CentralMacCap,0,'end')
AxialMacroVoltage.ss(AxialMacCap,0,'end')
MagellanCompressCoil.ss(CompressMacCap,0,'end')
MacroDimpleVoltage.ss(DimpleMacroCap,0,'end')

%%---- macrowires compress only---%
%--- Feb 25 2013--% 
MagellanCompressCoil.linear(0,CompressMacCap,0,MacroRampTime)
BiasMacroVoltage.linear(0,BiasMacCap,0,MacroRampTime)

CentralMacroVoltage.linear(0,CentralMacCap,0,MacroRampTime)
% CentralMacroVoltage.sinoffset(CentralMacCap,MacroParaAmp,MacroParaFreq,MacroRampTime,'end')

AxialMacroVoltage.linear(0,AxialMacCap,0,MacroRampTime)
%---------------------------------%

MacroDimpleVoltage.linear(0,DimpleMacroCap,0,MacroRampTime)
MagellanZTrigger.ss(0,0,'end')

CentralMicroVoltage.ss(0,0,'end')
% CentralMicroVoltage.ss(CentralMicroCap,0,'end')
% CentralMicroVoltage.linear(0,CentralMicroCap,0,MacroRampTime)

ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')

%---- compress with compression coils before hand off to macrowires--%
% MagellanCompressCoil.ss(0,0,'end')
% MagellanCompressCoil.linear(0,CompressMacCap,0,CompressUpRampTime)
% MagellanCompressCoil.linear(CompressMacCap,0,CompressUpRampTime,CompressUpRampTime+CompressDownRampTime)
% 
% CentralMacroVoltage.ss(0,0,'end')
% CentralMacroVoltage.linear(0,CentralMacCap,CompressUpRampTime-MacroRampTime,CompressUpRampTime)
% CentralMacroVoltage.ss(CentralMacCap,CompressUpRampTime,'end')
% 
% AxialMacroVoltage.ss(0,0,'end')
% AxialMacroVoltage.linear(0,AxialMacCap,CompressUpRampTime,CompressUpRampTime+AxialMacRampTime)
% AxialMacroVoltage.ss(AxialMacCap,CompressUpRampTime+AxialMacRampTime,'end')

%-------------------------------%

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
% RFFreq.setfreq(Evap2LowFreq,0,'end')
RFFreq.setfreq(MacroCompRFHigh,0,'end')
