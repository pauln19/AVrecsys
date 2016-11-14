function [sim] = computeSimilarityAssociationRule(item1, item2)

% load('interactions.mat');
% % users who interacted with item2
% vector = unique(interactions(interactions(:,2) == item2,1));
% 
% % # users who interacted with both item1 and item2 / #users who interacted
% % with item2
% sim = numel(intersect(interactions(interactions(:,2) == item1,1),vector)) / (numel(vector) + 3);

load('itemMap.mat');
load('urm.mat');

indexItem1 = values(itemMap,num2cell(item1));
indexItem2 = values(itemMap,num2cell(item2));

sim = sum(bitand(full(logical(URM(:,cell2mat(indexItem1)))), ...
    full(logical(URM(:,cell2mat(indexItem2))))));
    %/ sum(logical(URM(:,cell2mat(indexItem2))));

end