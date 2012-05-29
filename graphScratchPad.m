
% Create a matrix of appropriate size
% This will be the adjacency matrix.
AdjMat = zeros(13966);

% Read in an adjacency list and set the appropriate entries in M.
AdjList = dlmread('AllNodeNumAdj.tsv','\t');
AdjMat( size(AdjMat,1)*(AdjList(:,2)-1)+AdjList(:,1) ) = 1;
AdjMat( size(AdjMat,1)*(AdjList(:,1)-1)+AdjList(:,2) ) = 1;

% Read in the protein names.
fid=fopen('AllNodeNums.tsv');
names = textscan(fid,'%s%*d');
names = names{1};
fclose(fid);

% Represent M as a sparse matrix
adjmat = sparse(AdjMat);

% Get the connected components of m
[numComps,comps] = graphconncomp(adjmat);
numComps=numComps

% Find the largest component
[maxCompSize,maxCompIdx] = max(hist(comps,1:numComps));

% Remove all other compenents
AdjMatConn = AdjMat;
nodesToRemove = find(comps-maxCompIdx); % Find all in comps != maxCompIdx
for i = numel(nodesToRemove):-1:1
    ntr = nodesToRemove(i)
    AdjMatConn(ntr,:) = [];
    AdjMatConn(:,ntr) = [];
    ptr = names(ntr)
    names(ntr) = [];
end

% Represent Mconn as a sparse matrix
adjmatconn = sparse(AdjMatConn);

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



