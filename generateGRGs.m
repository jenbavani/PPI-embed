function [prefix] = generateGRGs(numNodes,numEdges,dims,iters)

if nargin < 3
    dims = 3;
end

if nargin < 4
	iters = 10;
end

prefix = ['data' filesep 'GRG' num2str(dims) 'd-' num2str(numNodes) 'v-' ];
prefix = [prefix num2str(numEdges) 'e-'];

for iter = 1:iters
    msg = [num2str(dims) 'd, iteration ' num2str(iter) ] 
    [graph,points] = geoRandGraph(numNodes,numEdges,dims);
    neighborcounts = dthOrdCommonNeighbors(graph,20);
    filename = [prefix num2str(iter) '.mat'];
    save(filename,'graph','points','neighborcounts');
end