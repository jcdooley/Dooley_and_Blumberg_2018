function [ts, ydata, fo, gof, output] = WakeExponentialGaussian(data, t, BL, Max, tMax)

%[ts, ydata, fo, gof, output] = WakeExponentialGaussian(data, t, BL, Max, tMax)
%
% Created by Jimmy Dooley on 8/1/2017
% Version 1.5
% For updates, contact Jimmy at james-c-dooley@uiowa.edu
%
% INPUTS:
% data - This is your data, in spikes per second, of each bin
% t - This is the center time of each bin, relative to the wake movement
% BL - This is an estimate of the fit for baseline firing rate. Estimates
%    can be performed a lot of ways, but a good approximation is the mean of a
%    period of time before the wake movement.
% Max - This is an estimate of the peak of the model. A good starting point
%    is the max bin value, minus your estimated BL.
% tMax - This is an estimate of the time of the maximum value of the fit.
%    A good estimate for this would be the time of the max bin.
%
%
% OUTPUTS:
% ts: The timepoints of the model, from start to end time, at millisecond
%    resolution, from min(t) to max(t).
% ydata: The y values (SPS) of the model, from the same time period.
% fo: This is your matlab "fit" data. It's got the equation,
%    coefficients, and 95% confidence bounds. It's a cell of data.
% gof: These are your fit statistics (rsquared, adjrsquared, etc)
% output: Input about what the model did
% NOTE: gauswidth is not equal to half width at half height!


% Set up fittype and options.
ft = fittype( 'Gau_Exp_Model(t, baseline, scale, exponentfit, gauswidth, tmax)', 'independent', 't');

% Fit model to data.
[fo, gof, output] = fit(t, data, ft, 'StartPoint', [BL Max 1, 1, tMax], 'Lower', ...
    [0 0 0 0 min(t)], 'Upper', [100 200 Inf Inf max(t)], 'MaxFunEvals', 2000, 'MaxIter', 1000);

ts = min(t):0.001:max(t);
ydata = Gau_Exp_Model(ts, fo.baseline, fo.scale, fo.exponentfit, fo.gauswidth, fo.tmax);


