function [Gmap2,Smap2] = phasorShift(Gmap,Smap,Goffset,Soffset)
% Shift phasor points to account for instrument response function.
% ******************************************************************************
% Gmap, Smap:          Phasor points calculated from fluorescence decays
% Goffset, Soffset:    Phasor offset calculated from instrument response function

Gmap2 = (Goffset*Gmap + Soffset*Smap)/(Goffset*Goffset + Soffset*Soffset);
Smap2 = (-Soffset*Gmap + Goffset*Smap)/(Goffset*Goffset + Soffset*Soffset);

return