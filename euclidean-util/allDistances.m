function [D] = allDistances(M1,M2)
% D(i,j) = the distance between row i of M1 and row j of M2
% Input: m-by-p matrix M1, n-by-p matrix M2
%   (if only one argument is given, that matrix is used for both args
% Output: m-by-n matrix D

if nargin<2
    M2=M1;
end

m = size(M1,1);
n = size(M2,1);
D = zeros(m,n);

for i = 1:m
    D(i,:) = distFromAll(M1(i,:),M2);
end