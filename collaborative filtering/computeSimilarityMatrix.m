function D = computeSimilarityMatrix( URM, itemprofiles)
%COMPUTESIMILARITYMATRIX Summary of this function goes here
%   Detailed explanation goes here
% ~
    D = containers.Map('KeyType', 'double', 'ValueType', 'any');
%     result = zeros(1, 167956);
    for i=1:size(URM,2)
        userRatedItemi = find(URM(:,i) ~= 0);
        for(j=1:size(userRatedItemi,1))
            itemsRatedFromUsers = find(URM(userRatedItemi(j),:) ~= 0);
            sim = zeros(size(itemsRatedFromUsers,2),1);
            for k=1:size(itemsRatedFromUsers,2) 
                if(itemsRatedFromUsers(1,k)~= i)
                     sim(k) = computeSimilarityAssociationRule(i, itemsRatedFromUsers(k), URM);
                end
            end
            [sims, id] = sort(sim, 'descend');
            sims(min(size(itemsRatedFromUsers,2),60)+1:end) = [];
            id(min(size(itemsRatedFromUsers,2),60)+1:end) = [];
            value = {itemsRatedFromUsers(id), sims};
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

