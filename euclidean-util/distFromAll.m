function [D] = distFromAll(v,M)
% Get the distance from row vector v to each row of M
% Input: v (1-by-n), M (m-by-n)
% Output: D (m-by-1)

% Make a matrix whose rows are copies of v, with as many rows as M has
vMat = ones(size(M,1),1)*v;

% Get the difference vector between v and each row of M
D = vMat - M;

% Find the lengths of these difference vectors
D = rowNorms(D);
