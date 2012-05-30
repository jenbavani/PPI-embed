function [AdjMat] = AdjListToMat(AdjList)
% input: an adjacency list (2 cols) for an undirected graph
% output: a SPARSE matrix representing the adjacencies

numNodes = max(max(AdjList));

AdjMat = sparse([AdjList(:,1) AdjList(:,2)],[AdjList(:,2) AdjList(:,1)],ones( 2*size(AdjList,1) , 1 ),numNodes,numNodes);