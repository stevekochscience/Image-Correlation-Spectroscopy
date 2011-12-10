function F = diffusionflow(a,data,weights);

% f=g0d*(1+x/td)^-1+g0f*exp(-(v*x/w)^2) + c
% Used by the curve fitter to calculate values for the diffusion flow equation

    F = (a(1) .* (1+data./a(2)).^-1+a(3).*exp(-(data./a(4)).^2) + a(5)).*weights;  
