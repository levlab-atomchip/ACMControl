%Subdoppler Cooling

%% Digital
ex.SubDop.ZShutters.ss('closed',0,'end')

ex.SubDop.MOTRepumper.ss('on',0,'end')
ex.SubDop.MOTRShutter.ss('open',0,'end')

ex.SubDop.MOTPower.ss('open',0,'end')

ex.SubDop.ZSAOM.ss('off',0,'end')

ex.SubDop.CameraTrigger.ss('off',0,'end')
ex.SubDop.BeatNoteLock.ss('on',0,'end')
ex.SubDop.Uniblitz.ss('closed',0,'end')

ex.SubDop.IMG1Shutter.ss('closed',0,'end')
ex.SubDop.IMGAOM.ss('off',0,'end')
ex.SubDop.IMG2Shutter.ss('closed',0,'end')
ex.SubDop.CameraShutter.ss('closed',0,'end')

ex.SubDop.ODTAOM.ss('off',0,'end')
ex.SubDop.RFSwitch.ss('off',0,'end')


ex.SubDop.SigPlusShutter.ss('closed',0,'end')
ex.SubDop.SigMinusShutter.ss('closed',0,'end')

ex.SubDop.ACRShutter.ss('closed',0,'end')

ex.SubDop.PumpAOM.ss('off',0,'end')
ex.SubDop.Indicator.ss('off',0,'end')
ex.SubDop.MagellanCameraTrigger.ss('off',0,'end')
ex.SubDop.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.SubDop.SoloistTrigger.ss('off',0,'end')
ex.SubDop.MagellanRepumper.ss('off',0,'end')

ex.SubDop.ODTIMGShutter.ss('off',0,'end')

%% Coils
ex.SubDop.XBias.ss(ZeroXBias,0,'end')
ex.SubDop.YBias.ss(ZeroYBias,0,'end')
ex.SubDop.ZBias.ss(ZeroZBias,0,'end')
ex.SubDop.Quadrupole.ss(0,0,'end')

ex.SubDop.MOTRVVA.ss(MOTRVVASub,0,'end')
ex.SubDop.ImagingVVA.ss(0,0,'end')
ex.SubDop.ODTVVA.ss(0,0,'end')
ex.SubDop.RFVVA.ss(0,0,'end')

ex.SubDop.MagellanImgCoil.ss(0,0,'end')
ex.SubDop.MacroDimpleVoltage.ss(0,0,'end')
ex.SubDop.MagellanXCoil.ss(0,0,'end')
ex.SubDop.MagellanCompressCoil.ss(0,0,'end')
ex.SubDop.MagellanZCoil.ss(0,0,'end')
ex.SubDop.MagellanZTrigger.ss(0,0,'end')
ex.SubDop.BiasMacroVoltage.ss(0,0,'end')
ex.SubDop.CentralMacroVoltage.ss(10,0,'end')
ex.SubDop.AxialMacroVoltage.ss(0,0,'end')
ex.SubDop.ArmsMicroVoltage.ss(0,0,'end')
ex.SubDop.DimpleMicroVoltage.ss(0,0,'end')
ex.SubDop.CentralMicroVoltage.ss(0,0,'end')

%% DDS
ex.SubDop.BeatNoteFreq.setfreqsweep(MOTFreq,SubDopFreq,0,'end')
ex.SubDop.RFFreq.setfreq(Evap1HighFreq,0,'end')

% disp('ODT on in subdop')
% ex.SubDop.ODTAOM.ss('on',0,'end')
% ex.SubDop.ODTVVA.ss(10,0,'end')

% ex.SubDop.Indicator.ss('on',0,dt)
