nPts = 100;

figure;
hold on;

for noise = 0:.1:.5
    [g,p] = geoRandGraphEps(nPts,.25,2);
    size(g)
%     dists = allDistances(p);
%     mNoise = noise*rand(size(dists))-.5*noise;
%     dists = dists + mNoise;
     dists = graphallshortestpaths(g);
     dists = dists.^(1/2);
    % dists(dists>2) = 5;

    % Embed using SMACOF.
    % javaaddpath('/Users/vkrishnan/Documents/research/PPI-embed/MDS/mdscale.jar');
    % EMBEDDING = mdscale.MDS.distanceScaling(dists,2);
    % EMBEDDING = EMBEDDING';

    % Embed using Higham's MDS method.
     EMBEDDING = highamEmbed(dists,2);
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
    for i = 1:n
        eps = epsilons(i);
        ng = and ( new_dists<eps , ~eye(nPts) );
        TP(i) = sum(sum(and(g,ng)));
        FP(i) = sum(sum(and(~g,ng)));
        FN(i) = sum(sum(and(g,~ng)));
        TN(i) = sum(sum(and(~g,~ng)));
    end
    clear ng eps;

    specificity = TN ./ ( TN + FP);
    sensitivity = TP ./ ( TP + FN);

    plot(1-specificity,sensitivity);
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
