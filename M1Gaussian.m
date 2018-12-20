function [fitresult, gof] = M1Gaussian(t, data, BL, Max, tMax)

% function [fitresult, gof] = M1Gaussian(t, data, BL, Max, tMax)
%
% Created by Jimmy Dooley on 6/14/2017
% Version 1.8
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
% fitresult: This is your matlab "fit" data. It's got the equation,
%    coefficients, and 95% confidence bounds. It's a cell of data.
% gof: These are your fit statistics (rsquared, adjrsquared, etc)
% NOTE: c1 is not equal to half width at half height!

%% Fit: 'M1Gaussian'.
[xData, yData] = prepareCurveData( t, data);

% Set up fittype and options.
ft = fittype( 'Baseline+(a1.*exp(-((x-b1)./c1).^2))');
opts = fitoptions( 'Method', 'NonlinearLeastSquares' );
opts.Display = 'Off';
opts.Lower = [0 0 0 0];
opts.Upper = [100 200 0.4 0.4];
opts.MaxFunEvals = 7000;
opts.Normalize = 'on';
opts.StartPoint = [BL Max tMax 0.1];

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );



