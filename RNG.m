function [RNGedges] = RNG(V)
% Input: an M-by-N matrix V whose M rows represent M points in
%        N-dimensional space.
% Output: the RELATIVE NEIGHBORHOOD GRAPH of V. RNGedges is a 2-column
%        representation of the edges of the graph, as an adjacency list.
%        An row [i j] in RNGEdges means that the ith and jth points (rows)
%        from V are connected by an edge in the RNG.
%
% This implementation is based on the algorithm for V in R^d given in
%     A Note on Relative Neighborhood Graphs (Jaromczyk and Kowaluk, 1987)
% 
% Run Time: O(M^2), as long as there are no isoceles triangles.

% Initialization
E = [];
numNodes = size(V,1);

% Phase I: construct a supergraph
for i = 1:numNodes
    
    % Get a list of all the potential edges (i,k)    

    C = [ (1:numNodes)'  distFromAll(V(i,:),V) ];
    C(i,:) = [];
    % Columns of C are:
    % 1) values of k for which edge (i,k) are still under consideration
    % 2) dist(i,k)
    % 3*) dist(j,k) (*when present)

    while size(C,1) > 0
        minDist = min(C(:,2));
        j = C ( C(:,2) == minDist, 1);
        j = j(1);
        
        % Add edge (i,j) to the supergraph and remove it from C
        C(C(:,1)==j,:) = [];
        if size(C,1) == 0
            break
        end
        d = EuclidDist( V(i,:), V(j,:) );
        % maxMin is the greater of: 
        %   the min distance from another pt k to i
        %   the min distance from another pt k to j
        % where the edge (i,k) is still in C
        % if maxMin < d, then k is within the lune of (i,j)
        dik = (C (:,2) );
        djk = distFromAll( V(j,:) , V(C(:,1),:) );
        maxMin = max([ min(dik) min(djk) ]);
        edgeToAdd = [ i j d maxMin];
        if size(E,1) == 0
            E = edgeToAdd;
        else
            E = [ E ; edgeToAdd ]; 
        end
        
        % Remove edges (i,k) for which k is closer to j than to i
        C(:,3) = djk;
        C( C(:,2)>C(:,3) , :) = [];
        
        % Clear col 3 (get ready for a new j)
        C(:,3) = [];
    end
end

% Phase II: eliminate extraneous edges
% (That is, edges whose lunes are not empty)
E = E( E(:,3) <= E(:,4) , 1:2);
RNGedges = E;

