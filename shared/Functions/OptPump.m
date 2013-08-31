%Optical Pumping

%% Digital
ex.OptPump.ZShutters.ss('closed',0,'end')

if SIGPLUS
    ex.OptPump.MOTRepumper.ss('on',0,'end')
    ex.OptPump.MOTRShutter.ss('open',0,'end')
    ex.OptPump.MOTRVVA.ss(MOTRVVApump,0,'end')
else
    ex.OptPump.MOTRepumper.ss('on',0,'end')
    ex.OptPump.MOTRepumper.ss('off',MINUSREPUMPTIME,'end')
    ex.OptPump.MOTRShutter.ss('open',0,'end')
    ex.OptPump.MOTRShutter.ss('off',MINUSREPUMPTIME,'end')
    ex.OptPump.MOTRVVA.ss(MOTRVVApump,0,'end')
end


ex.OptPump.MOTPower.ss('closed',0,'end')

ex.OptPump.ZSAOM.ss('off',0,'end')

ex.OptPump.CameraTrigger.ss('off',0,'end')
ex.OptPump.BeatNoteLock.ss('on',0,'end')
ex.OptPump.Uniblitz.ss('closed',0,'end')

ex.OptPump.IMG1Shutter.ss('closed',0,'end')
ex.OptPump.IMGAOM.ss('off',0,'end')
ex.OptPump.IMG2Shutter.ss('closed',0,'end')
ex.OptPump.CameraShutter.ss('closed',0,'end')

ex.OptPump.ODTAOM.ss('off',0,'end')

ex.OptPump.RFSwitch.ss('off',0,'end')

ex.OptPump.PumpAOM.ss('off',0,PumpSweepTime)
ex.OptPump.PumpAOM.ss('on',PumpSweepTime,'end')
ex.OptPump.ImagingVVA.ss(0,0,PumpSweepTime)
ex.OptPump.ImagingVVA.ss(pumpVVA,PumpSweepTime,'end')


if SIGPLUS
    ex.OptPump.SigPlusShutter.ss('closed',0,PumpSweepTime)
    ex.OptPump.SigPlusShutter.ss('open',PumpSweepTime,'end')
    ex.OptPump.SigMinusShutter.ss('closed',0,'end')

else
    ex.OptPump.SigMinusShutter.ss('closed',0,PumpSweepTime)
    ex.OptPump.SigMinusShutter.ss('open',PumpSweepTime,'end')
    ex.OptPump.SigPlusShutter.ss('closed',0,'end')
end

ex.OptPump.ACRShutter.ss('closed',0,'end')


ex.OptPump.Indicator.ss('off',0,'end')
ex.OptPump.MagellanCameraTrigger.ss('off',0,'end')
ex.OptPump.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.OptPump.SoloistTrigger.ss('off',0,'end')
ex.OptPump.MagellanRepumper.ss('off',0,'end')

%% Coils
ex.OptPump.XBias.ss(XPump,0,'end')
ex.OptPump.YBias.ss(YPump,0,'end')
ex.OptPump.ZBias.ss(ZPump,0,'end')
ex.OptPump.Quadrupole.ss(0,0,'end')
ex.OptPump.ODTVVA.ss(0,0,'end')
ex.OptPump.RFVVA.ss(0,0,'end')

ex.OptPump.MagellanImgCoil.ss(0,0,'end')
ex.OptPump.MacroDimpleVoltage.ss(0,0,'end')
ex.OptPump.MagellanXCoil.ss(0,0,'end')
ex.OptPump.MagellanCompressCoil.ss(0,0,'end')
ex.OptPump.MagellanZCoil.ss(0,0,'end')
ex.OptPump.MagellanZTrigger.ss(0,0,'end')
ex.OptPump.BiasMacroVoltage.ss(0,0,'end')
ex.OptPump.CentralMacroVoltage.ss(10,0,'end')
ex.OptPump.AxialMacroVoltage.ss(0,0,'end')
ex.OptPump.ArmsMicroVoltage.ss(0,0,'end')
ex.OptPump.DimpleMicroVoltage.ss(0,0,'end')
ex.OptPump.CentralMicroVoltage.ss(0,0,'end')

ex.OptPump.ODTIMGShutter.ss('off',0,'end')

%% DDS
ex.OptPump.BeatNoteFreq.setfreqsweep(SubDopFreq,pumpFreq,0,PumpSweepTime)
ex.OptPump.BeatNoteFreq.setfreq(pumpFreq,PumpSweepTime,'end')
ex.OptPump.RFFreq.setfreq(Evap1HighFreq,0,'end')
% 
% ex.OptPump.SigMinusShutter.ss('closed',0,'end')
% ex.OptPump.SigPlusShutter.ss('closed',0,'end')
% ex.OptPump.MOTRShutter.ss('closed',0,'end')
