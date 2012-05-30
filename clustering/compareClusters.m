function [memberships,cvis,hists] = compareClusters(D)

[k_memb, k_cvi, k_vals] = findCmbrshipKmeans(D, 10, 5);
[agg_memb, agg_cvi, agg_vals] = findCmbrshipAgglomerative(D, 10);
[div_memb, div_cvi, div_vals] = findCmbrshipDivisive(D, 'avg', 10, 'euclidean');

k_hist = hist(k_memb,1:max(k_memb));
agg_hist = hist(agg_memb,1:max(agg_memb));
div_hist = hist(div_memb,1:max(div_memb));

memberships = [ k_memb agg_memb div_memb ];
cvis = [ k_cvi agg_cvi div_cvi ];
hists = [ k_hist ; agg_hist ; div_hists ];