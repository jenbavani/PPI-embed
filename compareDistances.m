
% dimsToTry = [3 4 5 6];
% dmax = 10;
% 
% %% Load in yeast data and get parameters
% load(['.' filesep 'data' filesep 'yeastHC.mat'],'yeastgraph');
% nPts = size(yeastgraph,1);
% nEdges = sum(yeastgraph(:))/2;
% 
% 
% %% Generate geometric random graphs
% 
% prefix = cell(size(dimsToTry));
% for i=1:size(dimsToTry,2)
%     prefix{i}=generateGRGs(nPts,nEdges,dimsToTry(i),4);
% end
% % Each file has the following variables stored:
% % 'graph','points','neighborcounts'
% 
% %% Develop distance metrics
% 
% for i = 1:size(dimsToTry,2)
%     [P, P2] = predmat(prefix{i},dmax,4);
%     cnDistMat1(:,:,i) = P;
%     cnDistMat2(:,:,i) = P2;
% end
% 
% %% Set up for comparisons
% nGraphs=5 
% colors = 'rgbcmyk';
% auroc = zeros(4,nGraphs);
% auprc = zeros(4,nGraphs);
% 
% figure;
% hold on;
% 
% graphs = cell([1 nGraphs]);
% dists = cell([4 nGraphs]);
% neighbors = cell([1 nGraphs]);
% lowords = cell([1 nGraphs]);
% 
% nDists = nPts^2;
% intervals = 1000:1000:nDists;
% specificity = zeros(size(intervals(:),1),2,nGraphs);
% sensitivity = zeros(size(intervals(:),1),2,nGraphs);
% precision = zeros(size(intervals(:),1),2,nGraphs);

%% Load in and preprocess random graphs
for g=1:nGraphs-1
    load([prefix{1} num2str(g) '.mat'])
    graphs{g}=graph;
    neighborcounts(:,:,dmax+1) = ones(nPts) - eye(nPts);
    neighborcounts(:,:,dmax+2) = eye(nPts);  
    neighbors{g} = neighborcounts;
    lowestOrd = zeros(nPts);
    lowOrd = @(i,k) find(neighborcounts(i,k,1:12),1);
    for i=1:nPts
        for k=1:nPts
            lowestOrd(i,k) = lowOrd(i,k);
        end
    end
    lowords{g} = lowestOrd;
end

%% Preprocess yeast graph
graphs{nGraphs} = yeastgraph;
neighborcounts = dthOrdCommonNeighbors(yeastgraph,20);
neighborcounts(:,:,dmax+1) = ones(nPts) - eye(nPts);
neighborcounts(:,:,dmax+2) = eye(nPts);  
neighbors{nGraphs} = neighborcounts;
lowestOrd = zeros(nPts);
lowOrd = @(i,k) find(neighborcounts(i,k,1:12),1);
for i=1:nPts
    for k=1:nPts
        lowestOrd(i,k) = lowOrd(i,k);
    end
end
lowords{nGraphs} = lowestOrd;
clear yeastgraph;

%     dists = allDistances(p);
%     mNoise = noise*rand(size(dists))-.5*noise;
%     dists = dists + mNoise;
for i=1:nGraphs
     g = graphs{i};
     d = graphallshortestpaths(g);
     d(d>4) = 5;
     dists{i}{1}=d;
     d = d.^(1/2);
     dists{i}{2}=d;
     % dists(dists>2) = 5;
     
     cnd = zeros(nPts);
     cnd2 = zeros(nPts);
     for d = 1:12
         Nd = neighbors{g}(:,:,d);
         m = P(d,1);
         b = P(d,2);
         cnd(lowords{j}==d) = m.*Nd(lowords{j}==d) + b;
         m2 = P2(d,1);
         b2 = P2(d,2);
         cnd2(lowords{j}==d) = m2.*Nd(lowords{j}==d) + b2;
    end
    m = max(max(cnd));
    cnd(cnd+eye(nPts)==0) = 3*m;
    dists{3}{j} = cnd;
    m = max(max(cnd2));
    cnd2(cnd2+eye(nPts)==0) = 3*m; 
    dists{4}{j} = cnd2;
    
     for j=1:4
        
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


        specificity(:,j,i) = TN ./ ( TN + FP);
        sensitivity(:,j,i) = TP ./ ( TP + FN);
        precision(:,j,i) = TP ./ (TP + FP);
        
        auroc = auc(1-specificity,sensitivity);
        auprc = auc(sensitivity,precision);

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
