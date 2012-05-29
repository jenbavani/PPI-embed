function [edges] = RandGraphER(n,p)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate an Erdos-Renyi type random graph
%
% INPUT:
% n - the number of nodes
% p - the probability of the presence of any given edge
%   ( e/(v choose 2) )
%
% OUTPUT:
% edges - an adjacency list representation of a graph
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

edges = [];
v = 1:n
v = v'

for i = 1:n
    rands = rand(n,1)
    rands(v<=i) = 1
    newEdges = v(rands<p)
    newEdges = [ newEdges i*ones(size(newEdges,1),1) ]
    edges = [edges ; newEdges]
end
