function noiseMatrix=addCountingNoise(matrix, coefficient)

% adds random numbers normally distributed with variance coefficeint*mean(image)
% to an image matrix

noiseMatrix=randn(size(matrix));
%noisyMatrix=matrix+coefficient*max(nonzeros(matrix))*noiseMatrix.*sqrt(matrix);

noiseMatrix=matrix+coefficient*noiseMatrix.*sqrt(matrix);
% puts to 0 the negative elements

noiseMatrix(find(noiseMatrix<0)) = 0;