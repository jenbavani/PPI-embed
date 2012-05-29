function [CC] = clusteringCoefficients(AdjMat)
% Returns a vector CC such that CC(i) is the clustering coeff of i

CC = zeros(1,size(AdjMat,1));

for i=1:size(AdjMat,1)
    n = find(AdjMat(i,:)); % n = vector of neighbors
    nMat = AdjMat(n,n);
    num = sum(sum(nMat));
    denom = size(n,2);
    denom = denom*(denom-1);
    if denom == 0 
        CC(i) = 0;
    else        
        CC(i) = num/denom;
    end
end