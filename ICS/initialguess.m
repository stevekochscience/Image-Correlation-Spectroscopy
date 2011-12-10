function [g0, wguess, y0, X0, Y0] = initialguess(corrfunc);

% Calculates initial guesses for gaussian fit, given correlation function
% David Kolin
% July 11, 2003

[X,Y] = meshgrid(-((size(corrfunc,2)-1)/2)*pixelsize:pixelsize:((size(corrfunc,2)-1)/2)*pixelsize,-((size(corrfunc,1)-1)/2)*pixelsize:pixelsize:(size(corrfunc,1)-1)/2*pixelsize);
grid = [X Y];

global pixelsize;

y0 = zeros(size(corrfunc,3),1);
g0 = max(max(corrfunc));
g0 = squeeze(g0);
[Y0, X0] = find(ismember(corrfunc,max(max(corrfunc))));
X0 = mod(X0,size(corrfunc,2));

%EvilX0 and Y0 are where remainder from mod was zero -- these are set to
%the "max" (ie size) of the corrfunc
EvilX0 = find(ismember(X0,0));
X0(EvilX0) = size(corrfunc,2);

Wguess = zeros(size(corrfunc,3),1);
for i=1:size(corrfunc,3)
[Wy, Wx] = find(ismember(abs((corrfunc(:,:,i)/g0(i) - exp(-1))),min(min(abs(corrfunc(:,:,i)/g0(i) - exp(-1))))));
Wx = mod(Wx,size(corrfunc,2));
wguess(i) = mean(( (Wx - X0(i)).^2  + (Wy - Y0(i)).^2   ).^(1/2))
end

% Converts from matrix index to LOCATION in pixelsize units
for i=1:size(corrfunc,3)
  X0(i) = X(1,X0(i)); 
end
for i=1:size(corrfunc,3)
  Y0(i) = Y(Y0(i),1);  
end
%wguess = squeeze(wguess);