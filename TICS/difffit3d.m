function [a residual] = difffit3d(time,corr,wRatio,weights);
    
% 'a' contains the coefficients from the diffusion eqn, in the following order:
% f=y0+(g0*tau)/(tau+x)

% If weights isn't given as an input, then all pnts are weighted equally
if nargin == 3
    weights = ones(size(corr));
end

    corrAvg = corr;
    timeAvg = time;

a0 = zeros(1,3);

    a0(1) = (max(corrAvg) - min(corrAvg));
    a0(2) = timeAvg(find(ismember(abs((max(corrAvg) - min(corrAvg))/2 - corrAvg),min(min(abs((max(corrAvg) - min(corrAvg))/2 - corrAvg)))),1,'first'));
    a0(3) = max([min(corrAvg) 0]);

% Sets curve fit options, and sets lower bounds for amplitude and beam
% radius to zero
lb = [];
ub = [];

curvefitoptions = optimset('Display','off','MaxFunEvals',10000,'MaxIter',5000);

[a,resnorm,residual] = lsqcurvefit(@diffusion3d,a0,time,corr.*weights,lb,ub,curvefitoptions,wRatio,weights);