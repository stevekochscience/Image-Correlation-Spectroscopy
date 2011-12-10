function [a residual] = flowfit(time,corr,weights);

% 'a' contains the coefficients from the flow eqn, in the following order:
% f=g0*exp(-(x/tauf)^2) + c

% If weights isn't given as an input, then all pnts are weighted equally
if nargin == 2
    weights = ones(size(corr));
end

a0 = zeros(1,3);

    corrAvg = corr;
    timeAvg = time;

    a0(1) = (max(corrAvg) - min(corrAvg));
    a0(2) = timeAvg(find(ismember(abs((corrAvg/max(corrAvg) - exp(-1))),min(min(abs(corrAvg/max(corrAvg) - exp(-1))))),1,'first'));
    a0(3) = max([min(corrAvg) 0]);

%Sets curve fit options, and sets lower bounds for amplitude and beam
%radius to zero
lb = [0 0 0];
ub = [];

curvefitoptions = optimset('Display','off','MaxFunEvals',10000,'MaxIter',5000);

[a,resnorm,residual] = lsqcurvefit(@flow,a0,time,corr.*weights,lb,ub,curvefitoptions,weights);

figure

    hold on
        subplot(3,1,[1 2])
         hold on
    ypred = flow(a,timeAvg,ones(size(timeAvg)));

    plot(timeAvg,ypred,'-r')
    plot(timeAvg,corrAvg,'.')

        subplot(3,1,[1 2])
    xlabel('\tau (s)','FontSize',10)
    set(gca,'XScale','log');
    ylabel('r_1_1 (0,0,\tau)','FontSize',10)
    title('Flow Fit','FontSize',10)
    axis tight
    subplot(3,1,[3])
    hold on
plot(timeAvg,0,'-k')
plot(timeAvg,corrAvg-ypred,'-r')
axis tight
ylabel('Residuals','FontSize',12)
set(gca,'XScale','log');
xlabel('\tau (s)','FontSize',10)