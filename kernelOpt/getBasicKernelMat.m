% From 
%    http://www.ittc.ku.edu/~xwchen/BMCbioinformatics/kernel/kernelOptimization.m
% which is an implementation of the method described in
%    Kernel-based distance metric learning for microarray data classification
%    Huilin Xiong and Xue-wen Chen, BMC Bioinformatics 2006

function [bMat,wMat]=getBasicKernelMat(kernelMat,classFlags)

matSize=length(classFlags);
classNub2=length(find(classFlags>0));
classNub1=matSize-classNub2;

betweenMat=zeros(matSize,matSize);
betweenMat(1:classNub1,1:classNub1)=(1.0/classNub1)*kernelMat(1:classNub1,1:classNub1);
betweenMat((classNub1+1):matSize,(classNub1+1):matSize)=(1.0/classNub2)*kernelMat((classNub1+1):matSize,(classNub1+1):matSize);

wMat=diag(diag(kernelMat))-betweenMat;
bMat=betweenMat-(1.0/matSize)*kernelMat;