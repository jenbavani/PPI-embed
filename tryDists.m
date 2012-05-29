function [LOSSES,STRESSES] = tryDists(GRAPHS,DISTS,WEIGHTS)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% [LOSSES,STRESSES] = tryDists(GRAPHS,DISTS)
% 
% Compare the embeddings of various graphs based on various distance
% metrics.
%
% INPUT:
% GRAPHS - a 1-by-g cell of graphs (sparse matrix representation)
% DISTS - a t-by-g cell of distance martices, where DISTS{i}{j} is the
% distance matrix found by applying distance metric i to graphs{j} 
% WEIGHTS - a t-by-g cell of weight matrices for mMDS
% 
% OUTPUT:
% LOSSES - t-by-g matrix of graph loss
% STRESSES - t-by-g matrix of stress on the distance matrix
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

g = size(GRAPHS,2);
t = size(DISTS,1);

LOSSES = zeros(t,g);
STRESSES = zeros(t,g);

for i = 1:t
    for j = 1:g        
        [E L S] = embedAndEvaluate(GRAPHS{j},DISTS{i}{j});
        LOSSES(i,j) = L;
        STRESSES(i,j) = S;
    end
end

