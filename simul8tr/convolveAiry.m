function convolvedMatrix=convolveAiry(matrix, filterSize, radius)

% The standard deviation is the parameter that defines the Gaussian in
% fspecial. Exp(-x^2/2/s^2).
% The the n_by_n matrix for the filter. Considering the pixel size
% 0.1microns => 5 pixels is the radius of one particle. 20 sounds
% reasonable for n. So, standard dev=2.5


[X Y] = meshgrid(linspace(-7.0156,7.0156,filterSize));

filterCoords = sqrt(X.^2+Y.^2);
filter=airy2(filterCoords);
filter(find(filterCoords>7.02)) = 0;

convolvedMatrix=imfilter(double(matrix),filter,'circular','conv');