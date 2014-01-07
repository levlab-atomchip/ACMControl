%Loads Hybrid Evap

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
% ODTAOM.ss('off',0,'end')
% disp('ODT OFF IN EVAP')
ODTVVA.ss(MaxODTPwr,0,'end')



RFSwitch.ss('on',0,'end')
% RFSwitch.ss('off',0,'end') %% To Sci Chamber

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
XBias.ss(XRFEvap,0,'end')
YBias.ss(YRFEvap,0,'end')
ZBias.ss(ZRFEvap,0,'end')

Quadrupole.ss(HybridMaxBGrad,0,'end')
% disp('RAMPING OFF QUAD FIELD IN HYBRIDEVAP')
% Quadrupole.linear(HybridMaxBGrad,HybridRampEndB,HybridEvapTime-HybridHoldTime,'end')
% ZBias.linear(ZRFEvap,ZRampEndB,HybridEvapTime-HybridHoldTime,'end')

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
CentralMacroVoltage.ss(10,0,'end')
AxialMacroVoltage.ss(0,0,'end')
ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')
CentralMicroVoltage.ss(0,0,'end')

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
RFFreq.setfreqsweep(Evap1HighFreq,Evap1LowFreq,0,Evap1SweepTime)
RFFreq.setfreq(Evap1LowFreq,Evap1SweepTime,'end')

if TwoSlopeEvap
    RFFreq.setfreqsweep(Evap3HighFreq,Evap3LowFreq,Evap1SweepTime,Evap1SweepTime+Evap3SweepTime)
    RFFreq.setfreq(Evap3LowFreq,Evap3SweepTime,'end')
end
if ThreeSlopeEvap
    RFFreq.setfreqsweep(Evap4HighFreq,Evap4LowFreq,Evap1SweepTime+Evap3SweepTime,Evap1SweepTime+Evap3SweepTime+Evap4SweepTime)
    RFFreq.setfreq(Evap4LowFreq,Evap4SweepTime,'end')
end
