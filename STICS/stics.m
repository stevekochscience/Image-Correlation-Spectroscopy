function [timecorr] = stics(imgser,upperTauLimit);

% July 10, 2003
% David Kolin
% Calculates the full time correlation function given 3D array of image series

set(gcbf,'pointer','watch');

h = waitbar(0,'Calculating time correlation functions...');


% tau is the lag
% pair is the nth pair of a lag time

       timecorr = zeros(size(imgser,1),size(imgser,2),upperTauLimit);  % preallocates lagcorr matrix for storing raw time corr functions    
       SeriesMean = squeeze(mean(mean(imgser)));
       
       for tau = 0:upperTauLimit-1
                  lagcorr = zeros(size(imgser,1),size(imgser,2),(size(imgser,3)-tau));      
           for pair=1:(size(imgser,3)-tau)
               lagcorr(:,:,pair) = fftshift(real(ifft2(fft2(imgser(:,:,pair)).*conj(fft2(imgser(:,:,(pair+tau)))))));
           end
           timecorr(:,:,(tau+1)) = mean(lagcorr,3);
           if ishandle(h)
               waitbar((tau+1)/(upperTauLimit),h)
           else
               break
           end
       end

if ishandle(h)
close(h)
end
set(gcbf,'pointer','arrow');