%Loads the off sub block

%% Digital
ZShutters.ss('closed',0,'end')

MOTRepumper.ss('off',0,'end')
MOTRShutter.ss('closed',0,'end')

MOTPower.ss('closed',0,'end')

ZSAOM.ss('off',0,'end')

CameraTrigger.ss('off',0,'end')
BeatNoteLock.ss('off',0,'end')
Uniblitz.ss('closed',0,'end')

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
XBias.ss('off',0,'end')
YBias.ss('off',0,'end')
ZBias.ss('off',0,'end')
Quadrupole.ss('off',0,'end')
MOTRVVA.ss('off',0,'end')
ImagingVVA.ss('off',0,'end')
ODTVVA.ss('off',0,'end')
RFVVA('off',0,'end')

MagellanImgCoil.ss('off',0,'end')
MagellanImgTrigger.ss('off',0,'end')
MagellanXCoil.ss('off',0,'end')
MagellanXTrigger.ss('off',0,'end')
MagellanZCoil.ss('off',0,'end')
MagellanZTrigger.ss('off',0,'end')
BiasMacroVoltage.ss('off',0,'end')
CentralMacroVoltage.ss('off',0,'end')
AxialMacroVoltage.ss('off',0,'end')
ArmsMicroVoltage.ss('off',0,'end')
DimpleMicroVoltage.ss('off',0,'end')

%% DDS
BeatNoteFreq.setfreq(MOTFreq,0,'end')
RFFreq.setfreq(Evap1HighFreq,0,'end')

