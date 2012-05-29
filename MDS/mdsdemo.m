% MDS examples

% randPD.m creates a random, positive definate matrix.
d = randPD(100);
% symmetrize.m makes a square matrix symmetric
% (the greater of conflicting values are used, and the diagonal is set to 0)
d = symmetrize(d);
% A common choice...
dim = 3;

% cmds.m does "classical scaling."
% d is the distance matrix and dim the output dimensionality.
X = cmds(d,dim);
%%
% mdscale.jar contains classes for "distance scaling" or SMACOF (scaling by majorizing a complex function).
% You can use it from MATLAB as follows:

% Add to MATLAB dynamic classpath
javaaddpath('path\to\mdscale.jar');
% Run for 10 minutes, 100 iterations or 0.001 relative change, whichever comes first
X = mdscale.MDS.distanceScaling(d,dim);
% Specify maximum iterations, relative change threshold (negative log; give 3 for 0.001) and timeouts (ms)
% defaults: iter = 100, thresh = 3, timeout = 10*60000
% X = mdscale.MDS.distanceScaling(d,dim,iter,thresh,timeout);
%%
% Or, finer control:
x = cmds(d,dim)'; % Initial coordinates, transpose for java
smacof = javaObject('mdscale.SMACOF',d,x); % equal weights
% Optional weight matrix w gives relative importance of points; 0 indicates a missing value.
smacof = javaObject('mdscale.SMACOF',d,x,w);

smacof.iterate(); % one iteration
Y = smacof.getPositions(); % current coordinates
Y = smacof.getNormalizedStress(); % current normalized stress

smacof.iterate(iter,thresh,timeout) % same as above