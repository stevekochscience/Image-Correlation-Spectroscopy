function [Vx,Vy] = velocity(image_data,t,pixelsize,immobile,tauLimit,whitenoise);

t = linspace(0,t*size(image_data,3),size(image_data,3))';

% Calculates speed and direction given the coefficients of the 2D fits

% Filters immobile fraction
if strcmp('y',immobile)
    image_data = immfilter(image_data);
end

[Gtime] = stics(image_data,tauLimit);

% Does time fit
[coeffGtime,resGtime] = gaussfit(Gtime,'time',pixelsize,whitenoise);
        
% Plots magnitude of distance, against time
figure
plot(t(1:tauLimit),coeffGtime(1:tauLimit,4),'k.')
hold
plot(t(1:tauLimit),coeffGtime(1:tauLimit,5),'r.')
xlabel('\tau (s)','FontSize',12)
ylabel('d','FontSize',12)
title('Select end of "linear" region.','FontSize',14)

% Prompts user to select end of non noisy data
[ xlim , ylim ] = ginput(1);
% close;
% xlin and ylin are the coordinates of a point outside the region of "nice" decay.
% So, any points with a t value less than xlim are in that region.
% t and Gtime are the "good" decay values.

coeffGtime = coeffGtime(1:max(find(t<=xlim)),:);
t = t(1:max(find(t<=xlim)),:);
regressionX = polyfit(t,coeffGtime(:,4),1);
Vx = -regressionX(1);
regressionY = polyfit(t,coeffGtime(:,5),1);
Vy = -regressionY(1);