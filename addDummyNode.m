function [newMat] = addDummyNode(Mat,exemptNode)
% Add a dummy node connected to everything except the specified node

numNodes = size(Mat,1);
newMat = [Mat ones(numNodes,1) ; ones(1,numNodes) 0];
newMat(numNodes+1,exemptNode) = 0;
newMat(exemptNode,numNodes+1) = 0;