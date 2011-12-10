function [randStringAvg] = QDBlink(mOn,mOff,numTimeSteps,numPerStep);

minTime = 1;
maxTime = numTimeSteps*numPerStep;

randPowerOn = @(sizeRan,minTime,maxTime) round((rand(sizeRan)/(minTime).^mOn).^-(1/mOn));
randPowerOff = @(sizeRan,minTime,maxTime) round((rand(sizeRan)/(minTime).^mOff).^-(1/mOff));

% randPowerOn = @(sizeRan,minTime,maxTime) round((rand(sizeRan)/sqrt(minTime)+1/sqrt(1000000)).^-(1/mOn));
% randPowerOff = @(sizeRan,minTime,maxTime) round((rand(sizeRan)/sqrt(minTime)+1/sqrt(1000000)).^-(1/mOff));

totalTimeSteps = maxTime;

randString = zeros(totalTimeSteps,1) - 1;

stringIndex = 1;
while randString(end) == -1 
    % On time
    numToAdd = min([randPowerOn(1,minTime,maxTime) maxTime]);
    randString(stringIndex:stringIndex+numToAdd) = 1;
    stringIndex = stringIndex+numToAdd;
    % Off time
    numToAdd = min([randPowerOff(1,minTime,maxTime) maxTime]);
    randString(stringIndex:stringIndex+numToAdd) = 0;
    stringIndex = stringIndex+numToAdd;
end

% Crops series if it's too long
randString(totalTimeSteps+1:end) = [];

% Reshapes matrix to average it
randStringAvg = reshape(randString,numPerStep,numTimeSteps);
randStringAvg = mean(randStringAvg,1);