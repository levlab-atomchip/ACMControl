%Loads MoveDipole

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

if OPTEVAP && RECOMPRESSODT
    ODTVVA.ss(RecompressValue,0,'end')
elseif OPTEVAP
    ODTVVA.ss(OptEvapODTVVAEnd,0,'end')
else
    ODTVVA.ss(MaxODTPwr,0,'end')
end

RFSwitch.ss('off',0,'end')


SigPlusShutter.ss('closed',0,'end')
SigMinusShutter.ss('closed',0,'end')

ACRShutter.ss('closed',0,'end')

PumpAOM.ss('off',0,'end')
Indicator.ss('off',0,'end')
MagellanCameraTrigger.ss('off',0,'end')
MagellanVerticalIMGShutter.ss('off',0,'end')
MagellanRepumper.ss('off',0,'end')

SoloistTrigger.ss('off',0,'end')
SoloistTrigger.ss('on',0,5e-3)

% disp('Commented out round trip in movedipole')
if IMAGING == 2
    SoloistTrigger.ss('on',TransitTime+MoveHoldTime,TransitTime+MoveHoldTime+10e-3)
end

ODTIMGShutter.ss('off',0,'end')
%% Coils
XBias.ss(0,0,'end')
YBias.ss(0,0,'end')
ZBias.ss(0,0,'end')

Quadrupole.ss(0,0,'end')


MOTRVVA.ss(0,0,'end')
ImagingVVA.ss(0,0,'end')

RFVVA.ss(0,0,'end')

MagellanImgCoil.ss(0,0,'end')
MacroDimpleVoltage.ss(0,0,'end')
MagellanXCoil.ss(MagXMoveDipole,0,'end')
MagellanZCoil.ss(0,0,'end')
MagellanZTrigger.ss(0,0,'end')
BiasMacroVoltage.ss(0,0,'end')
CentralMacroVoltage.ss(10,0,'end')
AxialMacroVoltage.ss(0,0,'end')
ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')
CentralMicroVoltage.ss(0,0,'end')

MagellanCompressCoil.ss(CompCoilMoveDipole,0,'end')
MagellanCompressCoil.linear(0,CompCoilMoveDipole,0,TransitTime/2.0)
MagellanCompressCoil.linear(CompCoilMoveDipole,0,TransitTime/2.0,TransitTime)


%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
RFFreq.setfreq(Evap2LowFreq,0,'end')

% ODTVVA.sinoffset(MaxODTPwr,ODTParaAmp,ODTParaFreq,MoveDipoleTime-MoveParaTime,'end')
