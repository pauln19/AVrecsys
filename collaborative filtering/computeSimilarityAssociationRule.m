function [sim] = computeSimilarityAssociationRule(item1, item2, ~, URM)

% load('interactions.mat');
% % users who interacted with item2
% vector = unique(interactions(interactions(:,2) == item2,1));
% 
% % # users who interacted with both item1 and item2 / #users who interacted
% % with item2
% sim = numel(intersect(interactions(interactions(:,2) == item1,1),vector)) / (numel(vector) + 3);

% indexItem1 = cell2mat(values(itemMap,num2cell(item1)));
% indexItem2 = cell2mat(values(itemMap,num2cell(item2)));

% sim = dot(URM(:,indexItem1), ...
%     URM(:,indexItem2)) ...
%     / (sum(URM(:,indexItem2)) + 2);

sim = dot(URM(:,item1), ...
    URM(:,item2)) ...
    / (sum(URM(:,item2)) + 2);

% sim = sum(bitand(full(URM(:,indexItem1)), ...
%     full(URM(:,indexItem2)))) ...
%     / (sum(URM(:,indexItem2)) + 2);

end