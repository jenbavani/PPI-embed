function alpha=kernelOpt(trData,ecData,trTags,gamma0,gamma1,epsilon)

%% Adapted from 
%    http://www.ittc.ku.edu/~xwchen/BMCbioinformatics/kernel/kernelOptimization.m
% which is an implementation of the method described in
%    Kernel-based distance metric learning for microarray data classification
%    Huilin Xiong and Xue-wen Chen, BMC Bioinformatics 2006
%
% kernel optimization for binary-class data set. The class tags are supposed to be 0, 1.
% "trData": the matrix of the training data.
% "ecData": the matrix of the 'local centers'.
% "trTags": the class tags of the training data.
% "gamma0": the parameter in the basic Gaussian kernel function.
% "gamma1": the parameter in the supplementary Gaussian kernel function.
% "epsilon": the parameter in the disturbed resampling procedure.
% "alpha": the final optimized combination coefficients in out data-dependent kernel model.

%% Set up

% Read in data
trvData=trData;
% trvDim = dimensionality of each observation (# rows of trData)
% trvSize = number of observations (# cols of trData)
% trbSize = number of starting clusters??***
[trvDim,trvSize]=size(trData);
trbSize=size(ecData,2);

% default values, as given in paper
if nargin<6
    epsilon = 0; % epsilon is not used if there is no resampling
end
if nargin<4
    Nf = trvSize;
    gamma0 = 10^(-5)/(Nf)^.5;
    gamma1 = 10^(-2)/(Nf)^.5;
end

iterations=1000;
initialLearningRate=0.01;


%% Resampling -- relevant if there are relatively few observations
% [resData1,resIndex1]=resampling(trvData,trvSize);
% [resData2,resIndex2]=resampling(trvData,trvSize);
% 
% randn('state',sum(100*clock)); 
% trvData1=[trvData,resData1+epsilon*randn(size(trvData)),resData2+epsilon*randn(size(trvData))];
% trTags1=[trTags,trTags(resIndex1),trTags(resIndex2)];

%% Without resampling:
trvData1=trvData;
trTags1=trTags;

%% Step 1: Group data, calculate K_0;K_1 ; B_0,W_0 ; M_0,N_0

% Sort data according to classification (tag).
[trTags1,nIndex]=sort(trTags1);
trvData1=trvData1(:,nIndex);


% K_0: Gaussian
kernelMat1=exp(-gamma0*getDistanceMat(trvData1,trvData1));
% K_1 -- eqn (3)
suppKernelMat1=[ones(size(trvData1,2),1),exp(-gamma1*getDistanceMat(trvData1,ecData))];    

% K_0 -- eqn (5):
% B_0,cW_0
[betweenMat1,withinMat1]=getBasicKernelMat(kernelMat1,trTags1);
% M_0, N_0
bscMat1=suppKernelMat1'*betweenMat1*suppKernelMat1;
bscMat2=suppKernelMat1'*withinMat1*suppKernelMat1;

%% Step 2: Initialize alpha (coefficients)
alpha=zeros(size(ecData,2)+1,1);
alpha(1,1)=1.0;

%% Steps 3 and 4
for i=1:iterations      
   %% Step 3: Calculate q, J_1, J_2, J
   quasi1=suppKernelMat1*alpha;
   J1=quasi1'*betweenMat1*quasi1;
   J2=quasi1'*withinMat1*quasi1;
   
   %% Step 4: Update alpha^(n)
   currentLearningRate=initialLearningRate*(1.0-(i-1)/iterations);
   alpha=alpha+(currentLearningRate/J2/J2)*(J2*bscMat1-J1*bscMat2)*alpha;
   
   % Normalize alpha 
   alpha=(1.0/sqrt(alpha'*alpha))*alpha;   
end