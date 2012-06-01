% Unit test for embedAndEval

vNoise = 0:.1:.5;
stress = zeros(size(vNoise,2),4);
loss = zeros(size(vNoise,2),4);

for i=1:size(vNoise,2)
    
    for j = 1:4
    
        [g,p] = geoRandGraph(100,250,3);
        d = allDistances(p);
        noise = uNoiseMat(0,vNoise(i),size(g));
        d = d + noise;
        [e,l,s,ng,nd]=embedAndEval(g,d,3);
        stress(i,j) = s;
        loss(i,j) = l;
    end
    
end
    