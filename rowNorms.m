function [D] = rowNorms(P)
% Get the norms (L2) of each row of P.
% Returns a column vector with the same # of rows as P.

D = arrayfun(@(idx) norm(P(idx,:)), 1:size(P,1));
D = D';