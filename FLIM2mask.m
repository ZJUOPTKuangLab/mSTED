function mask2 = FLIM2mask(FLIMimg,lowIn,highIn,minArea,binning)
% Converting fluorescence lifetime images containing two different fluorophores 
% into digital masks and rejecting isolated points in digital masks
% ******************************************************************************
% FLIMimg:         fluorescence lifetime image
% lowIn,highIn:    lifetime of the fluorophores
% minArea:         inimum area of isolated structure
% binning:         low-pass filter radius

kernel = fspecial('disk',binning);
nhood = kernel/max(kernel(:))>0.8;
for ii = 1:size(FLIMimg,3)
    mask = imadjust(FLIMimg(:,:,ii),[lowIn,highIn],[0,1]);
    bmask = mask>0.05;
    bmask = imopen(bmask,nhood);
    bmask = bwareaopen(bmask,minArea);
    mask = mask.*double(bmask);
    wmask = mask<0.95;
    wmask = imopen(wmask,nhood);
    wmask = bwareaopen(wmask,minArea);
    mask = 1-(1-mask).*double(wmask);
    mask2(:,:,ii) = imfilter(mask,kernel);
end

end