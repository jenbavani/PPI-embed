function newGraph = addDummyNode(graph,centers)
%% Add a dummy node to the graph
%  The dummy node is adjacent to all nodes EXCEPT the center(s).
%
%  Usage:
%  newGraph = addDummyNode(graph,centers)
%
%  graph - in sparse matrix form (n-by-n)
%  centers - a k-by-1 array of k integer indices for nodes NOT to connect
%   to the dummy node
%  newGraph - in sparse matrix form ((n+1)-by-(n+1)) -- node n+1 is the 
%   dummy node
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nNodes = max(size(g));
g = zeros(nNodes+1);
g(1:nNodes,1:nNodes) = full(graph)
newCol = ones(nNodes+1,1);

newCol(nNodes+1) = 0;   %No self-edge
for c=centers
    newCol(c) = 0;      %No edges to centers
end

g(:,nNodes+1) = newCol;
g(nNodes+1,:) = newCol';

newGraph = sparse(g);
