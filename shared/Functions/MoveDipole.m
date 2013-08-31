%Loads MoveDipole

%% Digital
ex.MoveDipole.ZShutters.ss('closed',0,'end')

ex.MoveDipole.MOTRepumper.ss('off',0,'end')
ex.MoveDipole.MOTRShutter.ss('closed',0,'end')

ex.MoveDipole.MOTPower.ss('closed',0,'end')

ex.MoveDipole.ZSAOM.ss('off',0,'end')

ex.MoveDipole.CameraTrigger.ss('off',0,'end')
ex.MoveDipole.BeatNoteLock.ss('on',0,'end')
ex.MoveDipole.Uniblitz.ss('closed',0,'end')

ex.MoveDipole.IMG1Shutter.ss('closed',0,'end')
ex.MoveDipole.IMGAOM.ss('off',0,'end')
ex.MoveDipole.IMG2Shutter.ss('closed',0,'end')
ex.MoveDipole.CameraShutter.ss('closed',0,'end')

ex.MoveDipole.ODTAOM.ss('on',0,'end')
ex.MoveDipole.ODTVVA.ss(MaxODTPwr,0,'end')


ex.MoveDipole.RFSwitch.ss('off',0,'end')


ex.MoveDipole.SigPlusShutter.ss('closed',0,'end')
ex.MoveDipole.SigMinusShutter.ss('closed',0,'end')

ex.MoveDipole.ACRShutter.ss('closed',0,'end')

ex.MoveDipole.PumpAOM.ss('off',0,'end')
ex.MoveDipole.Indicator.ss('off',0,'end')
ex.MoveDipole.MagellanCameraTrigger.ss('off',0,'end')
ex.MoveDipole.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.MoveDipole.MagellanRepumper.ss('off',0,'end')

ex.MoveDipole.SoloistTrigger.ss('off',0,'end')
ex.MoveDipole.SoloistTrigger.ss('on',0,5e-3)
if IMAGING == 2
    ex.MoveDipole.SoloistTrigger.ss('on',TransitTime+MoveHoldTime,TransitTime+MoveHoldTime+10e-3)
end


%% Coils
ex.MoveDipole.XBias.ss(0,0,'end')
ex.MoveDipole.YBias.ss(0,0,'end')
ex.MoveDipole.ZBias.ss(0,0,'end')

ex.MoveDipole.Quadrupole.ss(0,0,'end')


ex.MoveDipole.MOTRVVA.ss(0,0,'end')
ex.MoveDipole.ImagingVVA.ss(0,0,'end')

ex.MoveDipole.RFVVA.ss(0,0,'end')

ex.MoveDipole.MagellanImgCoil.ss(0,0,'end')
ex.MoveDipole.MacroDimpleVoltage.ss(0,0,'end')
ex.MoveDipole.MagellanXCoil.ss(MagXMoveDipole,0,'end')
ex.MoveDipole.MagellanCompressCoil.ss(0,0,'end')
ex.MoveDipole.MagellanZCoil.ss(0,0,'end')
ex.MoveDipole.MagellanZTrigger.ss(0,0,'end')
ex.MoveDipole.BiasMacroVoltage.ss(0,0,'end')
ex.MoveDipole.CentralMacroVoltage.ss(10,0,'end')
ex.MoveDipole.AxialMacroVoltage.ss(0,0,'end')
ex.MoveDipole.ArmsMicroVoltage.ss(0,0,'end')
ex.MoveDipole.DimpleMicroVoltage.ss(0,0,'end')
ex.MoveDipole.CentralMicroVoltage.ss(0,0,'end')

%% DDS
ex.MoveDipole.BeatNoteFreq.setfreq(ImageFreq,0,'end')
ex.MoveDipole.RFFreq.setfreq(Evap2LowFreq,0,'end')
