function phasorPK = FLIMhist(FLIMimg)
% Calculate fluorescence lifetime histogram and identify peaks from it
% ******************************************************************************
% FLIMimg:      fluorescence lifetime image

[phasorH,phasorBins] = histcounts(FLIMimg(FLIMimg>0),100);
phasorPos = (phasorBins(1:end-1)+phasorBins(2:end))/2;
posRange = phasorPos(mat2gray(phasorH)>0.02);

[phasorH,phasorBins] = histcounts(FLIMimg(FLIMimg>0),100,'BinLimits',[min(posRange),max(posRange)]);
phasorPos = (phasorBins(1:end-1)+phasorBins(2:end))/2;
[pks,pklocs] = findpeaks(phasorH);
[~,pksSort] = sort(pks,'descend');
pklocs = pklocs(pksSort);
phasorPK = sort([phasorPos(pklocs(1)),phasorPos(pklocs(2))]);
figure;plot(phasorPos,phasorH);
hold on;plot(phasorPos(pklocs(1)),phasorH(pklocs(1)),'or');
hold on;plot(phasorPos(pklocs(2)),phasorH(pklocs(2)),'or');

end