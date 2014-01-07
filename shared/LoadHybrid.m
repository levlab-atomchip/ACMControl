%Loads Hybrid Trap

%% Digital
ex.LoadHybrid.ZShutters.ss('closed',0,'end')

ex.LoadHybrid.MOTRepumper.ss('off',0,'end')
ex.LoadHybrid.MOTRShutter.ss('closed',0,'end')

ex.LoadHybrid.MOTPower.ss('closed',0,'end')

ex.LoadHybrid.ZSAOM.ss('off',0,'end')

ex.LoadHybrid.CameraTrigger.ss('off',0,'end')
ex.LoadHybrid.BeatNoteLock.ss('on',0,'end')
ex.LoadHybrid.Uniblitz.ss('closed',0,'end')

ex.LoadHybrid.IMG1Shutter.ss('closed',0,'end')
ex.LoadHybrid.IMGAOM.ss('off',0,'end')
ex.LoadHybrid.IMG2Shutter.ss('closed',0,'end')
ex.LoadHybrid.CameraShutter.ss('closed',0,'end')

ex.LoadHybrid.ODTAOM.ss('on',0,'end')
ex.LoadHybrid.ODTVVA.ss(MaxODTPwr,0,'end')


ex.LoadHybrid.RFSwitch.ss('off',0,'end')

ex.LoadHybrid.SigPlusShutter.ss('closed',0,'end')
% ex.LoadHybrid.SigPlusShutter.ss('open',0,'end')
ex.LoadHybrid.SigMinusShutter.ss('closed',0,'end')

ex.LoadHybrid.ACRShutter.ss('closed',0,'end')

ex.LoadHybrid.PumpAOM.ss('off',0,'end')
ex.LoadHybrid.Indicator.ss('off',0,'end')
ex.LoadHybrid.MagellanCameraTrigger.ss('off',0,'end')
ex.LoadHybrid.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.LoadHybrid.SoloistTrigger.ss('off',0,'end')
ex.LoadHybrid.MagellanRepumper.ss('off',0,'end')

ex.LoadHybrid.ODTIMGShutter.ss('off',0,'end')

%% Coils
ex.LoadHybrid.XBias.ss(XHybrid,0,PURIFYTIME)
ex.LoadHybrid.XBias.linear(XHybrid,XHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
ex.LoadHybrid.XBias.ss(XHybridMax,(PURIFYTIME + HybridSweepTime),'end')

ex.LoadHybrid.YBias.ss(YHybrid,0,PURIFYTIME)
ex.LoadHybrid.YBias.linear(YHybrid,YHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
ex.LoadHybrid.YBias.ss(YHybridMax,(PURIFYTIME + HybridSweepTime),'end')

ex.LoadHybrid.ZBias.ss(ZHybrid,0,PURIFYTIME)
ex.LoadHybrid.ZBias.linear(ZHybrid,ZHybridMax,PURIFYTIME,(PURIFYTIME + HybridSweepTime))
ex.LoadHybrid.ZBias.ss(ZHybridMax,(PURIFYTIME + HybridSweepTime),'end')

ex.LoadHybrid.Quadrupole.ss(HybridMaxBGrad,0,'end')
ex.LoadHybrid.Quadrupole.erf(0,HybridStartBGrad,0,PURIFYERFTIME,PURIFYOFFSET)
ex.LoadHybrid.Quadrupole.ss(HybridStartBGrad,(PURIFYERFTIME-PURIFYOFFSET),PURIFYTIME)
ex.LoadHybrid.Quadrupole.linear(HybridStartBGrad,HybridMaxBGrad,PURIFYTIME,(PURIFYTIME+HybridSweepTime))


ex.LoadHybrid.MOTRVVA.ss(0,0,'end')
ex.LoadHybrid.ImagingVVA.ss(0,0,'end')

ex.LoadHybrid.RFVVA.ss(0,0,'end')

ex.LoadHybrid.MagellanImgCoil.ss(0,0,'end')
ex.LoadHybrid.MacroDimpleVoltage.ss(0,0,'end')
ex.LoadHybrid.MagellanXCoil.ss(0,0,'end')
ex.LoadHybrid.MagellanCompressCoil.ss(0,0,'end')
ex.LoadHybrid.MagellanZCoil.ss(0,0,'end')
ex.LoadHybrid.MagellanZTrigger.ss(0,0,'end')
ex.LoadHybrid.BiasMacroVoltage.ss(0,0,'end')
ex.LoadHybrid.CentralMacroVoltage.ss(10,0,'end')
ex.LoadHybrid.AxialMacroVoltage.ss(0,0,'end')
ex.LoadHybrid.ArmsMicroVoltage.ss(0,0,'end')
ex.LoadHybrid.DimpleMicroVoltage.ss(0,0,'end')
ex.LoadHybrid.CentralMicroVoltage.ss(0,0,'end')

%% DDS
if OPTPUMP
    ex.LoadHybrid.BeatNoteFreq.setfreqsweep(pumpFreq,ImageFreq,0,2e-3)
elseif SUBDOP
    ex.LoadHybrid.BeatNoteFreq.setfreqsweep(SubDopFreq,ImageFreq,0,2e-3)
else
    ex.LoadHybrid.BeatNoteFreq.setfreqsweep(MOTFreq,ImageFreq,0,2e-3)
end

ex.LoadHybrid.BeatNoteFreq.setfreq(ImageFreq,2e-3,'end')
ex.LoadHybrid.RFFreq.setfreq(Evap1HighFreq,0,'end')

ex.LoadHybrid.Indicator.ss('on',0,dt)
