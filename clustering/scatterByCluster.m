function scatterByCluster(M, clusters, dotsize)

colors = [ 1 0 0 ; 1 1 0 ; 0 1 0 ; 0 1 1 ; 0 0 1 ; 0 0 0 ];

C = zeros(size(M,1));
for i=1:7
    C(clusters==i,:) = colors