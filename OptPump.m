%Optical Pumping

%% Digital
ZShutters.ss('closed',0,'end')

if SIGPLUS
    MOTRepumper.ss('on',0,'end')
    MOTRShutter.ss('open',0,'end')
    MOTRVVA.ss(MOTRVVApump,0,'end')
else
    MOTRepumper.ss('on',0,'end')
    MOTRepumper.ss('off',MINUSREPUMPTIME,'end')
    MOTRShutter.ss('open',0,'end')
    MOTRShutter.ss('off',MINUSREPUMPTIME,'end')
    MOTRVVA.ss(MOTRVVApump,0,'end')
end


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

RFSwitch.ss('off',0,'end')

PumpAOM.ss('off',0,PumpSweepTime)
PumpAOM.ss('on',PumpSweepTime,'end')
ImagingVVA.ss(0,0,PumpSweepTime)
ImagingVVA.ss(pumpVVA,PumpSweepTime,'end')


if SIGPLUS
    SigPlusShutter.ss('closed',0,PumpSweepTime)
    SigPlusShutter.ss('open',PumpSweepTime,'end')
    SigMinusShutter.ss('closed',0,'end')

else
    SigMinusShutter.ss('closed',0,PumpSweepTime)
    SigMinusShutter.ss('open',PumpSweepTime,'end')
    SigPlusShutter.ss('closed',0,'end')
end

ACRShutter.ss('closed',0,'end')


Indicator.ss('off',0,'end')
MagellanCameraTrigger.ss('off',0,'end')
MagellanVerticalIMGShutter.ss('off',0,'end')
SoloistTrigger.ss('off',0,'end')
MagellanRepumper.ss('off',0,'end')

%% Coils
XBias.ss(XPump,0,'end')
YBias.ss(YPump,0,'end')
ZBias.ss(ZPump,0,'end')
Quadrupole.ss(0,0,'end')
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

ODTIMGShutter.ss('off',0,'end')

%% DDS
BeatNoteFreq.setfreqsweep(SubDopFreq,pumpFreq,0,PumpSweepTime)
BeatNoteFreq.setfreq(pumpFreq,PumpSweepTime,'end')
RFFreq.setfreq(Evap1HighFreq,0,'end')
% 
% SigMinusShutter.ss('closed',0,'end')
% SigPlusShutter.ss('closed',0,'end')
% MOTRShutter.ss('closed',0,'end')
