function [AdjMat,names] = loadGraph(AdjListFile,NodeNameFile)
% Read in a graph

% Read in an adjacency list and set the appropriate entries in M.
AdjList = dlmread(AdjListFile,'\t');

% Create a matrix of appropriate size
% This will be the adjacency matrix.
AdjMat = zeros(max(max(AdjList)));

AdjMat( size(AdjMat,1)*(AdjList(:,2)-1)+AdjList(:,1) ) = 1;
AdjMat( size(AdjMat,1)*(AdjList(:,1)-1)+AdjList(:,2) ) = 1;

% Read in the node names.
fid=fopen(NodeNameFile);
names = textscan(fid,'%s%*d');
names = names{1};
fclose(fid);