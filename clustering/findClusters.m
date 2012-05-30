function [N C] = findClusters(AdjMat, thresh)

M = AdjMat;
cc = clusteringCoefficients(M);
M(:,cc<thresh) = 0;
M(cc<thresh,:) = 0;
m= sparse(M);
[ncomp, compvec] = graphconncomp(m);
h = hist(compvec, 1:ncomp);

clustervec = zeros(1,size(AdjMat,1));
validclusters = find(h-1);
clusternum = 0
for c = validclusters
    clusternum = clusternum + 1;
    clustervec(compvec==c) = clusternum;
end

N = clusternum;
C = clustervec;

    