function [imageMatrix,xCoor,yCoor]=createImage(sizeImageX, sizeImageY, numParticles)

% creates a matrix with numParticles number of particles 

xCoor=ceil(sizeImageX*rand(numParticles, 1));
yCoor=ceil(sizeImageY*rand(numParticles, 1));

imageMatrix=full(sparse(xCoor, yCoor, 1, sizeImageX, sizeImageY));
