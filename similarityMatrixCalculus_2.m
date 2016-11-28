load('urm_available.mat');

weuc = @(XI,XJ)(sum(bitand(full(logical(XI)),full(logical(XJ)))) / ...
    sum(logical(XJ)) + 2);

D = pdist(URM(:,1:10000).', @(Xi,Xj) weuc(Xi,Xj));