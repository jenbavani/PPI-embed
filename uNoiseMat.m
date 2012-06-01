function [NOISEMAT] = uNoiseMat(mu,maxNoise,dims)

NOISEMAT = 2*maxNoise*rand(dims);
NOISEMAT = NOISEMAT + mu;