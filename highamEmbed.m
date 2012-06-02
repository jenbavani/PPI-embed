function [embed] = highamEmbed(dists,dim)
%
maxDist = dim^.5;
dists = dists/max(dists(:))*maxDist;

n = size(dists,1)
dsq = dists.^2;

% aij = -1/2 (dij - B - C + D)

B = arrayfun(@(i) sum(dsq(i,:))/n , 1:n);
C = arrayfun(@(j) sum(dsq(:,j))/n , 1:n);
D = sum(dsq(:))/(n^2)

A = zeros(n);

for i =1:n
    for j = 1:n
        A(i,j) = -.5*(dsq(i,j) - B(i) - C(j) + D);
    end
end

[U,T] = schur(A);
U = U';
X = T^.5 * U;
Xhat = real(X(1:dim,:));

xhatMins = min(Xhat')';
xhatMaxs = max(Xhat')';

for k = 1:dim
    for j = 1:n
        Xhat(k,j) = (Xhat(k,j) - xhatMins(k))/(xhatMaxs(k) - xhatMins(k));
    end
end

embed = Xhat';




