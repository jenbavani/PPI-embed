function [MAT] = dthOrdCommonNeighbors(ADJMAT,d) 

APSP = graphallshortestpaths(ADJMAT);
n = size(APSP,1);
pathmat = zeros(n);

for k = 1:d
    pathmat(APSP==k)=1;
    numNeighbors = @(i,j) sum( pathmat(i,:).*pathmat(j,:) );
    for i = 1:n
        for j = 1:n
            MAT(i,j,k) = numNeighbors(i,j);
        end
    end
end
