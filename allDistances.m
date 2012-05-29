function [D] = allDistances(M1,M2)
% D(i,j) = the distance between row i of M1 and row j of M2


for i = 1:size(M1,1)
    D(i,1:size(M2,1)) = distFromAll(M1(i,:),M2);
end