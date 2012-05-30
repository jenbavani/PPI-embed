%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [bestCmbrship, bestCVI, cluster_vals] = findCmbrshipKmeans(D, max_clusters)
%
% Description: find clusters of the highest cluster validity index value using k-means clustering
%
% Input: 
%    D: n-by-p matrix of input data. Each row is observation and each column is a feature.
%    max_clusters: the maximum number of clusters to be tested
%
% Output:
%    bestCmbrship: the best cluster membership
%    bestCVI: the best cluster validity index value
%    cluster_vals: the cluster validity index values of each number of
%    clusters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [bestCmbrship, best_cvi, cluster_vals] = findCmbrshipKmeans(D, max_clusters, num_replicates)

bestCmbrship = [];
best_cvi = -inf;
cluster_vals = NaN;

for k=2:max_clusters
    cmbrship = kmeans(D, k,'replicates',num_replicates);
    s = silhouette(D,cmbrship);
    cvi = mean(s);    
    cluster_vals = [cluster_vals;cvi];
    
    if best_cvi < cvi
        best_cvi = cvi;
        bestCmbrship = cmbrship;        
    end;    
end;