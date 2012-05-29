d = [4 5 10 15 20];
numNodes = 988;
numEdges = 2454;
losses_all = zeros(4,11,5);
stresses_all = zeros(4,11,5);

for i = 1:size(d,2)
    prefix = ['GRG' num2str(d(i)) 'd-' num2str(numNodes) 'v-' ];
    prefix = [prefix num2str(numEdges) 'e-'];
    [embeds, losses, stresses] = evalGRGset(prefix,'yeastHC.mat');
    losses_all(:,:,i) = losses;
    stresses_all(:,:,i) = stresses;
end

%% To Do:
%% polyfit higher degree poly (3?)
%% embed in higher dims

% flat = @(M)reshape(M,size(M,1)*size(M,2),1);
% 
% for iter = 1:10
% 
%     % Load in data set.
%     filename = ['GRG-d20-' num2str(iter) '.mat']
%     load(filename);
%     MAT = {};
%     
%     % Calculate pairwise distances.
%     dists = allDistances(points,points);
% 
%     % Get the distance stats by # dth order common neighbors.
%     % MAT(n,:,d) = [ index mean stddev ]:
%     % n = number of dth order common neighbors
%     % mean, stddev of average distance
%     
%     m = max(max(max(neighborcounts)))
%     for n = 1:20
%         n=n
%         temp = [];
%         temp(:,1) = 0:m;
%         temp(:,2)=arrayfun(@(idx) mean(flat(dists(neighborcounts(:,:,n)==idx))),temp(:,1));
%         temp(:,3)=arrayfun(@(idx) std(flat(dists(neighborcounts(:,:,n)==idx))),temp(:,1));
%         temp(:,4)=arrayfun(@(idx) sum(sum(neighborcounts(:,:,n)==idx)),temp(:,1));
%         MAT{n} = temp;
%     end
%     allMATs{iter} = MAT;
% end
% 
% %Combine distance stats
% 
% maxheight = @(c) max(cellfun(@(cll) size(cll,1),c));
% maxNN= max(cellfun(@(cll) maxheight(cll),allMATs))
% 
% cumMAT(:,1) = 0:maxNN;
% 
% for d = 1:20
%     d=d
%     cumMAT(:,1,d) = 0:maxNN;
%     for nn = 0:maxNN
%         cumtot = 0;
%         cumvar = 0;
%         count = 0;
%         for iter = 1:10
%             if maxheight(allMATs{iter}) > nn
%                 stats = allMATs{iter}{d}(nn+1,:); % 0 vs 1 indexing
%                 cumtot = cumtot + stats(2)*stats(4);
%                 cumvar = cumvar + (stats(3)^2)*stats(4);
%                 count = count + stats(4);
%             end
%         end
%         cumMAT(nn+1,4,d) = count;        
%         if count > 0 
%             cumMAT(nn+1,2,d) = cumtot/count;
%             cumMAT(nn+1,3,d) = cumvar/count;
%         else
%             cumMAT(nn+1,2,d) = 0;
%             cumMAT(nn+1,3,d) = 0;
%         end
%     end
% end
% 
% save('cumGRG.mat','cumMAT')

% figure;
% hold on;
% colors = {'r' 'b' 'm' 'c' 'g' 'k' 'y'};
% for n = 1:8
%     c = colors{mod(n,7)+1};
%     errorbar(cumMAT(:,1,n),cumMAT(:,2,n),cumMAT(:,3,n),c);
% end
% 
% figure;
% hold on;
% colors = {'r' 'b' 'm' 'c' 'g' 'k' 'y'};
% for n = 1:8
%     c = colors{mod(n,7)+1};
%     plot(cumMAT(:,1,n),cumMAT(:,2,n),c);
% end
