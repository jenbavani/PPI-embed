function distMat=koDistMat(data,alpha,k0,K1)

% Based on
%    Kernel-based distance metric learning for microarray data classification
%    Huilin Xiong and Xue-wen Chen, BMC Bioinformatics 2006

q = K1 * alpha;
Q = diag(q);
K = Q*k0*Q;
k = diag(K);


% d(x,y) = k(x,x) + k(y,y) - 2k(x,y)
distMat

dataSize1=size(data1,2);
dataSize2=size(data2,2);

dotProductMat=data1'*data2;
tempVect=diag(data1'*data1);
distanceMat=repmat(tempVect,1,dataSize2)-2.0*dotProductMat;
tempVect=diag(data2'*data2);
distanceMat=repmat(tempVect',dataSize1,1)+distanceMat;