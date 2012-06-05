function [P, P2] = predmat(prefix,dmax,iters)
%prefix = GRGb
%dmax = 10

P = zeros(dmax,2);
P2 = zeros(dmax,2);
LOall = [];
NCall = [];
Dall = [];

for iter = 1:iters
    filename = [prefix num2str(iter) '.mat']
    load(filename);
    dists = allDistances(points,points);
    num_nodes = size(graph,1);
    neighborcounts(:,:,dmax+1) = ones(num_nodes) - eye(num_nodes);
    neighborcounts(:,:,dmax+2) = eye(num_nodes);
    lowestOrd = zeros(num_nodes);
    lowOrd = @(i,j) find(neighborcounts(i,j,1:dmax+2),1);
    for i=1:num_nodes
        for j=1:num_nodes
            lowestOrd(i,j) = lowOrd(i,j);
        end
    end
    LOall(:,:,iter) = lowestOrd;
    NCall(:,:,:,iter) = neighborcounts;
    Dall(:,:,iter) = dists;
end

Dall(1:10,1:10,1)
NCall(1:10,1:10,1:4,1)
LOall(1:10,1:10,1)

for d = 1:dmax+2
    Nd = NCall(:,:,d,:);
    P(d,:) = polyfit(NCall(LOall==d),Dall(LOall==d),1);
    vals2 = Dall( NCall(LOall==d)==2);
    avg2 = mean(vals2);
    vals5 = Dall( NCall(LOall==d)==5);
    avg5 = mean(vals5);
    m = (avg5 - avg2) / (5-2);
    b = avg5 - m*5;
    P2(d,1) = m;
    P2(d,2) = b;
end
