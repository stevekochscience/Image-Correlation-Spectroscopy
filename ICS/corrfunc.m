function [G] = corrfunc(imgser);

% July 9, 2003
% David Kolin
 
% Calculates 2D correlation functions for each z slice of a given 3D matrix (imgser)
% Output as a 3D matrix with same dimensions as imgser
G = zeros(size(imgser)); % Preallocates matrix

% Calculates corr func
% Then normalizes corr function

set(gcbf,'pointer','watch');

   h = waitbar(0,'Calculating 2D autocorrelation functions...');

for z=1:size(imgser,3)
    G(:,:,z) = ((fftshift(real(ifft2(fft2(double(imgser(:,:,z))).*conj(fft2(double(imgser(:,:,z))))))))/(mean(mean(imgser(:,:,z)))^2*size(imgser,1)*size(imgser,2))) - 1;
     if ishandle(h)
     waitbar(z/size(imgser,3),h)
     else
         break
     end
end

if ishandle(h)
 close(h)
end

set(gcbf,'pointer','arrow');
