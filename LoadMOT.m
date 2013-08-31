%Loads the MOT

%% Digital
ex.LoadMOT.ZShutters.ss('open',0,'end')

ex.LoadMOT.MOTRepumper.ss('on',0,'end')
ex.LoadMOT.MOTRShutter.ss('open',0,'end')

ex.LoadMOT.MOTPower.ss('open',0,'end')

ex.LoadMOT.ZSAOM.ss('on',0,'end')

ex.LoadMOT.CameraTrigger.ss('off',0,'end')
ex.LoadMOT.BeatNoteLock.ss('on',0,'end')
ex.LoadMOT.Uniblitz.ss('open',0,'end')

ex.LoadMOT.IMG1Shutter.ss('closed',0,'end')
ex.LoadMOT.IMGAOM.ss('off',0,'end')
ex.LoadMOT.IMG2Shutter.ss('closed',0,'end')
ex.LoadMOT.CameraShutter.ss('closed',0,'end')

ex.LoadMOT.ODTAOM.ss('off',0,'end')


ex.LoadMOT.RFSwitch.ss('off',0,'end')

ex.LoadMOT.SigPlusShutter.ss('closed',0,'end')
ex.LoadMOT.SigMinusShutter.ss('closed',0,'end')
ex.LoadMOT.ACRShutter.ss('closed',0,'end')

ex.LoadMOT.PumpAOM.ss('off',0,'end')
ex.LoadMOT.Indicator.ss('off',0,'end')
ex.LoadMOT.MagellanCameraTrigger.ss('off',0,'end')
ex.LoadMOT.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.LoadMOT.SoloistTrigger.ss('off',0,'end')
ex.LoadMOT.MagellanRepumper.ss('off',0,'end')

ex.LoadMOT.ODTIMGShutter.ss('off',0,'end')

%% Coils
ex.LoadMOT.XBias.ss(XLoad,0,'end')
ex.LoadMOT.YBias.ss(YLoad,0,'end')
ex.LoadMOT.ZBias.ss(ZLoad,0,'end')
ex.LoadMOT.Quadrupole.ss(QuadSet,0,'end')
ex.LoadMOT.Quadrupole.ss(0,LoadTime-MOTQuadOffDelay,'end')
ex.LoadMOT.MOTRVVA.ss(MOTRVVALoadMOT,0,'end')
ex.LoadMOT.ImagingVVA.ss(0,0,'end')

ex.LoadMOT.ODTVVA.ss(0,0,'end')


ex.LoadMOT.RFVVA.ss(0,0,'end')

ex.LoadMOT.MagellanImgCoil.ss(0,0,'end')
ex.LoadMOT.MacroDimpleVoltage.ss(0,0,'end')
ex.LoadMOT.MagellanXCoil.ss(0,0,'end')
ex.LoadMOT.MagellanCompressCoil.ss(0,0,'end')
ex.LoadMOT.MagellanZCoil.ss(0,0,'end')
ex.LoadMOT.MagellanZTrigger.ss(0,0,'end')
ex.LoadMOT.BiasMacroVoltage.ss(0,0,'end')
ex.LoadMOT.CentralMacroVoltage.ss(10,0,'end')
ex.LoadMOT.AxialMacroVoltage.ss(0,0,'end')
ex.LoadMOT.ArmsMicroVoltage.ss(0,0,'end')
ex.LoadMOT.DimpleMicroVoltage.ss(0,0,'end')
ex.LoadMOT.CentralMicroVoltage.ss(0,0,'end')

%% DDS
% ex.LoadMOT.BeatNoteFreq.noreset(0)
ex.LoadMOT.BeatNoteFreq.reset(0)
ex.LoadMOT.BeatNoteFreq.setfreq(MOTFreq,500e-6,'end')
ex.LoadMOT.RFFreq.reset(0)
ex.LoadMOT.RFFreq.setfreq(Evap1HighFreq,1e-3,'end')


% ex.LoadMOT.ODTAOM.ss('on',0,'end')
% ex.LoadMOT.ODTVVA.ss(10,0,'end')
