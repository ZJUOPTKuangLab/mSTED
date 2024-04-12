function Intensity2 = rescaleInt(Intensity,minPhoton,satRatio)
% Normalize intensity image and adjust its contrast as well
% ******************************************************************************
% Intensity:       intensity image
% minPhoton:       minimum number of photons
% satRatio:        saturation ratio of the brightest pixels

Intensity = double(Intensity);
ImR = sort(nonzeros(Intensity(:)),'descend'); 
maxPhoton = ImR(max(round(satRatio*length(ImR)),1)); 
Intensity2 = (Intensity-minPhoton)/(maxPhoton-minPhoton); 
Intensity2 = Intensity2.*(Intensity2<1) + (Intensity2>=1); 
Intensity2 = Intensity2.*(Intensity2>=0); 

end