function [simMat] = computeSimMatrixCBI( icm, itemsAvailable, norms )
%COMPUTESIMMATRIXCBI Summary of this function goes here
%   I'll pick just the active items as icm

simMat = containers.Map('KeyType', 'double', 'ValueType', 'any');

idx = 1;

for i = itemsAvailable(:,1)'
    tic
    a = icm(idx,:) * icm(idx+1:end,:)';
    
    for j = idx+1:size(icm,1)
        
        a(j-idx) = a(j-idx)/(norms(idx) * norms(j) + 20);
        
    end
    
    simMat(i) = [itemsAvailable(idx+1:end,1) a'];
    
    idx = idx + 1;
    toc
end

end

