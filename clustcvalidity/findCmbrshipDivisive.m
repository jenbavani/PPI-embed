%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function [best_cmbrship, best_cvi, cluster_vals] = findCmbrshipDivisive(D, type, max_clusters, distfcn)
%
% Description: implementation of DIANA, divisive hierarchical clustering algorithm.
%              find clusters of the highest cluster
%              validity index value%              
%
% Input: 
%    D: n-by-p matrix of input data. Each row is observation and each
%    column is a feature
%    max_clusters: maximum number of clusters to be tested
%    disfcn: distance function, e.g. 'euclidean' for Euclidean distance
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [best_cmbrship, best_cvi, cluster_vals] = findCmbrshipDivisive(D, type, max_clusters, distfcn)

best_cmbrship = repmat(1,size(D,1),1);   % cluster membership, initially all data objects belong to one cluster
cmbrship = best_cmbrship;
best_cvi = -inf;
cluster_vals = NaN;
distM = computeDistanceMatrix(D,distfcn);

for num_clusters = 2:max_clusters 
    % find the largest cluster    
    cid = findLargestDiameterClusterId(cmbrship, distM, type);  % type 'avg': average diamter, 'complete': complete diameter
    mbrIds = find(cid == cmbrship); % data object ids of the largest cluster
    if length(mbrIds) == 1
        break;
    end;
    
    cmbrship_tmp = splitCluster(distM, mbrIds, cmbrship(mbrIds), max(cmbrship));
    cmbrship(mbrIds) = cmbrship_tmp;      
    s = silhouette(D,cmbrship);
    cvi = mean(s);
    cluster_vals = [cluster_vals;cvi];      
  
    if cvi > best_cvi   
        best_cvi = cvi;
        best_cmbrship = cmbrship;
    end; 
end;

% find the cluster id of the largest diameter
function out = findLargestDiameterClusterId(cmbrship, distM, type)

out = NaN;

clusterIds = [min(cmbrship):max(cmbrship)];
diameters = [];
for cid = clusterIds
    mbrs = find(cid == cmbrship);
    if length(mbrs) == 1
        diameters = [diameters 0];
        continue;
    end;
    
    diam = computeDiameter(mbrs, distM, type);
    diameters = [diameters diam];    
end;    

[C,I] = max(diameters);
out = clusterIds(I);

% compute the diameter of the given cluster
function out = computeDiameter(mbrs, distM, type)

out = NaN;

switch type
    case 'avg'
        dists = [];
        restIds = [];
        for i=mbrs'
            restIds = mbrs(find(i ~= mbrs));
            d = sum(distM(i,restIds));
            dists = [dists d];
        end;    
        out = sum(dists)/(length(mbrs)*(length(mbrs)-1));
        
    otherwise
        error('Invalide diameter type');
end;        

% assign a membership to each data object by splitting the input cluster
% into two clusters
function out = splitCluster(distM, mbrIds, cmbrship, max_curr_clusterId)

out = cmbrship;
splinter_group = [];
nonsplinter_group = mbrIds;

% find the initial member of the splinter group
dist_diff = [];
for i = 1:length(nonsplinter_group)
    tmp_nonsg = nonsplinter_group(find(nonsplinter_group(i) ~= nonsplinter_group))';
    dist_diff = [dist_diff mean(distM(nonsplinter_group(i), tmp_nonsg))]; 
end;
    
[C,I] = max(dist_diff);
splinter_group = nonsplinter_group(I);

% find the next members of the splinter group
nonsplinter_group = nonsplinter_group(find(splinter_group ~= nonsplinter_group));   % remove the initial member of the splinter group from the nonsplinter group
for i = 1:length(nonsplinter_group)    
    tmp_nonsg = nonsplinter_group;
    tmp_nonsg(i) = NaN;    
    tmp_nonsg = tmp_nonsg(find(~isnan(tmp_nonsg)))';    
    mean_dist_nonsplinter_group = mean(distM(nonsplinter_group(i), tmp_nonsg));
    mean_dist_splintergrp = mean(distM(nonsplinter_group(i), splinter_group)); 
    if (mean_dist_nonsplinter_group - mean_dist_splintergrp) > 0 
        splinter_group = [splinter_group;nonsplinter_group(i)];
        nonsplinter_group(i) = NaN;
    end;    
end;

for i=1:length(splinter_group)
    idx = find(splinter_group(i) == mbrIds);
    out(idx) = max_curr_clusterId + 1;
end;