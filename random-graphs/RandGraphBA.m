function [edges] = RandGraphBA(n,m)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate an Barbasi-Albert type random graph
% with average initial degree = m (most interesting vals are m<1)
%
% INPUT:
% n - the number of nodes
% m - average initial degree
%
% OUTPUT:
% edges - an adjacency list representation of a graph
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Seed the process with an ER-type graph
edges = RandGraphER(10,0.4);
nodes = 1:10;
nodes = nodes';


% Add nodes with starting degree ~m
newNode = size(nodes,1) + 1
newNodeDeg = rand(1)*2m % Drawn unif @ random from (0,2m)


nodes = 1:n;
nodes = nodes';
r = rand(n,1);
m = max(r);
edges = []

% Set up the CDF
% Note: for k>=1, pk = k^(-alpha)/zeta(alpha)
z = zeta(alpha)
cum_p = [0]
while m > cum_p
    k = size(cum_p,1)+1;
    pk = (k^(-alpha))/z;
    cum_p = [cum_p ; cum_p(k-1) + pk]
end

% Generate the degree distribution
degs = arrayfun(@(x) sum(cum_p<x),r);
cum_degs = arrayfun(@(x) sum(cum_p(1:x)),degs);

% Add edges to the graph at random
while max(cum_degs)>0
    if find(cum_degs)==1
        % remove an edge at random and add it back to the pool
        e = randi(size(edges, 1));
        oldEdge = edges(e,:);
        edges(e,:) = [];
        continue
    end
    
    m = max(cum_degs);
    r1 = randi(m);
    r2 = randi(m);
    v1 = sum(r1>=cum_degs);
    v2 = sum(r2>=cum_degs);
    if v1=v2
        continue
    end
    newEdge = [ v1 v2 ];
    edges = [edges ; newEdge]
end



