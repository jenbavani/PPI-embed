function [THRESH] = thresh(VALS,NUM)
% Given a 1- or 2-D matrix VALS and a number NUM, find a value THRESH at which
% NUM of the values in VALS are less than or equal to THRESH.
% 
% input: VALS - a matrix of values ; 
%        NUM - the number of values that must fall below (or at) THRESH
% output: THRESH - threshhold (see description above

%flatten VALS
vals = reshape(VALS,(size(VALS,1)*size(VALS,2)),1);

vals = sort(vals);
THRESH = vals(NUM);
