function [newMat] = removeRowsWith(Mat,val)
% Input: an n-by-2 matrix Mat and a value val
% Output: a matrix of all the rows of Mat that do NOT contain val

newMat = Mat;

rowsToRemove = Mat(:,1) == val;
newMat(rowsToRemove,:) = [];

rowsToRemove = Mat(:,2) == val;
newMat(rowsToRemove,:) = [];
