%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% function distM = computeDistanceMatrix(D,distfcn)
%
% Description: compute a distance matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function distM = computeDistanceMatrix(D,distfcn)

distM = [];

switch distfcn
    case 'euclidean'
        distM = repmat(NaN,size(D,1),size(D,1));
        for row = 1:size(D,1)
            for col = 1:size(D,1)
                if row == col
                    distM(row,col) = 0;
                elseif row < col
                    distM(row,col) = sqrt((sum((D(row,:) - D(col,:)).^2)));
                    distM(col,row) = distM(row,col);    
                end;
            end;
        end;    
    otherwise
        error('Invalid distance function.');
end;    