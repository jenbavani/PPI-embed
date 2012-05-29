function [distsPL, distsSQRT] = commonNeighborsDists(G)
% Find the "common neighbors distance" between each pair of nodes in G
% G is a graph (adj. mat.) in sparse representation
%
% For distsPL:
% d = 0.5*(1 - (n/n+1)) for v1,v2 connected in G, n = # common neighbors
% d = shortest path sum otherwise
%
% distsSQRT contains the square roots of the distances in distsSQ

g=full(G);
neighbors = commonNeighborsMat(G);
distsPL = g .* neighbors; 
% connected pairs have d = 0.5*(1 - (n/n+1))
distsPL = distsPL ./ (distsPL + 1);
distsPL = 0.5*(2-distsPL);
distsPL = distsPL .* g; 
distsPL = graphallshortestpaths(sparse(distsPL));
distsSQRT = distsPL .^ 0.5;