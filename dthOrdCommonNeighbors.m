function [MAT] = dthOrdCommonNeighbors(ADJMAT,D)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Returns an n-by-n-by-d matrix that contains the number of dth order 
% common neighbors each pair of nodes has, from d = 1 to D.
%
% dth order neighbors are nodes which are within a graph distance of d 
%     from both nodes.
%
% INPUTS:
% ADJMAT = the graph under consideration, in sparse matrix form
% D = the max order (d) to consider
%
% OUTPUT:
% [MAT] = dthOrdCommonNeighbors(ADJMAT,D)
%  --> MAT(i,j,k) = the # of kth order common neighbors shared by nodes
%                   i and j.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

apsp = graphallshortestpaths(ADJMAT);
n = size(apsp,1);
pathmat = zeros(n);

for k = 1:D
    pathmat(apsp<=k)=1;
    numNeighbors = @(i,j) sum( pathmat(i,:).*pathmat(j,:) );
    for i = 1:n
        for j = 1:n
            MAT(i,j,k) = numNeighbors(i,j);
        end
    end
end
