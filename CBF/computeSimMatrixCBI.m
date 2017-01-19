function [simMat] = computeSimMatrixCBI( icm, icmActive, items, itemsActive, norms, normsActive )
%COMPUTESIMMATRIXCBI Summary of this function goes here
%   I'll pick just the interacted items as icm

simMat = containers.Map('KeyType', 'double', 'ValueType', 'any');

idx = 1;

for i = items'
    
    tic
    %tags in i
    tags = find(icm(idx,:));
    
    [row,~,~] = find(icmActive(:,tags));
    itemsCommonTagIdx = [];
    
    %Indexes of the items with at least one tag in common with i
    for j = unique(row)'
        
        if nnz(icmActive(j,tags)) > 2
            %Indexes of items from icmActive with at least 3 common tag with i
            itemsCommonTagIdx = [itemsCommonTagIdx j];
        end
    end
    
    %mostSimItemsIdToIdx(i) = itemsCommonTagIdx;
    
    a = icm(idx,:) * icmActive(itemsCommonTagIdx,:)';
    
    for j = 1:numel(itemsCommonTagIdx)
        
        a(j) = a(j)/(norms(idx) * normsActive(itemsCommonTagIdx(j)) + 20);
        
    end
    
    [sim, ia] = sort(a,'descend');
    
    simMat(i) = [itemsActive(itemsCommonTagIdx(ia)) sim'];
    
    idx = idx + 1;
    
    toc
    
end

end

