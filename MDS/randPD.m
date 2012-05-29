function pdMat = randPD(n)
[u,~,~] = svd(rand(n,n));
pdMat = u * diag(rand(n,1)) * u';