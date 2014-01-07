% Dependent Variables
<<<<<<< HEAD

MOTTime = UniblitzTime + LoadTime;
% MacroCompressTime = MacroCompRampTime + MacCompHoldTime;
MicroCaptureTime = MicroCapHoldTime + MicroCapRFSweepTime + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);
=======
%% Dipole
if ByRates
    if maxVal > DipoleSweepTime
        DipoleTime = DipoleLoadHoldTime + maxVal;
    else
        DipoleTime = DipoleLoadHoldTime+DipoleBSweepTime;
    end
else
    DipoleTime = DipoleLoadHoldTime+DipoleBSweepTime+DipoleBOffSweep;
end
>>>>>>> 4a1ccf7d7d3baea4d17d5e8ef44e2dbe07aa1f63
