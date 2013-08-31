%Loads Imaging


%% Digital
nex.Imaging.ZShutters.ss('closed',0,'end')

nex.Imaging.MOTRepumper.ss('off',0,'end')
nex.Imaging.MOTRShutter.ss('closed',0,'end')

nex.Imaging.MOTPower.ss('closed',0,'end')

nex.Imaging.ZSAOM.ss('off',0,'end')

nex.Imaging.CameraTrigger.ss('off',0,'end')
nex.Imaging.BeatNoteLock.ss('on',0,'end')
nex.Imaging.Uniblitz.ss('closed',0,'end')

nex.Imaging.IMG1Shutter.ss('closed',0,'end')
nex.Imaging.IMGAOM.ss(0,0,'end')
nex.Imaging.IMG2Shutter.ss('closed',0,'end')
nex.Imaging.CameraShutter.ss('closed',0,'end')

nex.Imaging.ODTAOM.ss('off',0,'end')
nex.Imaging.ODTVVA.ss(0,0,'end')

% disp('ODT On In Imaging')
% nex.Imaging.ODTAOM.ss('on',0,'end')
% nex.Imaging.ODTVVA.ss(10,0,'end')


nex.Imaging.RFSwitch.ss('off',0,'end')


nex.Imaging.SigPlusShutter.ss('closed',0,'end')
nex.Imaging.SigMinusShutter.ss('closed',0,'end')

nex.Imaging.ACRShutter.ss('closed',0,'end')
nex.Imaging.MOTRVVA.ss(0,0,'end')
nex.Imaging.ImagingVVA.ss(0,0,'end')


nex.Imaging.PumpAOM.ss('off',0,'end')
nex.Imaging.Indicator.ss('off',0,'end')
nex.Imaging.MagellanCameraTrigger.ss('off',0,'end')
nex.Imaging.MagellanVerticalIMGShutter.ss('off',0,'end')
nex.Imaging.SoloistTrigger.ss('off',0,'end')
nex.Imaging.MagellanRepumper.ss('off',0,'end')

nex.Imaging.ODTIMGShutter.ss('off',0,'end')



%% Imaging Light
atomImage = TOFs(tof);
lightImage = atomImage + WaitTime;
darkImage = lightImage + WaitTime;

dummyImage1 = atomImage - DummyTime;
dummyImage2 = lightImage - DummyTime;
dummyImage3 = darkImage - DummyTime;

if MOVEDIPOLE && IMAGING ~= 2
    nex.Imaging.SoloistTrigger.ss('on',darkImage,'end')
end

switch IMAGING
    case 2
        nex.Imaging.CameraShutter.ss('open',atomImage,atomImage+100e-3)
        nex.Imaging.CameraShutter.ss('open',lightImage,lightImage+100e-3)
        nex.Imaging.CameraShutter.ss('open',darkImage,'end')
        
        nex.Imaging.IMG2Shutter.ss('open',atomImage,atomImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)
        
        nex.Imaging.IMG2Shutter.ss('open',lightImage,lightImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime)
        
        nex.Imaging.ACRShutter.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
        nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
        nex.Imaging.MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)
        
        nex.Imaging.ACRShutter.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
        nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
        nex.Imaging.MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime)
        
        nex.Imaging.CameraTrigger.ss('off',0,'end')
        nex.Imaging.CameraTrigger.pulse('on', atomImage, cameraPulse)
        nex.Imaging.CameraTrigger.pulse('on', lightImage, cameraPulse)
        nex.Imaging.CameraTrigger.pulse('on', darkImage, cameraPulse)
%         nex.Imaging.CameraTrigger.ss('on', atomImage, atomImage+100e-6)
%         nex.Imaging.CameraTrigger.ss('on', lightImage, lightImage+100e-6)
%         nex.Imaging.CameraTrigger.ss('on', darkImage, darkImage+100e-6)
%         nex.Imaging.CameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         nex.Imaging.CameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         nex.Imaging.CameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
        
    case 3
        nex.Imaging.MagellanVerticalIMGShutter.ss('open', atomImage,atomImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)  
        nex.Imaging.ODTIMGShutter.ss('on',atomImage,atomImage+100e-3)
        
        nex.Imaging.MagellanVerticalIMGShutter.ss('open', lightImage,lightImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime) 
        nex.Imaging.ODTIMGShutter.ss('on',lightImage,lightImage+100e-3)
        
        nex.Imaging.MagellanRepumper.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
        nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
        nex.Imaging.MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)
        
        nex.Imaging.MagellanRepumper.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
        nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
        nex.Imaging.MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime)
        
        nex.Imaging.MagellanCameraTrigger.ss('on', atomImage, atomImage+100e-6)
        nex.Imaging.MagellanCameraTrigger.ss('on', lightImage, lightImage+100e-6)
        nex.Imaging.MagellanCameraTrigger.ss('on', darkImage, darkImage+100e-6)
        nex.Imaging.ODTIMGShutter.ss('on',darkImage,darkImage+100e-6)
        
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
    case 4
        nex.Imaging.IMG1Shutter.ss('open', atomImage,atomImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',atomImage,atomImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,atomImage,atomImage+ExposeTime)  
        
        nex.Imaging.IMG1Shutter.ss('open', lightImage,lightImage+100e-3)
        nex.Imaging.IMGAOM.ss('on',lightImage,lightImage+ExposeTime)
        nex.Imaging.ImagingVVA.ss(ImagingVVA,lightImage,lightImage+ExposeTime)
        
%         nex.Imaging.MagellanRepumper.ss('open',atomImage-REPUMPTIME,atomImage+100e-3)
%         nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,atomImage-REPUMPTIME,atomImage+ExposeTime)
%         nex.Imaging.MOTRepumper.ss('on',atomImage-REPUMPTIME,atomImage+ExposeTime)   
        
%         nex.Imaging.MagellanRepumper.ss('open',lightImage-REPUMPTIME,lightImage+100e-3)
%         nex.Imaging.MOTRVVA.ss(ImgRepumpVVA,lightImage-REPUMPTIME,lightImage+ExposeTime)
%         nex.Imaging.MOTRepumper.ss('on',lightImage-REPUMPTIME,lightImage+ExposeTime) 
%         
        
        nex.Imaging.MagellanCameraTrigger.ss('off',0,'end')
        nex.Imaging.MagellanCameraTrigger.pulse('on', atomImage, cameraPulse)
        nex.Imaging.MagellanCameraTrigger.pulse('on', lightImage, cameraPulse)
        nex.Imaging.MagellanCameraTrigger.pulse('on', darkImage, cameraPulse)
%         nex.Imaging.MagellanCameraTrigger.ss('on', atomImage, atomImage+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', lightImage, lightImage+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', darkImage, darkImage+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage1, dummyImage1+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage2, dummyImage2+100e-6)
%         nex.Imaging.MagellanCameraTrigger.ss('on', dummyImage3, dummyImage3+100e-6)
end

%% Coils
if IMAGING == 2
%     nex.Imaging.XBias.ss(XBias,0,'end')
%     nex.Imaging.YBias.ss(YBias,0,'end')
%     nex.Imaging.ZBias.ss(ZBias,0,'end')
    nex.Imaging.XBias.ss(XBias,0,'end')
    nex.Imaging.YBias.ss(YBias,0,'end')
    nex.Imaging.ZBias.ss(ZBias,0,'end')
    nex.Imaging.XBias.ss(XBias,atomImage-.3e-3,'end')
    nex.Imaging.YBias.ss(YBias,atomImage-.3e-3,'end')
    nex.Imaging.ZBias.ss(ZBias,atomImage-.3e-3,'end')
    
    nex.Imaging.MagellanXCoil.ss(0,0,'end')
    nex.Imaging.MagellanImgCoil.ss(0,0,'end')
    nex.Imaging.MagellanZCoil.ss(0,0,'end')
else
    nex.Imaging.XBias.ss(0,0,'end')
    nex.Imaging.YBias.ss(0,0,'end')
    nex.Imaging.ZBias.ss(0,0,'end')
    
%     nex.Imaging.MagellanXCoil.ss(XBias,0,'end')
%     nex.Imaging.MagellanImgCoil.ss(YBias,0,'end')
%     nex.Imaging.MagellanZCoil.ss(ZBias,0,'end')

    nex.Imaging.MagellanXCoil.ss(0,0,'end')
    nex.Imaging.MagellanImgCoil.ss(0,0,'end')
    nex.Imaging.MagellanZCoil.ss(0,0,'end')
    
%     nex.Imaging.MagellanXCoil.ss(XBias,atomImage-.3e-3,'end')
%     nex.Imaging.MagellanImgCoil.ss(YBias,atomImage-.3e-3,'end')
%     nex.Imaging.MagellanZCoil.ss(ZBias,atomImage-.3e-3,'end')
    nex.Imaging.MagellanXCoil.ss(XBias,atomImage-magOnTime,'end')
    nex.Imaging.MagellanImgCoil.ss(YBias,atomImage-magOnTime,'end')
    nex.Imaging.MagellanZCoil.ss(ZBias,atomImage-magOnTime,'end')
end
% nex.Imaging.Quadrupole.ss(0,0,'end')
nex.Imaging.Quadrupole.ss(1,0,'end')

nex.Imaging.BiasMacroVoltage.ss(0,0,'end')
nex.Imaging.BiasMacroVoltage.ss(MacroImgBias,atomImage-magOnTime,'end')

nex.Imaging.RFVVA.ss(0,0,'end')
nex.Imaging.MacroDimpleVoltage.ss(0,0,'end')
nex.Imaging.MagellanCompressCoil.ss(0,0,'end')
nex.Imaging.MagellanZTrigger.ss(0,0,'end')
nex.Imaging.CentralMacroVoltage.ss(10,0,'end')
nex.Imaging.AxialMacroVoltage.ss(0,0,'end')
nex.Imaging.ArmsMicroVoltage.ss(0,0,'end')
nex.Imaging.DimpleMicroVoltage.ss(0,0,'end')
nex.Imaging.CentralMicroVoltage.ss(0,0,'end')

%% DDS
nex.Imaging.BeatNoteFreq.setfreq(ImageFreq,0,'end')
if DIPOLE
    nex.Imaging.RFFreq.setfreq(Evap2LowFreq,0,'end')
elseif RFEVAP
    nex.Imaging.RFFreq.setfreq(Evap2LowFreq,0,10e-3)
    if TwoSlopeEvap
        nex.Imaging.RFFreq.setfreq(Evap3LowFreq,0,'end')
    end
    if ThreeSlopeEvap
        nex.Imaging.RFFreq.setfreq(Evap4LowFreq,0,'end')
    end
else
    nex.Imaging.RFFreq.setfreq(Evap1HighFreq,0,'end')
end

nex.Imaging.RFFreq.setfreq(Evap1HighFreq, 10e-3,'end')
    
% if ~HYBRID
%     nex.Imaging.BeatNoteFreq.setfreqsweep(pumpFreq,ImageFreq,0,ImageSweepTime)
% end
% if ~OPTPUMP
%     nex.Imaging.BeatNoteFreq.setfreqsweep(SubDopFreq,ImageFreq,0,ImageSweepTime)
% end
% if ~SUBDOP
%     nex.Imaging.BeatNoteFreq.setfreqsweep(MOTFreq,ImageFreq,0,ImageSweepTime)
% end

if HYBRID
    nex.Imaging.BeatNoteFreq.setfreq(ImageFreq,0,'end')
elseif OPTPUMP
    nex.Imaging.BeatNoteFreq.setfreqsweep(pumpFreq,ImageFreq,0,ImageSweepTime)
elseif SUBDOP
    nex.Imaging.BeatNoteFreq.setfreqsweep(SubDopFreq,ImageFreq,0,ImageSweepTime)
end

% nex.Imaging.ACRShutter.ss('closed',0,'end')
% nex.Imaging.MOTRepumper.ss('off',0,'end')
% nex.Imaging.MOTRShutter.ss('closed',0,'end')
% disp('REPUMP OFF IN IMG')
% nex.Imaging.ODTAOM.ss('on',0,'end')
% nex.Imaging.Indicator.ss('on',0,dt)
% nex.Imaging.ODTVVA.ss(10,0,'end')
