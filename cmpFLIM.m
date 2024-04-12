function colorImg = cmpFLIM(mask,lut,Intensity)
% Calculate color-mapped mSTED images from digital masks and intensity images
% ******************************************************************************
% mask:         digital mask
% lut:          colorbar
% Intensity:    intensity image

imageRes = size(mask,1);
stackSize = size(mask,3);
cmpScale = size(lut,1)-1;
Intensity = mat2gray(Intensity);
colorImg = zeros(imageRes,imageRes,3,stackSize);
for ii = 1:stackSize
    redox = round(cmpScale*mask(:,:,ii))+1;
    Intensity2 = repmat(Intensity(:,:,ii),1,1,3);
    colorImg(:,:,:,ii) = ind2rgb(redox(:,:,ii),lut).*Intensity2;
end

end