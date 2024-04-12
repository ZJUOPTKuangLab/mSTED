% ******************************************************************************
% mSTED reconstruction for multi-color live-cell super-resolution imaging
% ******************************************************************************
% Intensity:       Intensity image
% decayMatrix:     fluorescence decay matrix
% IRF:             instrument response function
% timeInterval:    time resolution of fluorescence decay, unit: ns
% LaserFreq:       pulse frequency of excitation, unit: Hz
% lut:             colorbar for lifetime images
% minPhoton:       minimum number of photons to calculate the phasor point
% binning:         window size for calculating phasor points
% minArea:         minimum area of isolated structure
% Gmax:            maximum horizontal coordinate of the phasor point
% decayTail:       length of decay trailing end to be discarded
% ******************************************************************************
% Written by Yuran Huang @ huangyr@zju.edu.cn

function colorImg = mSTEDmain(decayMatrix,Intensity,IRF,timeInterval,LaserFreq,lut,minPhoton,binning,minArea,Gmax,decayTail)

if nargin < 6 || isempty(lut)
    lut = cool(256);
end
if nargin < 7 || isempty(minPhoton)
    minPhoton = 10;
end
if nargin < 8 || isempty(binning)
    binning = 3;
end
if nargin < 9 || isempty(minArea)
    minArea = 200;
end
if nargin < 10 || isempty(Gmax)
    Gmax = 0.36;
end
if nargin < 11 || isempty(decayTail)
    decayTail = 0;
end

imageRes = size(decayMatrix,1);
stackSize = size(decayMatrix,3);
phasorRes = size(decayMatrix,4);
angularFreq = 2*pi*LaserFreq*10^-9;

decayMatrix = decayMatrix.*repmat(Intensity > minPhoton,1,1,1,phasorRes);
[decayPeak,t0,gA,sA] = sumDecay(decayMatrix,timeInterval,angularFreq,decayTail);
decayData = decayFilter(decayMatrix(:,:,:,decayPeak:phasorRes-decayTail),binning);

[Goffset,Soffset] = phasorCalibrate(angularFreq,IRF,timeInterval);
[Gmap,Smap] = phasorImg(decayData,timeInterval,angularFreq);
[Gmap2,Smap2] = phasorShift(Gmap,Smap,Goffset,Soffset);

plotRes = phasorRes*8;
[phasorPlot,a,b] = plotPhasor(Gmap2(Intensity(:) > minPhoton&Gmap2<Gmax),Smap2(Intensity(:) > minPhoton&Gmap2<Gmax),plotRes);
[x1,x2,y1,y2] = phasorFigure(phasorPlot,plotRes,a,b,t0,gA,sA);

dpie = phasorProject(Gmap,Smap,a,b,x1,y1,Gmax);
FLIMimg = reshape(dpie,imageRes,imageRes,stackSize);

satRatio = 1e-3;
phasorPK = FLIMhist(FLIMimg(FLIMimg>0&FLIMimg<1));
mask = FLIM2mask(FLIMimg,phasorPK(1),phasorPK(2)+0.01,minArea,binning);
Intensity2 = rescaleInt(Intensity,minPhoton,satRatio);
colorImg = cmpFLIM(mask,lut,Intensity2);

end