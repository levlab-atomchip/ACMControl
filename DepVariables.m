% Dependent Variables

MOTTime = UniblitzTime + LoadTime;
% MacroCompressTime = MacroCompRampTime + MacCompHoldTime;
MicroCaptureTime = MicroCapHoldTime + MicroCapRFSweepTime + max(MicroRampTime,MacroMicroWaitTime + MacroMicroRampTime);