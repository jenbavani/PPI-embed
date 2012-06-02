load(['.' filesep 'data' filesep 'yeastHC.mat'],'yeastgraph');
nPts = size(yeastgraph,1);
nEdges = sum(yeastgraph(:))/2;
colors = 'rgbcmyk';


figure;
hold on;

noise = 0:.1:.5;
numGraphs=size(noise(:),1)+1;
graphs = cell(numGraphs,1);
dists = cell(numGraphs,2);

nDists = nPts^2;
intervals = 1000:1000:nDists;
specificity = zeros(size(intervals(:),1),2,numGraphs);
sensitivity = zeros(size(intervals(:),1),2,numGraphs);
precision = zeros(size(intervals(:),1),2,numGraphs);

for i=1:size(noise(:),1)
    n = noise(i);
    [g,p] = geoRandGraph(nPts,nEdges,3);
    graphs{i}=g;
end

graphs{numGraphs} = yeastgraph;
clear yeastgraph;

%     dists = allDistances(p);
%     mNoise = noise*rand(size(dists))-.5*noise;
%     dists = dists + mNoise;
for i=1:numGraphs
     g = graphs{i};
     d = graphallshortestpaths(g);
     d(d>4) = 5;
     dists{i}{1}=d;
     d = d.^(1/2);
     dists{i}{2}=d;
     % dists(dists>2) = 5;
    
     for j=1:2
        
        d=dists{i}{j};

        % Embed using SMACOF.
        javaaddpath('./MDS/mdscale.jar');
        EMBEDDING = mdscale.MDS.distanceScaling(d,3);
        EMBEDDING = EMBEDDING';

        % Embed using Higham's MDS method.
        % EMBEDDING = highamEmbed(dists{i}{j},2);
        size(EMBEDDING)

        % Get new distances and discover edges.
        new_dists = allDistances(EMBEDDING);

        dflat = new_dists(:);
        dflat = sort(dflat);
        epsilons = dflat(intervals);
        n = size(epsilons,1);
        TP = zeros(n,1);
        FP = zeros(n,1);
        FN = zeros(n,1);
        TN = zeros(n,1);
        for k = 1:n
            eps = epsilons(k);
            ng = and ( new_dists<eps , ~eye(nPts) );
            TP(k) = sum(sum(and(g,ng)));
            FP(k) = sum(sum(and(~g,ng)));
            FN(k) = sum(sum(and(g,~ng)));
            TN(k) = sum(sum(and(~g,~ng)));
        end


        specificity(k,j,i) = TN ./ ( TN + FP);
        sensitivity(k,j,i) = TP ./ ( TP + FN);
        precision(k,j,i) = TP ./ (TP + FP);

     end
end

hold off;

%     stress(j) = s;
%     loss(j) = l;


% load yeastHC.mat yeastgraph;
% dists = graphallshortestpaths(yeastgraph);
% m = max(dists(dists~=Inf))
% dists(dists>5) = 5;
% dists = dists.^(1/2);
% 
% % Embed and evaluate.
% 
% [e,l,s,ng,nd] = embedAndEval(yeastgraph,dists,2);
% stress(11) = s
% loss(11) = l
% 
% 
