%Loads the off sub block

%% Digital
nex.Reset.ZShutters.ss('closed',0,'end')

nex.Reset.MOTRepumper.ss('off',0,'end')
nex.Reset.MOTRShutter.ss('closed',0,'end')

nex.Reset.MOTPower.ss('closed',0,'end')

nex.Reset.ZSAOM.ss('off',0,'end')

nex.Reset.CameraTrigger.ss('off',0,'end')
nex.Reset.BeatNoteLock.ss('on',0,'end')
nex.Reset.Uniblitz.ss('closed',0,'end')

nex.Reset.IMG1Shutter.ss('closed',0,'end')
nex.Reset.IMGAOM.ss('off',0,'end')
nex.Reset.IMG2Shutter.ss('closed',0,'end')
nex.Reset.CameraShutter.ss('closed',0,'end')

nex.Reset.ODTAOM.ss('off',0,'end')

nex.Reset.RFSwitch.ss('off',0,'end')

nex.Reset.SigPlusShutter.ss('closed',0,'end')
nex.Reset.SigMinusShutter.ss('closed',0,'end')
nex.Reset.ACRShutter.ss('closed',0,'end')

nex.Reset.PumpAOM.ss('off',0,'end')
nex.Reset.Indicator.ss('off',0,'end')
nex.Reset.MagellanCameraTrigger.ss('off',0,'end')
nex.Reset.MagellanVerticalIMGShutter.ss('off',0,'end')
nex.Reset.SoloistTrigger.ss('off',0,'end')
nex.Reset.MagellanRepumper.ss('off',0,'end')

nex.Reset.ODTIMGShutter.ss('off',0,'end')

%% Coils
nex.Reset.XBias.ss(0,0,'end')
nex.Reset.YBias.ss(0,0,'end')
nex.Reset.ZBias.ss(0,0,'end')
nex.Reset.Quadrupole.ss(0,0,'end')
nex.Reset.MOTRVVA.ss(0,0,'end')
nex.Reset.ImagingVVA.ss(0,0,'end')
nex.Reset.ODTVVA.ss(0,0,'end')
nex.Reset.RFVVA.ss(0,0,'end')

nex.Reset.MagellanImgCoil.ss(0,0,'end')
nex.Reset.MacroDimpleVoltage.ss(0,0,'end')
nex.Reset.MagellanXCoil.ss(0,0,'end')
nex.Reset.MagellanCompressCoil.ss(0,0,'end')
nex.Reset.MagellanZCoil.ss(0,0,'end')
nex.Reset.MagellanZTrigger.ss(0,0,'end')
nex.Reset.BiasMacroVoltage.ss(0,0,'end')
nex.Reset.CentralMacroVoltage.ss(10,0,'end')
nex.Reset.AxialMacroVoltage.ss(0,0,'end')
nex.Reset.ArmsMicroVoltage.ss(0,0,'end')
nex.Reset.DimpleMicroVoltage.ss(0,0,'end')
nex.Reset.CentralMicroVoltage.ss(0,0,'end')

%% DDS
nex.Reset.BeatNoteFreq.setfreqsweep(ImageFreq,MOTFreq,0,2e-3)
nex.Reset.BeatNoteFreq.setfreq(MOTFreq,2e-3,'end')
nex.Reset.RFFreq.setfreq(Evap1HighFreq,0,'end')


