function [D] = distFromAll(v,M)
%Get the distance from row vector v to each row of M

vMat = ones(size(M,1),1)*v;
D = vMat - M;
D = rowNorms(D);
