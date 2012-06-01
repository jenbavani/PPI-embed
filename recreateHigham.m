% stress = zeros(10,1)
% 
% loss = zeros(10,1)




[g,p] = geoRandGraphEps(100,.25,2);
dists = graphallshortestpaths(g);
dists = dists.^(1/2);
% dists(dists>2) = 5;
[e,l,s,ng,nd]=embedAndEval(g,dists,2);
    
% Embed using mMDS.
javaaddpath('/Users/vkrishnan/Documents/research/PPI-embed/MDS/mdscale.jar');
EMBEDDING = mdscale.MDS.distanceScaling(dists,2);
EMBEDDING = EMBEDDING';

% Get new distances and discover edges.
new_dists = allDistances(EMBEDDING);

dflat = new_dists(:);
dflat = sort(dflat);
epsilons = dflat(1:size(dflat));
n = size(epsilons,1);
TP = zeros(n,1);
FP = zeros(n,1);
FN = zeros(n,1);
for i = 1:n
    eps = epsilons(i);
    ng = and ( new_dists<eps , ~eye(100) );
    TP(i) = sum(sum(and(g,ng)));
    FP(i) = sum(sum(and(~g,ng)));
    FN(i) = sum(sum(and(g,~ng)));
end

specificity = TP ./ ( TP + FP);
sensitivity = TP ./ ( TP + FN);

figure;
plot(1-specificity,sensitivity);

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
