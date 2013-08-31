%Loads Dipole Trap

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
% ODTVVA.sinoffset(MaxODTPwr,DipoleParaAmp,DipoleParaFreq,DipoleBSweepTime, 'end')


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

%% Coils
XBias.ss(XDipole,0,'end')
YBias.ss(YDipole,0,'end')
ZBias.ss(ZDipole,0,'end')

if DipoleBiasSweep
    if ByRates
        XBias.linear(XRFEvap,XDipole,0,(XDipole-XRFEvap)/XSweepRate)
        YBias.linear(YRFEvap,YDipole,0,(YDipole-YRFEvap)/YSweepRate)
        ZBias.linear(ZRFEvap,ZDipole,0,(ZDipole-ZRFEvap)/ZSweepRate)
    else
        XBias.linear(XRFEvap,XDipole,0,DipoleBSweepTime)
        YBias.linear(YRFEvap,YDipole,0,DipoleBSweepTime)
        ZBias.linear(ZRFEvap,ZDipole,0,DipoleBSweepTime)
    end
    if SIGPLUS
        for i = 2:length(DipoleBiasSweepTimes)
            ZBias.linear(DipoleBiasSweepValues(i-1),DipoleBiasSweepValues(i),DipoleBiasSweepTimes(i-1),DipoleBiasSweepTimes(i))
        end
    end
end


Quadrupole.ss(DipoleEndBGrad,0,'end')
Quadrupole.linear(DipoleStartBGrad,DipoleEndBGrad,0,DipoleBSweepTime)

% Quadrupole.linear(DipoleEndBGrad,0,DipoleBSweepTime,'end')

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
RFFreq.setfreqsweep(Evap2HighFreq,Evap2LowFreq,0,Evap2SweepTime)
RFFreq.setfreq(Evap2LowFreq,Evap2SweepTime,'end')
