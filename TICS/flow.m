function F = flow(a,data,weights);

% Used by the curve fitter to calculate values for the flow equation

    F = (a(1) .* exp( - ( data./a(2) ).^2) + a(3)).*weights;  
