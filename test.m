dev_old = block_old.devices{2,2};
dev_new = block_new.devices{2,2};


size(zeros(dev_old.deviceMap.analogLinesCount,dev_old.timeLine.durationTime*dev_old.sampleRate))
size(zeros(dev_new.deviceMap.analogLinesCount,dev_new.timeLine.durationTime*dev_new.sampleRate))