function [] = YiFanHu( URM, lambda, f )
%UNTITLED Summary of this function goes here
%   m = number of users
%   n = number of items
%   y = item factor vector
%   x = user factor vector

Y = rand(size(URM,2),f);
X = zeros(size(URM,1),f);

parfor u = 1:size(URM,1)
    
    tic
    
    C_u = diag(URM(u,:));
    p = double(logical(URM(u,:)))';
    X(u,:) = (Y'*C_u*Y + lambda * eye(f)).^-1 * Y'*C_u*p;
    
    toc
    
end

end

