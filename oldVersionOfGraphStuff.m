
% Read in an adjacency list and set the appropriate entries in M.
AdjList = dlmread('AllNodeNumAdj.tsv','\t');
numNodes = max(max(AdjList));
adjmat = sparse(AdjList(:,1);AdjList(:,2),
                AdjList(:,2);AdjList(:,1),
                ones(2*size(AdjList,1) , 1),
                numNodes,
                numNodes);

% Read in the protein names.
fid=fopen('AllNodeNums.tsv');
names = textscan(fid,'%s%*d');
names = names{1};
fclose(fid);

% Get the connected components of adjmat
[numComps,comps] = graphconncomp(adjmat);
numComps=numComps

% Find the largest component
[maxCompSize,maxCompIdx] = max(hist(comps,1:numComps));

% Remove all other compenents
AdjListConn = AdjList;
namesConn = names;
nodesToRemove = find(comps-maxCompIdx); % Find all in comps != maxCompIdx

for i = numel(nodesToRemove):-1:1
    ntr = nodesToRemove(i)
    AdjList(AdjList(:,1)==ntr,:) = []
    AdjList(AdjList(:,2)==ntr,:) = []
    ptr = names(ntr)
    namesConn(ntr) = [];
end

numNodes = max(max(AdjListConn));
adjmatconn = sparse(AdjListConn(:,1);AdjListConn(:,2),
                AdjListConn(:,2);AdjListConn(:,1),
                ones(2*size(AdjListConn,1) , 1),
                numNodes,
                numNodes);

% Create the shortest paths matrix
msg='Calculating distance matrix'
distMat = graphallshortestpaths(adjmatconn);
msg='Getting Stats on the distance matrix'
dflat = reshape(distMat, 1, numel(distMat));
n = hist(dflat, 0:max(dflat));

% Embed in 3-space using classical MDS
embedding = cmds(distMat,3);

% Make a scatter plot of the result
scatter3(embedding(:,1),embedding(:,2),embedding(:,3))

for i=1:5
    for j=1:5
        for k=1:5
            ind = 9*i+3*j+k;
            S(ind,1:3) = [b(i) b(j) b(k)];
        end
    end
end



