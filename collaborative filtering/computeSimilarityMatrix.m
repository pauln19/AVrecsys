function D = computeSimilarityMatrix( URM)
%COMPUTESIMILARITYMATRIX Summary of this function goes here
%   Detailed explanation goes here
% ~
D = containers.Map('KeyType', 'double', 'ValueType', 'any');

%     result = zeros(1, 167956);
%   Loop on every item on the URM
for i=1:size(URM,2)
    %   Pick for item /i\ the users' indexes which has rated it
    usersRatedItemi = find(URM(:,i) ~= 0);
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
        [sims, id] = sort(sim, 'descend');
        sims(min(size(itemsRatedFromUsers,2),60)+1:end) = [];
        id(min(size(itemsRatedFromUsers,2),60)+1:end) = [];
        value = {itemsRatedFromUsers(id)', sims};
        D(i) = value;
        %D(i) = [sims, itemRatedFromUsers(id)]};
        %result = pdist2(URM(:,i), URM(:,itemsRatedFromUsers), 'cosine');
    end
    %         if (any(URM(:,i) == 0))
    %            result = pdist2(URM(:,i).', URM.', 'cosine');
    %            [result, index] = sort(result, 'descend');
    %            D{i,:} = {itemprofiles(index), result};
    %         end
end

end

