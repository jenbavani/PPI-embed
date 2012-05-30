

% Read in adjacency file
[col1,col2] = textread('yeastPPI-HC.txt','%s%s%*[^\n]');

% Make a list of all the proteins
names = {};
for i = 1:size(col1,1)
    elt = col1{i};
    if sum(strcmp(elt,names)) == 0
        names = add2cell(elt,names);
    end
    elt = col2{i};    
    if sum(strcmp(elt,names)) == 0
        names = add2cell(elt,names);
    end    
end
names = names';

% Create the adjacency list
nodenum = @(name) find(strcmp(name,names));
adjlist1 = cellfun(nodenum, col1);
adjlist2 = cellfun(nodenum, col2);
size(adjlist1)
adjlist = [adjlist1 adjlist2];
adjmat = sparse(adjlist);