function noiseMatrix=addBackgroundNoise(matrix, coefficient)

% adds random numbers normally distributed with variance coefficeint*mean(image)
% to an image matrix

noiseMatrix=abs(randn(size(matrix)));
noiseMatrix=matrix+coefficient*max(nonzeros(matrix))*noiseMatrix;