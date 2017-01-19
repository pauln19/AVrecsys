function D = computeSimilarityMatrix(URM)
%COMPUTESIMILARITYMATRIX Summary of this function goes here
%   Detailed explanation goes here
% ~
D = containers.Map('KeyType', 'double', 'ValueType', 'any');

%   Loop on every item on the URM
for i=1:size(URM,2)
    tic
    %   Pick for item /i\ the users' indexes which has rated it
    usersRatedItemi = find(URM(:,i) ~= 0);
    value = [];
    %   Loop on the user indexes
    for j=1:size(usersRatedItemi,1)
        %   Pick indexes of items rated by those users
        itemsRatedFromUsers = find(URM(usersRatedItemi(j),:) ~= 0);
        itemsRatedFromUsers = itemsRatedFromUsers(itemsRatedFromUsers ~= i);
        sim = zeros(numel(itemsRatedFromUsers),1);
        %   Loop on those items
        for k=1:size(itemsRatedFromUsers,2)
            sim(k) = computeSimilarityAssociationRule(i, itemsRatedFromUsers(k), URM);
        end
        value = [value; itemsRatedFromUsers', sim];
    end
    
    if ~isempty(value)
        
        [uv,~,idx] = unique(value(:,1));
        v = accumarray(idx,value(:,2),[],@max);
        value = [uv v];
        
        [sims, idx] = sort(value(:,2), 'descend');
        
        D(i) = [value(idx,1) sims];
    end
    
    toc
    
end

end

