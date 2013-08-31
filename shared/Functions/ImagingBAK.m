%Loads Imaging
% NOT DONE YET

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
IMGAOM.ss(0,0,'end')
IMG2Shutter.ss('closed',0,'end')
CameraShutter.ss('closed',0,'end')

ODTAOM.ss(0,0,'end')
ODTVVA.ss(0,0,'end')


RFSwitch.ss('off',0,'end')


SigPlusShutter.ss('closed',0,'end')
SigMinusShutter.ss('closed',0,'end')

ACRShutter.ss('closed',0,'end')
MOTRVVA.ss(0,0,'end')
ImagingVVA.ss(0,0,'end')


PumpAOM.ss('off',0,'end')
Indicator.ss('off',0,'end')
MagellanCameraTrigger.ss('off',0,'end')
MagellanVerticalIMGShutter.ss('off',0,'end')
SoloistTrigger.ss('off',0,'end')
MagellanRepumper.ss('off',0,'end')

%% Imaging Light
atomImage = TOFs(tof);
lightImage = atomImage + WaitTime;
darkImage = lightImage + WaitTime;

dummyImage1 = atomImage - DummyTime;
dummyImage2 = lightImage - DummyTime;
dummyImage3 = darkImage - DummyTime;
switch IMAGING
    case 2
        CameraShutter.ss('open',atomImage,atomImage+100e-3)
        CameraShutter.ss('open',lightImage,lightImage+100e-3)
        CameraShutter.ss('open',darkImage,'end')
        
        IMG2Shutter.ss('open',atomImage,atomImage+100e-3)
        IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)
        
        IMG2Shutter.ss('open',lightImage,lightImage+100e-3)
        IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime)
        
        ACRShutter.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
        MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)
        
        ACRShutter.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
        MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime)
        
        CameraTrigger.ss('on', atomImage, atomImage+100e-6)
        CameraTrigger.ss('on', lightImage, lightImage+100e-6)
        CameraTrigger.ss('on', darkImage, darkImage+100e-6)
%         CameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         CameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         CameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
        
    case 3
        MagellanVerticalIMGShutter.ss('open', atomImage,atomImage+100e-3)
        IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)  
        
        MagellanVerticalIMGShutter.ss('open', lightImage,lightImage+100e-3)
        IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime) 
        
        MagellanRepumper.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
        MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)
        
        MagellanRepumper.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
        MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime)
        
        MagellanCameraTrigger.ss('on', atomImage, atomImage+100e-6)
        MagellanCameraTrigger.ss('on', lightImage, lightImage+100e-6)
        MagellanCameraTrigger.ss('on', darkImage, darkImage+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
    case 4
        IMG1Shutter.ss('open', atomImage,atomImage+100e-3)
        IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)  
        
        IMG1Shutter.ss('open', lightImage,lightImage+100e-3)
        IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime)
        
        MagellanRepumper.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
        MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)   
        
        MagellanRepumper.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
        MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
        MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime) 
        
        MagellanCameraTrigger.ss('on', atomImage, atomImage+100e-6)
        MagellanCameraTrigger.ss('on', lightImage, lightImage+100e-6)
        MagellanCameraTrigger.ss('on', darkImage, darkImage+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         MagellanCameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
end

%% Coils
if IMAGING == 2
    XBias.ss(XBias,0,'end')
    YBias.ss(YBias,0,'end')
    ZBias.ss(ZBias,0,'end')
    
    MagellanXCoil.ss(0,0,'end')
    MagellanImgCoil.ss(0,0,'end')
    MagellanZCoil.ss(0,0,'end')
else
    XBias.ss(0,0,'end')
    YBias.ss(0,0,'end')
    ZBias.ss(0,0,'end')
    
    MagellanXCoil.ss(XBias,0,'end')
    MagellanImgCoil.ss(YBias,0,'end')
    MagellanZCoil.ss(ZBias,0,'end')
end
Quadrupole.ss(0,0,'end')

DimpleMacroVoltage.ss(0,0,'end')
MagellanImgTrigger.ss(0,0,'end')
MagellanXTrigger.ss(0,0,'end')
MagellanZTrigger.ss(0,0,'end')
BiasMacroVoltage.ss(0,0,'end')
CentralMacroVoltage.ss(10,0,'end')
AxialMacroVoltage.ss(0,0,'end')
ArmsMicroVoltage.ss(0,0,'end')
DimpleMicroVoltage.ss(0,0,'end')
CentralMicroVoltage.ss(0,0,'end')

%% DDS
BeatNoteFreq.setfreq(ImageFreq,0,'end')
if DIPOLE
    RFFreq.setfreq(Evap2LowFreq,0,'end')
elseif RFEVAP
    if TwoSlopeEvap
        RFFreq.setfreq(Evap3LowFreq,0,'end')
    end
    if ThreeSlopeEvap
        RFFreq.setfreq(Evap4LowFreq,0,'end')
    end
else
    RFFreq.setfreq(Evap1HighFreq,0,'end')
end

RFFreq.setfreq(Evap2LowFreq, 10e-3,'end')
    
if ~HYBRID
    BeatNoteFreq.setfreqsweep(pumpFreq,ImageFreq,0,ImageSweepTime)
end
if ~OPTPUMP
    BeatNoteFreq.setfreqsweep(SubDopFreq,ImageFreq,0,ImageSweepTime)
end
if ~SUBDOP
    BeatNoteFreq.setfreqsweep(MOTFreq,ImageFreq,0,ImageSweepTime)
end

% IMG2Shutter.ss('open',0,'end')
% CameraShutter.ss('open',0,'end')
% IMGAOM.ss('on',0,'end')
% ImagingVVA.ss(10,0,'end')
Indicator.ss('on',lightImage,lightImage+dt)