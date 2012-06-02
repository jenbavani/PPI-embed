load(['.' filesep 'data' filesep 'yeastHC.mat'],'yeastgraph');
nPts = size(yeastgraph,1);
colors = 'rgbcmyk';


figure;
hold on;

noise = 0:.1:.5;
numGraphs=size(noise(:),1)+1;
graphs = cell(numGraphs,1);
dists = cell(numGraphs,2);

for i=1:size(noise(:),1)
    n = noise(i);
    [g,p] = geoRandGraphEps(nPts,.25,2);
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

        % Embed using SMACOF.
        % javaaddpath('/Users/vkrishnan/Documents/research/PPI-embed/MDS/mdscale.jar');
        % EMBEDDING = mdscale.MDS.distanceScaling(dists,2);
        % EMBEDDING = EMBEDDING';

        % Embed using Higham's MDS method.
        EMBEDDING = highamEmbed(dists{i}{j},2);
        size(EMBEDDING)

        % Get new distances and discover edges.
        new_dists = allDistances(EMBEDDING);

        dflat = new_dists(:);
        dflat = sort(dflat);
        epsilons = dflat(1:2:size(dflat));
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


        specificity = TN ./ ( TN + FP);
        sensitivity = TP ./ ( TP + FN);
        recall = sensitivity;
        precision = TP ./ (TP + FP);

        plot(1-specificity,sensitivity,'Color',colors(mod(i,7)+1));

        plot(recall,precision,'Color',colors(mod(i,7)+1));
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
