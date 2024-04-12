function [Goffset,Soffset] = phasorCalibrate(angularFreq,IRF,timeInterval)
% Calculate the phasor coordinates of the instrument response function
% ******************************************************************************
% angularFreq:     Angular frequency of excitation
% IRF:             instrument response function
% timeInterval:    time resolution of fluorescence decay

[~,p0] = max(IRF);
IRF=IRF(p0:end);
TimeAxis = (0:(length(IRF)-1))*timeInterval;
Goffset = sum(IRF.*cos(angularFreq*TimeAxis)) / sum(IRF);
Soffset = sum(IRF.*sin(angularFreq*TimeAxis)) / sum(IRF);

end