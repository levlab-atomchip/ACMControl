%Loads the MOT

%% Digital

ZShutters.ss('closed',0,'end')

MOTRepumper.ss('off',0,'end')
MOTRShutter.ss('closed',0,'end')

MOTPower.ss('closed',0,'end')

ZSAOM.ss('off',0,'end')

ZShutters.ss('open',UniblitzTime,'end')
% ZShutters.ss('closed',UniblitzTime,'end')

MOTRepumper.ss('on',UniblitzTime,'end')
MOTRShutter.ss('open',UniblitzTime,'end')

MOTPower.ss('open',UniblitzTime,'end')

ZSAOM.ss('on',UniblitzTime,'end')

CameraTrigger.ss('off',0,'end')
BeatNoteLock.ss('on',0,'end')
Uniblitz.ss('open',0,'end')


IMG1Shutter.ss('closed',0,'end')
IMGAOM.ss('off',0,'end')
IMG2Shutter.ss('closed',0,'end')
CameraShutter.ss('closed',0,'end')

ODTAOM.ss('off',0,'end')


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
XBias.ss(XLoad,UniblitzTime,'end')
YBias.ss(0,0,'end')
YBias.ss(YLoad,UniblitzTime,'end')
ZBias.ss(0,0,'end')
ZBias.ss(ZLoad,UniblitzTime,'end')
Quadrupole.ss(0,0,'end')
Quadrupole.ss(QuadSet,UniblitzTime,'end')
Quadrupole.ss(0,MOTTime-MOTQuadOffDelay,'end')
MOTRVVA.ss(MOTRVVALoadMOT,0,'end')
ImagingVVA.ss(0,0,'end')



ODTVVA.ss(0,0,'end')


RFVVA.ss(0,0,'end')

MagellanImgCoil.ss(0,0,'end')
MacroDimpleVoltage.ss(0,0,'end')
MagellanXCoil.ss(0,0,'end')
MagellanCompressCoil.ss(0,0,'end')
MagellanZCoil.ss(0,0,'end')
MagellanZTrigger.ss(0,0,'end')
BiasMacroVoltage.ss(0,0,'end')
CentralMacroVoltage.ss(10,0,'end')
AxialMacroVoltage.ss(0,0,'end')
ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')
CentralMicroVoltage.ss(0,0,'end')

%% DDS

% BeatNoteFreq.noreset(0)
BeatNoteFreq.reset(0)
BeatNoteFreq.setfreq(MOTFreq,500e-6,'end')
RFFreq.reset(0)
RFFreq.setfreq(Evap1HighFreq,1e-3,'end')

% % Switch to turn on ODT during LoadMOT (for alignment)
% disp('ODT on in LoadMOT')
% ODTAOM.ss('on',0,'end')
% ODTVVA.ss(10,0,'end')

