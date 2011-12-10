function [a residual] = difffit(time,corr,weights);
    
% 'a' contains the coefficients from the diffusion eqn, in the following order:
% f=y0+(g0*tau)/(tau+x)

% If weights isn't given as an input, then all pnts are weighted equally
if nargin == 2
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

curvefitoptions = optimset('Display','final','MaxFunEvals',10000,'MaxIter',5000);

[a,resnorm,residual,exitflag,output,lambda,jacobian] = lsqcurvefit(@diffusion,a0,time,corr.*weights,lb,ub,curvefitoptions,weights);

figure

    hold on
        subplot(3,1,[1 2])
         hold on
    ypred = diffusion(a,timeAvg,ones(size(timeAvg)));

    plot(timeAvg,ypred,'-r')
    plot(timeAvg,corrAvg,'.')

        subplot(3,1,[1 2])
    xlabel('\tau (s)','FontSize',10)
    set(gca,'XScale','log');
    ylabel('r_1_1 (0,0,\tau)','FontSize',10)
    title('Diffusion Fit','FontSize',10)
    axis tight
    subplot(3,1,[3])
    hold on
plot(timeAvg,0,'-k')
plot(timeAvg,corrAvg-ypred,'-r')
axis tight
ylabel('Residuals','FontSize',12)
set(gca,'XScale','log');
xlabel('\tau (s)','FontSize',10)

