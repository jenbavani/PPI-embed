function [CN] = commonNeighborsMat(G)
% Find the number of common neighbors of v1 and v2 in graph G
% for every pair of vertices v1 and v2
% G should be in sparse matrix representation

Gfull = full(G);
CN = zeros(size(Gfull));
numNodes = size(Gfull, 1);

for v1 = 1:numNodes
    for v2 = 1:v1-1
        n = sum (Gfull(:,v1) .* Gfull(:,v2) );
        CN(v1,v2) = n;
        CN(v2,v1) = n;
    end
end
