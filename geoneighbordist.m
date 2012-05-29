function DIST = geoneighbordist(i,j,GRAPH,NC,REGMAT)

d = 1;
while NC(i,j,d)<=1 & d<10 
    d = d+1;
end

mb = REGMAT(d,:);
DIST = mb(1)*d +mb(2);
