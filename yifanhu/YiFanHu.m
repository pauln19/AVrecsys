function [] = YiFanHu( URM, lambda, f, targetUserIndex, sweep )
%UNTITLED Summary of this function goes here
%   f = number of latent factors
%   m = number of users
%   n = number of items
%   y = item factor vector
%   x = user factor vector
%   lambda = learning factor

%   I don't compute confidence matrix since is m x n

sizeY_URM = size(URM,2);
sizeX_URM = size(URM,1);

Y = rand(sizeY_URM,f);
X = zeros(sizeX_URM,f);

I_X = speye(sizeX_URM);
I_Y = speye(sizeY_URM);
I_f = eye(f);

URM = double(logical(URM));

%   Loop for *sweep* times
for n = 1:sweep

%   Constant for the internal loop on users
A = Y' * Y;

%   Loop supposely on all users, but we can use just the targets
for u = targetUserIndex'
    
%   Check if the error is decreasing
%     err = zeros(1,sizeY_URM);
%     delta = zeros(1,sizeY_URM);
%     for i = 1:sizeY_URM
%         err(i) = abs(double(logical(URM(u,i))) - X(u,:) * Y(i,:)');
%     end
    tic
    
    C_u = I_Y + 40 * diag(URM(u,:));
    X(u,:) = (A + Y' * (C_u - I_Y) * Y + lambda * I_f)^-1 * Y' * C_u * URM(u,:)';
    
    toc
    
%     for i = 1:sizeY_URM
%         delta(i) = err(i) - abs(double(logical(URM(u,i))) - X(u,:) * Y(i,:)');
%     end
    
end

%   Constant for the internal loop on users
B = X' * X;

%   Loop on all items
for i = 1:sizeY_URM
    
    tic
    
    C_i = I_X + 40 * diag(URM(:,i));
    Y(:,i) = inv(B + X' * (C_i - I_X) * X + lambda * I_f) * X' * C_i * URM(:,i)';
    
    toc
    
end

end

%TODO
% Prendere i X_u' * Y_i e vedere quelli pi� alti per u: le i corrispondenti
% sono quelli da consigliare

end