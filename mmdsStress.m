function S = mmdsStress(EMBED,DIST)

flat = @(M)reshape(M,size(M,1)*size(M,2),1);

avgdist = mean(flat(DIST))
ndist = DIST ./ avgdist; % normalized (original) distances
size(ndist)

edist = allDistances(EMBED,EMBED); % embedded distances
edist = edist ./ avgdist; % normalized embedded distances
size(edist)

stress = ndist - edist;
stress = stress.^2;
S = sum(sum(stress))/2;

