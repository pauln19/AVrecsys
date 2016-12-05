function [sim] = computeSimilarityAssociationRule(indexItem1, indexItem2, URM)

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

sim = URM(:,indexItem1)'* ...
    URM(:,indexItem2) ...
    / ((sum(URM(:,indexItem2)) *...
    sum(URM(:,indexItem1))));

% % Cosine
%  sim = URM(:,indexItem1)'* ...
%             URM(:,indexItem2) ...
%             / (norm(URM(:,indexItem1)) * norm(URM(:,indexItem2)) + 2);

end