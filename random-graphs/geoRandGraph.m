function [GRAPH,POINTS] = geoRandGraph(NODES,EDGES,DIM)
% Generate a geometric random graph

if nargin < 3
    DIM = 3;
end

POINTS = rand(NODES,DIM);
GRAPH = discoverEdges(POINTS,EDGES);


