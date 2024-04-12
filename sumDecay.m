function [decayPeak,t0,gA,sA] = sumDecay(decayMatrix,timeInterval,angularFreq,decayTail)
% Calculate the summed fluorescence decay, phasor point and 
% fluorescence lifetime over the entire field-of-view
% ******************************************************************************
% decayMatrix:     fluorescence decay matrix
% timeInterval:    time resolution of fluorescence decay
% angularFreq:     Angular frequency of excitation
% decayTail:       length of decay trailing end to be discarded

if nargin < 4 || isempty(decayTail)
    decayTail = 0;
end

decayMatrix = reshape(decayMatrix,[],size(decayMatrix,4));
overallDecay = sum(decayMatrix,1);

[~,decayPeak] = max(overallDecay);
overallDecay=overallDecay(decayPeak:end-decayTail);
TimeAxis = (0:(length(overallDecay)-1))*timeInterval;
gA = sum(overallDecay.*cos(angularFreq*TimeAxis)) / sum(overallDecay);
sA = sum(overallDecay.*sin(angularFreq*TimeAxis)) / sum(overallDecay);
t0 = FLIMfit(overallDecay,timeInterval);

end