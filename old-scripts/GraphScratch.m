
% Read in an adjacency list and set the appropriate entries in M.
msg='Getting adjacency list'
AdjList = dlmread('AllNodeNumAdj.tsv','\t');
msg='Converting to adjacency matrix'
adjmat = AdjListToMat(AdjList);

% Read in the protein names.
msg='Getting protein names'
fid=fopen('AllNodeNums.tsv');
names = textscan(fid,'%s%*d');
names = names{1};
fclose(fid);

% Get the connected components of adjmat
msg='Finding connected components'
[numComps,comps] = graphconncomp(adjmat);
numComps=numComps

% Find the largest component
[maxCompSize,maxCompIdx] = max(hist(comps,1:numComps));

% Remove all other compenents
msg='Removing unconnected nodes'
AdjListConn = AdjList;
namesConn = names;
nodesToRemove = find(comps-maxCompIdx); % Find all in comps != maxCompIdx

for i = numel(nodesToRemove):-1:1
    ntr = nodesToRemove(i)
    maxNode = size(namesConn,1)
    AdjListConn = removeRowsWith(AdjListConn, ntr);
    AdjListConn(AdjListConn == maxNode) = ntr;
    %size(AdjListConn,1)
    ptr = namesConn(ntr)
    namesConn(ntr) = namesConn(maxNode);
    namesConn(maxNode) = [];
end

adjmatconn = AdjListToMat(AdjListConn);

% Create the shortest paths matrix
[size(adjmatconn,1) nnz(adjmatconn)]
msg='Calculating Euclidean distance matrix'
distMatEuc = graphallshortestpaths(adjmatconn);
msg='Getting Stats on the distance matrix'
dflat = reshape(distMatEuc, 1, numel(distMatEuc));
distHistEuc = hist(dflat, 0:max(dflat));

msg='Calculating Euclidean distance matrix'
distMatSqrt = distMatEuc .^ 0.5;
msg='Getting Stats on the Square Root distance matrix'
dflat = reshape(distMatSqrt, 1, numel(distMatSqrt));
[distHistSqrt,dHPosSqrt] = hist(dflat);

% Embed each in 3-space using classical MDS
msg='Running MDS'
embedSqrt = cmds(distMatSqrt,3);
embedEuc = cmds(distMatEuc,3);

save('embeddedDataSqrt.mat','embedSqrt','namesConn','adjmatconn','distHistSqrt','dHPosSqrt');
clear('embedSqrt','distHistSqrt');

save('embeddedDataEuc.mat','embedEuc','namesConn','adjmatconn','distHistEuc');
clear('embedEuc','distHistEuc');

msg='Calculating Common Neighbor distance matrices'
[distMatCNPL,distMatCNSqrt] = commonNeighborsDists(adjmatconn);

% Embed each in 3-space using classical MDS
msg='Running MDS'
embedCNPL = cmds(distMatCNPL,3);
dflat = reshape(distMatCNPL, 1, numel(distMatCNPL));
[distHistCNPL, dHPosCNP] = hist(dflat);

save('embeddedDataCNPL.mat','embedCNPL','namesConn','adjmatconn','distHistCNPL','dHPosCNP');
clear('embedCNPL','distHistCNPL');

embedCNSqrt = cmds(distMatCNSqrt,3);
dflat = reshape(distMatCNSqrt, 1, numel(distMatCNSqrt));
[distHistCNSqrt,dHPosCNS] = hist(dflat);

save('embeddedDataCNSqrt.mat','embedCNSqrt','namesConn','adjmatconn','distHistCNSqrt','dHPosCNS');
clear('embedCNSqrt','distHistCNSqrt');

% Make a scatter plot of the result
% scatter3(embedding(:,1),embedding(:,2),embedding(:,3))

for i=1:5
    for j=1:5
        for k=1:5
            ind = 9*i+3*j+k;
        end
    end
end



