function [a residual] = diffflowfit(time,corr,weights);
    
% 'a' contains the coefficients from the diffusion flow eqn, in the following order:
% f=g0d*(1+x/td)^-1+g0f*exp(-(v*x/w)^2) + c

% If weights isn't given as an input, then all pnts are weighted equally
if nargin == 2
    weights = ones(size(corr));
end

a0 = zeros(1,5);

    corrAvg = corr;
    timeAvg = time;


    a0(1) = (max(corrAvg) - min(corrAvg))/2;
    a0(2) = timeAvg(find(ismember(abs((max(corrAvg) - min(corrAvg))/2 - corrAvg),min(min(abs((max(corrAvg) - min(corrAvg))/2 - corrAvg)))),1,'first'));;
    a0(3) = (max(corrAvg) - min(corrAvg))/2;
    a0(4) = timeAvg(find(ismember(abs((corrAvg/max(corrAvg) - exp(-1))),min(min(abs(corrAvg/max(corrAvg) - exp(-1))))),1,'first'));
    a0(5) = max([min(corrAvg) 0]);
    
    % Sets curve fit options, and sets lower bounds for amplitude and beam
    % radius to zero
    lb = [];
    ub = [];
    
    curvefitoptions = optimset('Display','final','MaxFunEvals',5000,'MaxIter',5000);

    [a,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@diffusionflow,a0,time,corr.*weights,lb,ub,curvefitoptions,weights);
