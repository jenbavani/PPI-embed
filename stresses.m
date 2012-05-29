function [S,X] = stresses(GRAPH)

dists(:,:,1) = graphallshortestpaths(GRAPH);
dists(:,:,2) = dists(:,:,1).^(.5);

n = size(dists,1)
nc = dthOrdCommonNeighbors(GRAPH,10);
REGMAT = [   -0.0173    0.1003;
   -0.0136    0.1640;
   -0.0168    0.2450;
   -0.0167    0.3051;
   -0.0110    0.3393;
   -0.0103    0.3808;
   -0.0079    0.4096;
   -0.0108    0.4629;
   -0.0096    0.4900;
   -0.0079    0.5190];
temp = [];
for i=1:n  
    temp(:,i) = arrayfun( @(j) geoneighbordist(i,j,GRAPH,nc,REGMAT) , 1:n);
end
dists(:,:,3) = temp;

javaaddpath('/Users/vkrishnan/Documents/research/harc/MDS/mdscale.jar');

for i=1:size(dists,3)
    x = mdscale.MDS.distanceScaling(dists(:,:,i),3);
    X(:,:,i) = x;
    S(i)=mmdsStress(x,dists(:,:,i));
end
    