function [adjMat,names] = readInAdjList(filename)
%% Read in an adjacency list of node names from a .tsv
%  and store the result as an UNDIRECTED graph
% 
%  Usage:
%  [adjMat,names] = readInAdjList(filename)
%  
%  filename = tsv file with adj. list (one edge per line)
%  adjMat = the undirected graph, in sparse matrix form
%  names = a 1-by-n cell array of node names 
%
%  by J. Bavani Kehoe
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Read in the adjacency list
[sources,dests] = textread(filename, '%s %s');

%% Replace node names with node numbers
nEdges = max(size(sources));
edges = zeros(nEdges,2);

names = cell(0);

for e = 1:nEdges
    
    src = getNodeNum(sources{e});
    dst = getNodeNum(dests{e});
    edges(e,:) = [ src dst ] ;
    
end

%% Generate the adjacency matrix
adjMatFull = zeros(max(size(names)));
for e = 1:nEdges
    src = edges(e,1);
    dst = edges(e,2);
    adjMatFull(src,dst) = 1;
    adjMatFull(dst,src) = 1;
end
adjMat = sparse(adjMatFull);

    %% Helper function
    function nodeNum = getNodeNum(nodeName)
        pos = strcmp(nodeName,names);
        if sum(pos) == 0
            names(add2cell(nodeName));
            nodeNum = max(size(names));
        else
            nodeNum = find(pos);
        end
    end %end getNodeNum

end % end readInAdjList

