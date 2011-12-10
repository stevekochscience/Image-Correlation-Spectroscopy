function [population] = simul8trMovement(population,timesize,pixelsize,sizeX,sizeY,sizeZ);

% Simulates particle diffusion and flow, given a 2D matrix, inputObjects
% (containing only 0, 1, 2, etc) and diffCoeff, flowX,flowY
% Does not support multiple populations -- call a new simul8trMovement separately,
% and pass it the inputObjects matrix of a different population

% August 30, 2004
% By DK

% Do different kinds of particle movement here
if population.diffCoeff ~= 0;
    %population.xCoor = population.xCoor+randn((size(population.xCoor))).*sqrt(2*population.diffCoeff*timesize*population.xCoor/10)/pixelsize;
    population.xCoor = population.xCoor+randn((size(population.xCoor)))*sqrt(2*population.diffCoeff*timesize)/pixelsize;
    population.yCoor = population.yCoor+randn((size(population.yCoor)))*sqrt(2*population.diffCoeff*timesize)/pixelsize;
    if sizeZ ~= 0
        population.zCoor = population.zCoor+randn((size(population.zCoor)))*sqrt(2*population.diffCoeff*timesize)/pixelsize;
    end
end

if (population.flowX ~= 0) | (population.flowY ~= 0)
    population.xCoor = population.xCoor+(population.flowX*timesize)/pixelsize;
    population.yCoor = population.yCoor+(population.flowY*timesize)/pixelsize;
end

if (population.flowZ ~= 0)
    if sizeZ ~= 0
        population.zCoor = population.zCoor+(population.flowZ*timesize)/pixelsize;
    end
end

% Fix BC problems here
population.xCoor = mod(population.xCoor,sizeX);
population.yCoor = mod(population.yCoor,sizeY);
population.xCoorDisplay = round(population.xCoor);
population.yCoorDisplay = round(population.yCoor);
xZeros = find(population.xCoorDisplay==0);
yZeros = find(population.yCoorDisplay==0);
population.xCoorDisplay(xZeros) = sizeX;
population.yCoorDisplay(yZeros) = sizeY;
if sizeZ ~= 0
    population.zCoor = mod(population.zCoor,sizeZ);
end