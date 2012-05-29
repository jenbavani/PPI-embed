function u = symmetrize(Sim)
%SYMMETRIZE   Symmetrize a matrix.
%   U = SYMMETRIZE(S) takes the square matrix, S, and symmetrizes
%   it such that S(i,j) == S(j,i) and S(i,i) == 0.
%   The greater of any conflicting values is used.

% [m,n] = size(Sim);

u = triu(Sim,1);
l = tril(Sim,-1)';

u(u<l) = l(u<l);
% Sim(u<l) = l(l>u);

u = u + u';

% u(u~=l)
% Sim = Sim(Sim==0);
% 
% bad = Sim'-Sim;
% bad = bad > 0;
% Sim = Sim(bad);
% badT = bad(bad>0); % 1 for bigger top half
% badB = bad(bad<0); % 1 for bigger bottom half
% badB = tril(bad,-1);
% badT = triu(bad,1);

% bigB = badB(badB>0); % 
% bigT = badT>0;

% Sim(~bigT) = Sim(bigT);

