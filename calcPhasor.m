function [g,s] = calcPhasor(decayData,timeInterval,angularFreq)
% Calculate the phasor point from the fluorescence decay.
% ******************************************************************************
% decayData:      fluorescence decay data
% timeInterval:   time resolution of fluorescence decay
% angularFreq:    Angular frequency of excitation

[~,p0] = max(decayData);
decayData=decayData(p0:end);
TimeAxis = (0:size(decayData,1)-1)'*timeInterval;
g = sum(decayData.*cos(angularFreq*TimeAxis)) / sum(decayData);
s = sum(decayData.*sin(angularFreq*TimeAxis)) / sum(decayData);

end