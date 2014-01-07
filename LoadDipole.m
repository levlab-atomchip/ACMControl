%Loads Dipole Trap

%% Digital
ex.LoadDipole.ZShutters.ss('closed',0,'end')
ex.LoadDipole.MOTRepumper.ss('off',0,'end')
ex.LoadDipole.MOTRShutter.ss('closed',0,'end')
ex.LoadDipole.MOTPower.ss('closed',0,'end')
ex.LoadDipole.ZSAOM.ss('off',0,'end')
ex.LoadDipole.CameraTrigger.ss('off',0,'end')
ex.LoadDipole.BeatNoteLock.ss('on',0,'end')
ex.LoadDipole.Uniblitz.ss('closed',0,'end')
ex.LoadDipole.IMG1Shutter.ss('closed',0,'end')
ex.LoadDipole.IMGAOM.ss('off',0,'end')
ex.LoadDipole.IMG2Shutter.ss('closed',0,'end')
ex.LoadDipole.CameraShutter.ss('closed',0,'end')

ex.LoadDipole.ODTAOM.ss('on',0,'end')
ex.LoadDipole.ODTVVA.ss(MaxODTPwr,0,'end')
ex.LoadDipole.ODTVVA.sinoffset(MaxODTPwr,DipoleParaAmp,DipoleParaFreq,DipoleTime -DipoleLoadHoldTime, 'end')

ex.LoadDipole.RFSwitch.ss('on',0,'end')

ex.LoadDipole.SigPlusShutter.ss('closed',0,'end')
ex.LoadDipole.SigMinusShutter.ss('closed',0,'end')

ex.LoadDipole.ACRShutter.ss('closed',0,'end')
ex.LoadDipole.PumpAOM.ss('off',0,'end')
ex.LoadDipole.Indicator.ss('off',0,'end')
ex.LoadDipole.MagellanCameraTrigger.ss('off',0,'end')
ex.LoadDipole.MagellanVerticalIMGShutter.ss('off',0,'end')
ex.LoadDipole.SoloistTrigger.ss('off',0,'end')
ex.LoadDipole.MagellanRepumper.ss('off',0,'end')

ex.LoadDipole.ODTIMGShutter.ss('off',0,'end')

%% Coils
ex.LoadDipole.XBias.ss(XDipole,0,'end')
ex.LoadDipole.YBias.ss(YDipole,0,'end')
ex.LoadDipole.ZBias.ss(ZDipole,0,'end')

if DipoleBiasSweep
    if ByRates
        ex.LoadDipole.XBias.linear(XRFEvap,XDipole,0,(XDipole-XRFEvap)/XSweepRate)
        ex.LoadDipole.YBias.linear(YRFEvap,YDipole,0,(YDipole-YRFEvap)/YSweepRate)
        ex.LoadDipole.ZBias.linear(ZRFEvap,ZDipole,0,(ZDipole-ZRFEvap)/ZSweepRate)
    else
        ex.LoadDipole.XBias.linear(XRFEvap,XDipole,0,DipoleBSweepTime)
        ex.LoadDipole.YBias.linear(YRFEvap,YDipole,0,DipoleBSweepTime)
        ex.LoadDipole.ZBias.linear(ZRFEvap,ZDipole,0,DipoleBSweepTime)
    end
    if SIGPLUS
        ex.LoadDipole.ZBias.ss(DipoleBiasSweepValues(length(DipoleBiasSweepValues)),0,'end')
        for i = 2:length(DipoleBiasSweepTimes)
            ex.LoadDipole.ZBias.linear(DipoleBiasSweepValues(i-1),DipoleBiasSweepValues(i),DipoleBiasSweepTimes(i-1),DipoleBiasSweepTimes(i))
        end
    end
end

ex.LoadDipole.Quadrupole.ss(DipoleEndBGrad,0,'end')
ex.LoadDipole.Quadrupole.linear(DipoleStartBGrad,DipoleEndBGrad,0,DipoleBSweepTime)

% disp('UNCOMMENT IN LOADDIPOLE')
if ~OPTEVAP
    ex.LoadDipole.Quadrupole.linear(DipoleEndBGrad,0,DipoleBSweepTime,DipoleBOffSweep+DipoleBSweepTime)
    ex.LoadDipole.XBias.linear(XDipole,0,DipoleBSweepTime,DipoleBOffSweep+DipoleBSweepTime)
    ex.LoadDipole.YBias.linear(YDipole,0,DipoleBSweepTime,DipoleBOffSweep+DipoleBSweepTime)
    ex.LoadDipole.ZBias.linear(DipoleBiasSweepValues(end),0,DipoleBSweepTime,DipoleBOffSweep+DipoleBSweepTime)
    ex.LoadDipole.Quadrupole.ss(0,DipoleBOffSweep+DipoleBSweepTime,'end')
    ex.LoadDipole.XBias.ss(0,DipoleBOffSweep+DipoleBSweepTime,'end')
    ex.LoadDipole.YBias.ss(0,DipoleBOffSweep+DipoleBSweepTime,'end')
    ex.LoadDipole.ZBias.ss(0,DipoleBOffSweep+DipoleBSweepTime,'end')
end

ex.LoadDipole.MOTRVVA.ss(0,0,'end')
ex.LoadDipole.ImagingVVA.ss(0,0,'end')

ex.LoadDipole.RFVVA.ss(RFVVASet,0,'end')


ex.LoadDipole.MagellanImgCoil.ss(0,0,'end')
ex.LoadDipole.MacroDimpleVoltage.ss(0,0,'end')
ex.LoadDipole.MagellanXCoil.ss(0,0,'end')
ex.LoadDipole.MagellanCompressCoil.ss(0,0,'end')
ex.LoadDipole.MagellanZCoil.ss(0,0,'end')
ex.LoadDipole.MagellanZTrigger.ss(0,0,'end')
ex.LoadDipole.BiasMacroVoltage.ss(0,0,'end')
ex.LoadDipole.CentralMacroVoltage.ss(10,0,'end')
ex.LoadDipole.AxialMacroVoltage.ss(0,0,'end')
ex.LoadDipole.ArmsMicroVoltage.ss(0,0,'end')
ex.LoadDipole.DimpleMicroVoltage.ss(0,0,'end')
ex.LoadDipole.CentralMicroVoltage.ss(0,0,'end')

%% DDS
ex.LoadDipole.BeatNoteFreq.setfreq(ImageFreq,0,'end')
ex.LoadDipole.RFFreq.setfreqsweep(Evap2HighFreq,Evap2LowFreq,0,Evap2SweepTime)
ex.LoadDipole.RFFreq.setfreq(Evap2LowFreq,Evap2SweepTime,'end')
