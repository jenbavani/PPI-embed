function LOSS = graphLoss(GRAPH1,GRAPH2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Determine the "graph loss" from GRAPH1 to GRAPH2.
% Loss = | E1 XOR E2 | / ( 2*|E1| )
%
% INPUT:
% GRAPH1 - original graph
% GRAPH2 - new/recovered graph
% 
% OUTPUT:
% LOSS - see above
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LOSS = .5*sum(sum(xor(GRAPH1,GRAPH2)))/sum(sum(GRAPH1));
% note: both the numerator and denominator of the expression are double
% of the loss expression above; however, they cancel each other out.