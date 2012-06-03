function distanceMat=getDistanceMat(data1,data2)

% From 
%    http://www.ittc.ku.edu/~xwchen/BMCbioinformatics/kernel/kernelOptimization.m
% which is an implementation of the method described in
%    Kernel-based distance metric learning for microarray data classification
%    Huilin Xiong and Xue-wen Chen, BMC Bioinformatics 2006

% Calcualting the distance matrix of data1 and data2. 
% Please note the size of row represents data's dimension.

dataSize1=size(data1,2);
dataSize2=size(data2,2);

dotProductMat=data1'*data2;
tempVect=diag(data1'*data1);
distanceMat=repmat(tempVect,1,dataSize2)-2.0*dotProductMat;
tempVect=diag(data2'*data2);
distanceMat=repmat(tempVect',dataSize1,1)+distanceMat;