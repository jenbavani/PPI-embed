function distMat=koDistMat(alpha,k0,K1)

% Based on
%    Kernel-based distance metric learning for microarray data classification
%    Huilin Xiong and Xue-wen Chen, BMC Bioinformatics 2006

q = K1 * alpha;
Q = diag(q);
K = Q*k0*Q;
k = diag(K);


% d(x,y) = k(x,x) + k(y,y) - 2k(x,y)
kxx = k * ones(size(k))';
kyy = kxx';
distMat = kxx + kyy - 2K;
