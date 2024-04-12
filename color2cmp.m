function lut = color2cmp(color1,color2,cres)
% Calculate the summed fluorescence decay, phasor point and 
% fluorescence lifetime over the entire field-of-view
% ******************************************************************************
% color1, color2:    fluorescence decay matrix
% cres:         colorbar resolution

if nargin < 3 || isempty(cres)
    cres = 256;
end

lut = zeros(cres,3);
mp = (0:cres-1)'/(cres-1);
for ii = 1:3
    lut(:,ii) = mp*color2(ii)+(1-mp)*color1(ii);
end
end