function decayData = decayFilter(decayMatrix,binning)
% Calculate fluorescence decays within a sliding window and reshape them into a two-dimensional array
% ******************************************************************************
% decayMatrix:     fluorescence decay matrix
% binning:         window size for calculating phasor points

phasorRes = size(decayMatrix,4);
if binning > 0
    kernel = fspecial('disk',binning);
    kernel = kernel/max(max(kernel));
    for ii = 1:size(decayMatrix,3)
        for jj = 1:phasorRes
            decayMatrix(:,:,ii,jj) = imfilter(decayMatrix(:,:,ii,jj),kernel);
        end
    end
end
decayData = reshape(decayMatrix,[],phasorRes);

end