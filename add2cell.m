function [newcell] = add2cell(elt,oldcell)
% add an element to the end of a 1-dimensional cell
cellsize = max(size(oldcell));
newcell = oldcell;
newcell{cellsize+1} = elt;