function [phasorPlot,a,b] = plotPhasor(Gmap,Smap,plotRes)
% Calculate phasor distribution and the fitted line
% ******************************************************************************
% Gmap, Smap:    Phasor distribution calculated from fluorescence decays
% plotRes:       Resolution of the phasor plot
% a = slope, b = intercept

plotEdges = 1/plotRes:1/plotRes:1;
phasorPlot = hist3([Smap(:),Gmap(:)],'Edges',{plotEdges,plotEdges});

Coeffs = fit(Gmap(:),Smap(:),'poly1');
a = Coeffs.p1;
b = Coeffs.p2;

end