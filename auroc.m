function [area] = auroc(X,Y)
% Find the area under the ROC curve defined by X,Y

Y(isnan(Y))=0;
n = max(size(X));

w = diff(X);
h = Y(1:n-1)+.5*(diff(Y));
area = sum (w(w>0) .* h(w>0));