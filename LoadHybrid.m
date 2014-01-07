%Loads Hybrid Trap

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


RFSwitch.ss('off',0,'end')

SigPlusShutter.ss('closed',0,'end')
% SigPlusShutter.ss('open',0,'end')
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
XBias.ss(XHybrid,0,PURIFYTIME)
XBias.linear(XHybrid,XHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
XBias.ss(XHybridMax,(PURIFYTIME + HybridSweepTime),'end')

YBias.ss(YHybrid,0,PURIFYTIME)
YBias.linear(YHybrid,YHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
YBias.ss(YHybridMax,(PURIFYTIME + HybridSweepTime),'end')

ZBias.ss(ZHybrid,0,PURIFYTIME)
ZBias.linear(ZHybrid,ZHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
ZBias.ss(ZHybridMax,(PURIFYTIME + HybridSweepTime),'end')

Quadrupole.ss(HybridMaxBGrad,0,'end')
Quadrupole.erf(0,HybridStartBGrad,0,PURIFYERFTIME,PURIFYOFFSET)
Quadrupole.ss(HybridStartBGrad,(PURIFYERFTIME-PURIFYOFFSET),PURIFYTIME)
Quadrupole.linear(HybridStartBGrad,HybridMaxBGrad,PURIFYTIME,(PURIFYTIME+HybridSweepTime))


MOTRVVA.ss(0,0,'end')
ImagingVVA.ss(0,0,'end')

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
if OPTPUMP
    BeatNoteFreq.setfreqsweep(pumpFreq,ImageFreq,0,2e-3)
elseif SUBDOP
    BeatNoteFreq.setfreqsweep(SubDopFreq,ImageFreq,0,2e-3)
else
    BeatNoteFreq.setfreqsweep(MOTFreq,ImageFreq,0,2e-3)
end

BeatNoteFreq.setfreq(ImageFreq,2e-3,'end')
RFFreq.setfreq(Evap1HighFreq,0,'end')

% Indicator.ss('on',0,dt)
