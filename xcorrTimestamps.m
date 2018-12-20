% diffs = xcorrTimestamps(x, y, binsize, timewindow, preevent)
% Crosscorrelation of two timestamp datasets
%
% Created by Jimmy Dooley on 5/28/2017
% Version 2.1
% For updates, contact Jimmy at james-c-dooley@uiowa.edu
%
% Input is two vectors of timestamps (x and y), and perameters for your
% histogram.
%
% x = first time series vector (in seconds). This is your trigger 
% y = second time series vector (in seconds)
% binsize = the size of each bin (in the histogram), in milliseconds
% timewindow = the window if time you want to compare the timewindows (in
% seconds)
% preevent = the window of time you want to be from before t = 0 (in
% seconds)
%
% This delivers 9 outputs
% .raw is a matrix of the value for every "trial". Its size is equal to the 
%     number of triggers by the number of bins
% .rawlogical is the same thing as .raw, but only with values of 0 and 1
% .counts is a vector of the counts per bin, in spikes per second (length bins)
% .edges is a vector of the ENDING time of each bin. (length bins)
% .maxcorrel is the value of the counts that is the maximum (length one)
% .countnorm is bin counts, normalized to one (length bins)
% .maxtime is the time of the max (length one)
% .meantomax is the ratio of the max bin to the mean bin (length one)
% .mediantomax is the ratio of the max bin to the median bin (length one)


function diffs = xcorrTimestamps(x, y, binsize, timewindow, preevent)
edges = -preevent:(binsize/1000):(timewindow-preevent);
bins = length(edges)-1;
difference = [];
mtx = zeros(length(x),bins);
for i1 = 1:length(x)
    difference = [difference, y-x(i1)];
    mtx(i1,:) = histcounts(y-x(i1),edges); 
end
diffs.raw = mtx;
diffs.rawlogical = mtx > 0;
[diffs.count, xcorredges] = histcounts(difference,edges);
diffs.edges = xcorredges(2:end);
diffs.countsps = (diffs.count / length(x)) * (1/(binsize/1000));
[diffs.maxcorrel, index] = max(diffs.count);
diffs.countnorm = diffs.count / diffs.maxcorrel;
diffs.maxtime = xcorredges(index);
diffs.meantomax = max(diffs.count)/mean(diffs.count);
diffs.mediantomax = max(diffs.count)/median(diffs.count);



