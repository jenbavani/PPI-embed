%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   
%
% Description: find clusters using agglomerative hierarchical clustering
%
% Input:
%    D: n-by-p matrix of input data
%
% Output:
%    best_cmbrship: best cluster memberhsip
%    best_cvi: best cluster validity index value
%    cluster_vals: the cluster validity index values of each number of
%    clusters tested
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [best_cmbrship, best_cvi, cluster_vals] = findCmbrshipAgglomerative(D, max_clusters)

best_cmbrship = []; 
best_cvi = -inf;
cluster_vals = NaN;

for num_clusters = 2:max_clusters 
    Y = pdist(D); 
    Z = linkage(Y);    
    cmbrship = cluster(Z,'maxclust',num_clusters);
    s = silhouette(D,cmbrship);
    cvi = mean(s);
    cluster_vals = [cluster_vals;cvi];
    
    if cvi > best_cvi
        best_cvi = cvi;
        best_cmbrship = cmbrship;        
    end;    
end;