function x = cmds(d,dim,flag)

if nargin == 2
    flag = 'eigenvalue';
end

d = d.^2;
d = doubleCenter(d);
d = d .* -0.5;

switch flag
    case 'torgerson'
        [u,s,~] = svds(d,dim);
        x = u * s.^0.5;
    case 'eigenvalue'
        % [V,E] = eig(d);
        [V,E] = eigs(d,dim);
        % E = E(1:dim,1:dim);
        E = diag(E);
%         E(E>0) = E(E>0).^0.5;
%         E = E - min(E);
%         E = E / max(E(:));
%         E = sqrt(E);

%         imask = E < 0;
%         E(~imask) = sqrt( E(~imask) );
%         E(imask) = - sqrt( abs( E(imask) ) );

        E = sign(E) .* sqrt( abs( E ) );

        x = V(:,1:dim) .* repmat(E',size(d,1),1);
end
end

function d = doubleCenter(d)
d = d - repmat(mean(d),size(d,1),1);
d = d - repmat(mean(d,2),1,size(d,1));
end