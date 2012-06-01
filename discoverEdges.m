function GRAPH = discoverEdges(POINTS, NUM_EDGES)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Discover edges from an embedding of points in space based on distance.
% This function chooses a threshold T and if d(u,v)<T, the edges (u,v) 
% is included in the graph. T is the smallest T such that the graph has
% at least NUM_EDGES edges.
%
% INPUT:
% POINTS - an n-by-dim matrix, where n is the number of points
%   in a dim dimensional space.  These are the coordinates of some
%   embedding.
% NUM_EDGES - the desired number of edges in the graph.
% 
% OUTPUT:
% GRAPH - a sparse matrix representation of the graph.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialize.
NUM_NODES = size(POINTS,1);

% Calculate the pairwise distances.
dists = allDistances(POINTS,POINTS);

% Find the threshold. 
% We need to include all NODES diagonal entries (they will all be 0)
% plus 2 entries (symmetric) for each NUM_EDGES pairs.
cutoff = thresh(dists,NUM_NODES+(2*NUM_EDGES))

% Generate the graph and exclude diagonal entries (self-edges)
graph = dists<=cutoff - eye(NUM_NODES);
msg = ['generated graph with ' num2str(size(dists,1)) ' nodes and'];
msg = [num2str(sum(sum(graph))/2) ' edges'];

% Sparsify.
GRAPH = sparse(graph);