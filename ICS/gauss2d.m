function F = gauss2d(a,data,weights);

% Used by the curve fitter to calculate values for a 2d gaussian

X = data(:,1:size(data,2)/2);
Y = data(:,size(data,2)/2+1:end);

F = (a(1)*exp(-((X-a(4)).^2+(Y-a(5)).^2)/(a(2)^2)) + a(3)).*weights;