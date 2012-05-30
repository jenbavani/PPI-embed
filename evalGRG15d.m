t = 4;
g = 11;
dmax=10;

% Load in and collect graphs.
% graphs is a 1-by-g cell of graphs.
graphs = cell([1 g]);
neighbors = cell([1 g]);
lowords = cell([1 g]);

for j = 1:g-1
    fn = ['GRG15d-988v-2454e-' num2str(j) '.mat' ]
    load(fn,'graph','points','neighborcounts');
    graphs{j} = graph;
    num_nodes = size(graph,1);
    neighborcounts(:,:,dmax+1) = ones(num_nodes) - eye(num_nodes);
    neighborcounts(:,:,dmax+2) = eye(num_nodes);    
    neighbors{j} = neighborcounts;
    lowestOrd = zeros(num_nodes);
    lowOrd = @(i,k) find(neighborcounts(i,k,1:12),1);
    for i=1:num_nodes
        for k=1:num_nodes
            lowestOrd(i,k) = lowOrd(i,k);
        end
    end
    lowords{j} = lowestOrd;
end

load('yeastHC.mat');
graphs{g} = yeastgraph;
neighborcounts = dthOrdCommonNeighbors(yeastgraph,20);
neighborcounts(:,:,dmax+1) = ones(num_nodes) - eye(num_nodes);
neighborcounts(:,:,dmax+2) = eye(num_nodes);  neighbors{g} = neighborcounts;
lowestOrd = zeros(num_nodes);
lowOrd = @(i,k) find(neighborcounts(i,k,1:12),1);
for i=1:num_nodes
    for k=1:num_nodes
        lowestOrd(i,k) = lowOrd(i,k);
    end
end
lowords{g} = lowestOrd;

% distmats is a t-by-g cell of distance matrices.
% t=1 :: path length
% t=2 :: square root of path length
% t=3 :: common neighbors distance

load('predmatGRGb.mat');
distmats = cell([t g]);
for j = 1:g    
    dists = graphallshortestpaths(graphs{j});
    num_nodes = size(dists,1);
    m = max(max(dists~=Inf));
    dists(dists==Inf) = 3*m;
    distmats{1}{j} = dists;
    distmats{2}{j} = dists.^(1/2);
    CNdists = zeros(num_nodes);
    CNdists2 = zeros(num_nodes);
    for d = 1:12
        Nd = neighbors{g}(:,:,d);
        m = P(d,1);
        b = P(d,2);
        CNdists(lowords{j}==d) = m.*Nd(lowords{j}==d) + b;
        m2 = P2(d,1);
        b2 = P2(d,2);
        CNdists2(lowords{j}==d) = m2.*Nd(lowords{j}==d) + b2;
    end
    m = max(max(CNdists));
    CNdists(CNdists+eye(num_nodes)==0) = 3*m;
    distmats{3}{j} = CNdists;
    m = max(max(CNdists2));
    CNdists2(CNdists2+eye(num_nodes)==0) = 3*m; 
    distmats{4}{j} = CNdists2;
end

% Embed and evaluate.
embeds = cell([t g]);
losses = zeros(t,g);
stresses = zeros(t,g);
for i = 1:t
    for j = 1:g
        [e,l,s] = embedAndEval(graphs{j},distmats{i}{j},3);
        embeds{i}{j} = e;
        losses(i,j) = l;
        stresses(i,j) = s;
    end
end

