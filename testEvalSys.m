t = 2;
g = 10;

% Load in and collect graphs.
% graphs is a 1-by-g cell of graphs.
graphs = cell([1 g]);
neighbors = cell([1 g]);
origpoints = cell([1 g]);
for j = 1:g
    [graph,points] = geoRandGraph(100,250);
    neighborcounts = dthOrdCommonNeighbors(graph,20);
    graphs{j} = graph;
    neighbors{j} = neighborcounts;
    origpoints{j} = points;
    fn = ['GRG-100v-250e-' num2str(j) '.mat' ]
    save(fn,'graph','points','neighborcounts');
end

% distmats is a t-by-g cell of distance matrices.
% t=1 :: path length
% t=2 :: square root of path length
distmats = cell([t g]);
for j = 1:g    
    dists = graphallshortestpaths(graphs{j});
    m = max(max(dists~=Inf));
    dists(dists==Inf) = 3*m;
    distmats{1}{j} = dists;
    distmats{2}{j} = dists.^(1/2);
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

