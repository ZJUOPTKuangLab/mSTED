function dpie = phasorProject(Gmap,Smap,a,b,x1,y1,Gmax)
% Calculate the projection of the phasor points
% ******************************************************************************
% Gmap, Smap:    Phasor distribution calculated from fluorescence decays
% a, b:          slope and intercept of the fitted line
% x1,y1:         the intersection of the fitted line and the universal semicircle
% Gmax:          maximum horizontal coordinate of the phasor point

xmatr = (Gmap+a*Smap-a*b)/(1+a^2);
ymatr = (a*Gmap+a^2*Smap+b)/(1+a^2);
dpie = sqrt((x1-xmatr).^2+(y1-ymatr).^2);
dpie(isnan(dpie)|Gmap>Gmax) = 0;
end