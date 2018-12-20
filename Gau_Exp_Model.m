% function c = Gau_Exp_Model(t, baseline, scale, exponentfit, gauswidth, tmax)
% 
% Function of the Gaussian-exponential model for fitting wake movements.
% Rising phase is a Gaussian, falling phase is an exponential.
% Required to run "WakeExponentialGaussian.m"


function c = Gau_Exp_Model(t, baseline, scale, exponentfit, gauswidth, tmax)

c = zeros(size(t));

ind = (t <= tmax);
c(ind) = baseline + scale*exp(-((t(ind)-tmax)./gauswidth).^2);


ind = (t >= tmax);
c(ind) = baseline + scale*exp(-exponentfit*(t(ind)-tmax));


