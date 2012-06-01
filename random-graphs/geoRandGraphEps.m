function [GRAPH,POINTS] = geoRandGraphEps(NODES,EPSILON,DIM)
% Generate a geometric random graph

if nargin < 3
    DIM = 3;
end

POINTS = rand(NODES,DIM);
dists = allDistances(POINTS);
graph = and(dists<EPSILON , ~eye(NODES));
GRAPH = sparse(graph);


