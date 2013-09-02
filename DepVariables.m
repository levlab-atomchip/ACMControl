% Dependent Variables
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