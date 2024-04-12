function [Gmap,Smap] = phasorImg(decayData,timeInterval,angularFreq)
% Phasor calculation for the fluorescence decay array. Requires calcPhasors.m.
% ******************************************************************************
% decayData:      fluorescence decay data
% timeInterval:   time resolution of fluorescence decay
% angularFreq:    Angular frequency of excitation

pixels = size(decayData,1);
decayCell = num2cell(shiftdim(decayData,1),1);
decayCell = shiftdim(decayCell,1);

timeStepCell = num2cell(ones(pixels,1)*timeInterval);
angularFreqCell = num2cell(ones(pixels,1)*angularFreq);

[Gmap,Smap] = cellfun(@calcPhasors,decayCell,timeStepCell,angularFreqCell);

end