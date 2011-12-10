function [GtAvg,RawGt] = tics(imgser,timesize);

% July 10, 2003
% David Kolin
% Calculates time correlation function given 3D array of image series
% Returns ALL g(0,0) values -- doesn't average them!!!
% Usage: [RawGt,GtAvg] = tics(imgser,timesize);

%h = waitbar(0,'Calculating time correlation functions...');

% tau is the lag
% pair is the nth pair of a lag time

       %timecorr = zeros(size(imgser,1),size(imgser,2),size(imgser,3));  % preallocates lagcorr matrix for storing raw time corr functions    
       %timecorrStdDev = zeros(size(imgser,3)-1,1);
       RawGt = zeros(mean(1:size(imgser,3))*(size(imgser,3)),2) - 1;
       GtAvg = zeros(size(imgser,3),2);
       %imgser = double(imgser);
       index = 1;
       %Calculates mean of each image before to save time in calculation
       imgSerMean = squeeze(mean(mean(imgser,2)));
       for tau = 0:(size(imgser,3)-1)

           lagcorr = zeros(1,1,(size(imgser,3)-tau)); % preallocation
           lagcorrStd = zeros(1,1,(size(imgser,3)-tau)); % preallocation
           for pair=1:(size(imgser,3)-tau)
               corrNonAvgNonNorm = (double(imgser(:,:,pair)).*double(imgser(:,:,pair+tau)));
               corrNonAvg = corrNonAvgNonNorm/(imgSerMean(pair)*imgSerMean(pair+tau));
               lagcorr(1,1,pair) = mean2(corrNonAvg) - 1;
               %lagcorrStd(1,1,pair) = std2(corrNonAvg);
               clear corrNonAvg;
           end
           RawGt(index : (size(imgser,3)-tau+index-1),1) = timesize * tau * ones(size(imgser,3)-tau,1);
           RawGt(index : (size(imgser,3)-tau+index-1),2) = squeeze(lagcorr(1,1,:));
           %RawGt(index : (size(imgser,3)-tau+index-1),3) = squeeze(lagcorrStd(1,1,:));
           GtAvg(tau+1,1) = tau * timesize;
           GtAvg(tau+1,2) = squeeze(mean(mean(lagcorr)));
           GtAvg(tau+1,3) = squeeze(std2(lagcorr));
           index = min(find(RawGt(:,1) == -1));
           %waitbar((tau+1)/(size(imgser,3)-1),h)
       end

%close(h)