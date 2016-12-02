function D = computeSimilarityMatrix( URM, itemprofiles)
%COMPUTESIMILARITYMATRIX Summary of this function goes here
%   Detailed explanation goes here
% ~
    URM = logical(URM);
    D = containers.Map;
%     result = zeros(1, 167956);
%   Loop on items
    for i=1:size(URM,2)
        %   Index of users who rated item i
        userRatedItems = find(URM(:,i) ~= 0);
        %   Loop on previous users
        for j=1:size(userRatedItems,1)
            %   Index of items rated by user j
            itemsRatedFromUsers = find(URM(userRatedItems(j),:) ~= 0);
            sim = zeros(size(itemsRatedFromUsers,2),1);
            %   Loop on previous items
            for k=1:size(itemsRatedFromUsers,2)
                if(itemsRatedFromUsers(1,k)~= i)
                     sim(k) = computeSimilarityAssociationRule(i, itemsRatedFromUsers(k), URM);
                end
            end
            [sims, id] = sort(sim, 'descend');
            sims(min(size(itemsRatedFromUsers,2),60):end) = []
            id(min(size(itemsRatedFromUsers,2),60):end) = []
            
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

